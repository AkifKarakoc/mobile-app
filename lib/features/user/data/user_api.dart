import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dto/user_response.dart';
import 'dto/favorite_response.dart';
import 'dto/add_favorite_request.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  /// Get current user profile
  @GET('/users/me')
  Future<UserResponse> getProfile();

  /// Update current user profile
  @PATCH('/users/me')
  Future<UserResponse> updateProfile(@Body() Map<String, dynamic> request);

  /// Upload profile photo (multipart)
  @POST('/users/me/photo')
  @MultiPart()
  Future<UserResponse> uploadPhoto(@Part(name: 'file') MultipartFile file);

  /// Get user favorites list
  @GET('/users/me/favorites')
  Future<List<FavoriteResponse>> getFavorites();

  /// Add favorite place
  @POST('/users/me/favorites')
  Future<FavoriteResponse> addFavorite(@Body() AddFavoriteRequest request);

  /// Remove favorite by ID
  @DELETE('/users/me/favorites/{id}')
  Future<void> removeFavorite(@Path('id') String id);
}
