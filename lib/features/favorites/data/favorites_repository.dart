import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/favorites/data/dto/add_favorite_request.dart';
import 'package:mobile/features/favorites/data/dto/favorite_response.dart';
import 'package:mobile/features/favorites/data/favorites_api.dart';

abstract class FavoritesRepository {
  Future<List<FavoriteResponse>> getFavorites();
  Future<FavoriteResponse> addFavorite(String placeId);
  Future<void> removeFavorite(String favoriteId);
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl(this._api);

  final FavoritesApi _api;

  @override
  Future<List<FavoriteResponse>> getFavorites() async {
    try {
      return await _api.getFavorites();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    } catch (e) {
      throw ApiException.unknown('Failed to load favorites: $e');
    }
  }

  @override
  Future<FavoriteResponse> addFavorite(String placeId) async {
    try {
      return await _api.addFavorite(AddFavoriteRequest(placeId: placeId));
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    } catch (e) {
      throw ApiException.unknown('Failed to add favorite: $e');
    }
  }

  @override
  Future<void> removeFavorite(String favoriteId) async {
    try {
      await _api.removeFavorite(favoriteId);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    } catch (e) {
      throw ApiException.unknown('Failed to remove favorite: $e');
    }
  }
}

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  return FavoritesRepositoryImpl(FavoritesApi(dio));
});
