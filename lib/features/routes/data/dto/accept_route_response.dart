import 'package:freezed_annotation/freezed_annotation.dart';

part 'accept_route_response.freezed.dart';
part 'accept_route_response.g.dart';

@freezed
abstract class AcceptRouteResponse with _$AcceptRouteResponse {
  const factory AcceptRouteResponse({
    required String userRouteId,
    required String routeId,
    required String status,
    required String startedAt,
  }) = _AcceptRouteResponse;

  factory AcceptRouteResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptRouteResponseFromJson(json);
}
