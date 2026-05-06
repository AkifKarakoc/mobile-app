import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/features/places/data/places_repository.dart';
import 'package:mobile/features/places/data/recent_searches_storage.dart';

class PlaceSearchState {
  const PlaceSearchState({
    required this.query,
    required this.results,
    required this.recentSearches,
  });

  final String query;
  final AsyncValue<List<PlaceResponse>> results;
  final AsyncValue<List<String>> recentSearches;

  bool get hasQuery => query.trim().isNotEmpty;

  bool get isQueryTooShort =>
      hasQuery && query.trim().length < PlaceSearchNotifier.minQueryLength;

  PlaceSearchState copyWith({
    String? query,
    AsyncValue<List<PlaceResponse>>? results,
    AsyncValue<List<String>>? recentSearches,
  }) {
    return PlaceSearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }
}

class PlaceSearchNotifier extends AutoDisposeNotifier<PlaceSearchState> {
  PlaceSearchNotifier({this.debounceDuration = defaultDebounceDuration});

  static const minQueryLength = 2;
  static const defaultDebounceDuration = Duration(milliseconds: 350);

  final Duration debounceDuration;

  Timer? _debounceTimer;
  int _searchGeneration = 0;
  bool _isDisposed = false;

  @override
  PlaceSearchState build() {
    ref.onDispose(() {
      _isDisposed = true;
      _debounceTimer?.cancel();
    });

    unawaited(_loadRecentSearches());

    return const PlaceSearchState(
      query: '',
      results: AsyncValue.data([]),
      recentSearches: AsyncValue.loading(),
    );
  }

  void updateQuery(String query) {
    _debounceTimer?.cancel();
    _searchGeneration++;

    final trimmedQuery = query.trim();
    state = state.copyWith(query: query);

    if (trimmedQuery.isEmpty) {
      state = state.copyWith(results: const AsyncValue.data([]));
      return;
    }

    if (trimmedQuery.length < minQueryLength) {
      state = state.copyWith(results: const AsyncValue.data([]));
      return;
    }

    state = state.copyWith(results: const AsyncValue.loading());
    final generation = _searchGeneration;
    _debounceTimer = Timer(debounceDuration, () {
      unawaited(_performSearch(trimmedQuery, generation));
    });
  }

  Future<void> searchFromRecent(String query) async {
    _debounceTimer?.cancel();
    _searchGeneration++;
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      state = state.copyWith(query: query, results: const AsyncValue.data([]));
      return;
    }

    if (trimmedQuery.length < minQueryLength) {
      state = state.copyWith(query: query, results: const AsyncValue.data([]));
      return;
    }

    final generation = _searchGeneration;
    state = state.copyWith(query: query, results: const AsyncValue.loading());
    await _performSearch(trimmedQuery, generation);
  }

  Future<void> retry() async {
    final trimmedQuery = state.query.trim();
    if (trimmedQuery.length < minQueryLength) {
      return;
    }

    _debounceTimer?.cancel();
    _searchGeneration++;
    final generation = _searchGeneration;
    state = state.copyWith(results: const AsyncValue.loading());
    await _performSearch(trimmedQuery, generation);
  }

  void clearQuery() {
    _debounceTimer?.cancel();
    _searchGeneration++;
    state = state.copyWith(query: '', results: const AsyncValue.data([]));
  }

  Future<void> clearRecentSearches() async {
    state = state.copyWith(recentSearches: const AsyncValue.loading());
    try {
      final storage = await ref.read(recentSearchesStorageProvider.future);
      await storage.clear();
      if (_isDisposed) {
        return;
      }
      state = state.copyWith(recentSearches: const AsyncValue.data([]));
    } catch (error, stackTrace) {
      if (_isDisposed) {
        return;
      }
      state = state.copyWith(
        recentSearches: AsyncValue.error(error, stackTrace),
      );
    }
  }

  Future<void> rememberCurrentQuery() async {
    final trimmedQuery = state.query.trim();
    if (trimmedQuery.length < minQueryLength) {
      return;
    }

    await _saveRecentSearch(trimmedQuery);
  }

  Future<void> _performSearch(String query, int generation) async {
    if (query.length < minQueryLength) {
      return;
    }

    try {
      final results = await ref.read(placesRepositoryProvider).search(query);
      if (_isStale(generation)) {
        return;
      }

      state = state.copyWith(results: AsyncValue.data(results));
      await _saveRecentSearch(query);
    } catch (error, stackTrace) {
      if (_isStale(generation)) {
        return;
      }

      state = state.copyWith(results: AsyncValue.error(error, stackTrace));
    }
  }

  Future<void> _loadRecentSearches() async {
    try {
      final storage = await ref.read(recentSearchesStorageProvider.future);
      final recentSearches = await storage.getRecentSearches();
      if (_isDisposed) {
        return;
      }

      state = state.copyWith(recentSearches: AsyncValue.data(recentSearches));
    } catch (error, stackTrace) {
      if (_isDisposed) {
        return;
      }

      state = state.copyWith(
        recentSearches: AsyncValue.error(error, stackTrace),
      );
    }
  }

  Future<void> _saveRecentSearch(String query) async {
    try {
      final storage = await ref.read(recentSearchesStorageProvider.future);
      await storage.saveQuery(query);
      final recentSearches = await storage.getRecentSearches();
      if (_isDisposed) {
        return;
      }

      state = state.copyWith(recentSearches: AsyncValue.data(recentSearches));
    } catch (error, stackTrace) {
      if (_isDisposed) {
        return;
      }

      state = state.copyWith(
        recentSearches: AsyncValue.error(error, stackTrace),
      );
    }
  }

  bool _isStale(int generation) {
    return _isDisposed || generation != _searchGeneration;
  }
}

final placeSearchProvider =
    AutoDisposeNotifierProvider<PlaceSearchNotifier, PlaceSearchState>(
      PlaceSearchNotifier.new,
    );
