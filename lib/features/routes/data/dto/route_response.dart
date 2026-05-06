import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_response.freezed.dart';
part 'route_response.g.dart';

@freezed
abstract class RouteResponse with _$RouteResponse {
  const factory RouteResponse({
    required String id,
    required String name,
    String? description,
    required DateTime createdAt,
    required double centerLatitude,
    required double centerLongitude,
    required int radiusMeters,
    required int estimatedMinutes,
    required int expReward,
    String? thumbnailUrl,
    required int totalStops,
    required List<RoutePlaceResponse> places,
  }) = _RouteResponse;

  factory RouteResponse.fromJson(Map<String, dynamic> json) =>
      _$RouteResponseFromJson(json);
}

@freezed
abstract class RoutePlaceResponse with _$RoutePlaceResponse {
  const factory RoutePlaceResponse({
    required String placeId,
    required int stopOrder,
    required int estimatedMinutes,
    String? notes,
    double? latitude,
    double? longitude,
    String? placeName,
  }) = _RoutePlaceResponse;

  factory RoutePlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$RoutePlaceResponseFromJson(json);
}
