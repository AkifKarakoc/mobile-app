import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/routes/data/dto/accept_route_response.dart';
import 'package:mobile/features/routes/data/dto/route_response.dart';
import 'package:mobile/features/routes/data/dto/user_route_response.dart';
import 'package:mobile/features/routes/data/routes_api.dart';

abstract class RoutesRepository {
  Future<List<RouteResponse>> getAll({
    double? latitude,
    double? longitude,
  });

  Future<RouteResponse> getById(String id);

  Future<AcceptRouteResponse> acceptRoute(String id);

  Future<List<UserRouteResponse>> getUserRoutes();
}

class RoutesRepositoryImpl implements RoutesRepository {
  RoutesRepositoryImpl(this._api);

  final RoutesApi _api;

  @override
  Future<List<RouteResponse>> getAll({
    double? latitude,
    double? longitude,
  }) async {
    try {
      return await _api.getAll(
        latitude: latitude,
        longitude: longitude,
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<RouteResponse> getById(String id) async {
    try {
      return await _api.getById(id);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<AcceptRouteResponse> acceptRoute(String id) async {
    try {
      return await _api.acceptRoute(id);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<List<UserRouteResponse>> getUserRoutes() async {
    try {
      return await _api.getUserRoutes();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
}

final routesRepositoryProvider = Provider<RoutesRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final api = RoutesApi(dio);
  return RoutesRepositoryImpl(api);
});

ApiException _toApiException(DioException exception) {
  final error = exception.error;
  if (error is ApiException) {
    return error;
  }

  return ApiException.fromDio(exception);
}
