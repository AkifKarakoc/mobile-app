import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/favorites/data/dto/favorite_response.dart';
import 'package:mobile/features/favorites/data/favorites_repository.dart';

class FavoriteStatus {
  const FavoriteStatus({
    required this.isFavorited,
    required this.favoriteId,
    required this.favorite,
  });

  final bool isFavorited;
  final String? favoriteId;
  final FavoriteResponse? favorite;
}

class FavoritesNotifier
    extends AutoDisposeAsyncNotifier<List<FavoriteResponse>> {
  FavoritesRepository? _repository;

  @override
  FutureOr<List<FavoriteResponse>> build() {
    _repository ??= ref.watch(favoritesRepositoryProvider);
    return _repository!.getFavorites();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repository!.getFavorites);
  }

  Future<void> addFavorite(String placeId) async {
    try {
      final favorite = await _repository!.addFavorite(placeId);
      final currentFavorites = state.valueOrNull;
      if (currentFavorites == null) {
        await refresh();
        return;
      }

      state = AsyncValue.data([
        ...currentFavorites.where((item) => item.placeId != placeId),
        favorite,
      ]);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> removeFavorite(String favoriteId) async {
    try {
      await _repository!.removeFavorite(favoriteId);
      final currentFavorites = state.valueOrNull;
      if (currentFavorites == null) {
        await refresh();
        return;
      }

      state = AsyncValue.data(
        currentFavorites.where((item) => item.id != favoriteId).toList(),
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> toggleFavorite(
    String placeId, {
    required bool currentlyFavorited,
    String? favoriteId,
  }) async {
    if (!currentlyFavorited) {
      await addFavorite(placeId);
      return;
    }

    final idToRemove = favoriteId ?? _favoriteIdForPlace(placeId);
    if (idToRemove == null) {
      final error = ArgumentError.value(
        favoriteId,
        'favoriteId',
        'Removing a favorite requires the backend favorite id, not place id.',
      );
      state = AsyncValue.error(error, StackTrace.current);
      throw error;
    }

    await removeFavorite(idToRemove);
  }

  String? _favoriteIdForPlace(String placeId) {
    final favorites = state.valueOrNull;
    if (favorites == null) {
      return null;
    }

    for (final favorite in favorites) {
      if (favorite.placeId == placeId) {
        return favorite.id;
      }
    }

    return null;
  }
}

final favoritesProvider =
    AsyncNotifierProvider.autoDispose<
      FavoritesNotifier,
      List<FavoriteResponse>
    >(FavoritesNotifier.new);

final favoriteStatusProvider = Provider.autoDispose
    .family<AsyncValue<FavoriteStatus>, String>((ref, placeId) {
      final favorites = ref.watch(favoritesProvider);

      return favorites.whenData((items) {
        FavoriteResponse? matchedFavorite;
        for (final favorite in items) {
          if (favorite.placeId == placeId) {
            matchedFavorite = favorite;
            break;
          }
        }

        return FavoriteStatus(
          isFavorited: matchedFavorite != null,
          favoriteId: matchedFavorite?.id,
          favorite: matchedFavorite,
        );
      });
    });
