import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/badges/data/badges_api.dart';
import 'package:mobile/features/badges/data/dto/badge_response.dart';

abstract class BadgesRepository {
  Future<List<BadgeResponse>> getAllBadges();

  Future<List<UserBadgeResponse>> getMyBadges();
}

class BadgesRepositoryImpl implements BadgesRepository {
  BadgesRepositoryImpl(this._api);

  final BadgesApi _api;

  @override
  Future<List<BadgeResponse>> getAllBadges() async {
    try {
      return await _api.getAllBadges();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<List<UserBadgeResponse>> getMyBadges() async {
    try {
      return await _api.getMyBadges();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
}

final badgesRepositoryProvider = Provider<BadgesRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final api = BadgesApi(dio);
  return BadgesRepositoryImpl(api);
});

ApiException _toApiException(DioException exception) {
  final error = exception.error;
  if (error is ApiException) {
    return error;
  }

  return ApiException.fromDio(exception);
}
