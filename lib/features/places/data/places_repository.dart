import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/features/places/data/places_api.dart';

abstract class PlacesRepository {
  Future<List<PlaceResponse>> getNearby({
    required double latitude,
    required double longitude,
    int? radius,
    int? limit,
    String? category,
  });

  Future<PlaceDetailResponse> getById(String id);

  Future<List<PlaceResponse>> search(String query);
}

class PlacesRepositoryImpl implements PlacesRepository {
  PlacesRepositoryImpl(this._api);

  final PlacesApi _api;

  @override
  Future<List<PlaceResponse>> getNearby({
    required double latitude,
    required double longitude,
    int? radius,
    int? limit,
    String? category,
  }) async {
    try {
      return await _api.getNearby(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
        limit: limit,
        category: category,
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<PlaceDetailResponse> getById(String id) async {
    try {
      return await _api.getById(id);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<List<PlaceResponse>> search(String query) async {
    try {
      return await _api.search(query);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
}

final placesRepositoryProvider = Provider<PlacesRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final api = PlacesApi(dio);
  return PlacesRepositoryImpl(api);
});

ApiException _toApiException(DioException exception) {
  final error = exception.error;
  if (error is ApiException) {
    return error;
  }

  return ApiException.fromDio(exception);
}
