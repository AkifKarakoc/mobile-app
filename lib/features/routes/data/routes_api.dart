import 'package:dio/dio.dart';
import 'package:mobile/features/routes/data/dto/accept_route_response.dart';
import 'package:mobile/features/routes/data/dto/complete_route_stop_response.dart';
import 'package:mobile/features/routes/data/dto/route_response.dart';
import 'package:mobile/features/routes/data/dto/user_route_response.dart';
import 'package:retrofit/retrofit.dart';

part 'routes_api.g.dart';

@RestApi()
abstract class RoutesApi {
  factory RoutesApi(Dio dio, {String baseUrl}) = _RoutesApi;

  @GET('/routes')
  Future<List<RouteResponse>> getAll({
    @Query('latitude') double? latitude,
    @Query('longitude') double? longitude,
  });

  @GET('/routes/{id}')
  Future<RouteResponse> getById(@Path('id') String id);

  @POST('/routes/{id}/accept')
  Future<AcceptRouteResponse> acceptRoute(@Path('id') String id);

  @GET('/user/routes')
  Future<List<UserRouteResponse>> getUserRoutes();

  @POST('/user/routes/{routeId}/stops/{routePlaceId}/complete')
  Future<CompleteRouteStopResponse> completeRouteStop(
    @Path('routeId') String routeId,
    @Path('routePlaceId') String routePlaceId,
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
  );
}
