import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'dto/user_response.dart';
import 'dto/favorite_response.dart';
import 'dto/add_favorite_request.dart';
import 'dto/update_user_request.dart';
import 'user_api.dart';

/// User Repository interface
abstract class IUserRepository {
  Future<UserResponse> getProfile();
  Future<UserResponse> updateProfile(UpdateUserRequest request);
  Future<UserResponse> uploadPhoto(File file);
  Future<List<FavoriteResponse>> getFavorites();
  Future<FavoriteResponse> addFavorite(String placeId);
  Future<void> removeFavorite(String id);
}

/// User Repository implementation
class UserRepository implements IUserRepository {
  UserRepository(this._api);

  final UserApi _api;

  @override
  Future<UserResponse> getProfile() async {
    try {
      return await _api.getProfile();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<UserResponse> updateProfile(UpdateUserRequest request) async {
    try {
      return await _api.updateProfile(request.toJson());
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<UserResponse> uploadPhoto(File file) async {
    try {
      final multipartFile = MultipartFile.fromFileSync(
        file.path,
        filename: file.path.split('/').last,
      );
      return await _api.uploadPhoto(multipartFile);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    } catch (e) {
      throw ApiException.unknown('Failed to upload photo: $e');
    }
  }

  @override
  Future<List<FavoriteResponse>> getFavorites() async {
    try {
      return await _api.getFavorites();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<FavoriteResponse> addFavorite(String placeId) async {
    try {
      return await _api.addFavorite(AddFavoriteRequest(placeId: placeId));
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<void> removeFavorite(String id) async {
    try {
      await _api.removeFavorite(id);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}

/// Riverpod provider for UserRepository
final userRepositoryProvider = Provider<IUserRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final api = UserApi(dio);
  return UserRepository(api);
});
