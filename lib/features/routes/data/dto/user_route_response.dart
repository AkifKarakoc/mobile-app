import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_route_response.freezed.dart';
part 'user_route_response.g.dart';

@freezed
abstract class UserRouteResponse with _$UserRouteResponse {
  const factory UserRouteResponse({
    required String id,
    required String routeId,
    required String routeName,
    required String routeDescription,
    String? routeThumbnailUrl,
    required String status,
    required String startedAt,
    String? completedAt,
    required int totalStops,
  }) = _UserRouteResponse;

  factory UserRouteResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRouteResponseFromJson(json);
}
