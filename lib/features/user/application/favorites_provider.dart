import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/user/data/dto/favorite_response.dart';
import 'package:mobile/features/user/data/user_repository.dart';

/// Favorites notifier — manages user favorites list
class FavoritesNotifier
    extends AutoDisposeAsyncNotifier<List<FavoriteResponse>> {
  late final IUserRepository _repository;

  @override
  Future<List<FavoriteResponse>> build() async {
    _repository = ref.watch(userRepositoryProvider);
    return await _loadFavorites();
  }

  /// Load favorites list from API
  Future<List<FavoriteResponse>> _loadFavorites() async {
    return await _repository.getFavorites();
  }

  /// Reload favorites
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadFavorites());
  }

  /// Remove favorite by ID
  Future<void> removeFavorite(String id) async {
    try {
      await _repository.removeFavorite(id);
      // Refresh list after successful removal
      await refresh();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      rethrow;
    }
  }

  /// Add favorite (for Sprint 2 onwards — interface prepared)
  /// Will be called from Place detail screen
  Future<void> addFavorite(String placeId) async {
    try {
      await _repository.addFavorite(placeId);
      // Refresh list after successful addition
      await refresh();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      rethrow;
    }
  }
}

/// Favorites async notifier provider — auto-dispose
final favoritesProvider =
    AsyncNotifierProvider.autoDispose<
      FavoritesNotifier,
      List<FavoriteResponse>
    >(FavoritesNotifier.new);
