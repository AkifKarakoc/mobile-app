import 'package:dio/dio.dart';
import 'package:mobile/features/favorites/data/dto/add_favorite_request.dart';
import 'package:mobile/features/favorites/data/dto/favorite_response.dart';

class FavoritesApi {
  const FavoritesApi(this._dio);

  final Dio _dio;

  Future<List<FavoriteResponse>> getFavorites() async {
    final response = await _dio.get<List<dynamic>>('/users/me/favorites');
    final data = response.data ?? <dynamic>[];

    return data
        .map(
          (item) =>
              FavoriteResponse.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
  }

  Future<FavoriteResponse> addFavorite(AddFavoriteRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/users/me/favorites',
      data: request.toJson(),
    );
    final data = response.data;
    if (data == null) {
      throw const FormatException('Favorite response body is empty');
    }

    return FavoriteResponse.fromJson(data);
  }

  Future<void> removeFavorite(String favoriteId) async {
    await _dio.delete<void>('/users/me/favorites/$favoriteId');
  }
}
