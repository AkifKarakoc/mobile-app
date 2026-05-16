import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_response.freezed.dart';
part 'route_response.g.dart';

@freezed
abstract class RouteResponse with _$RouteResponse {
  const factory RouteResponse({
    required String id,
    required String name,
    String? description,
    DateTime? createdAt,
    required double centerLatitude,
    required double centerLongitude,
    required int radiusMeters,
    required int estimatedMinutes,
    required int expReward,
    String? thumbnailUrl,
    @Default(200) int gpsThresholdMeters,
    int? totalStops,
    String? userStatus,
    required List<RoutePlaceResponse> places,
  }) = _RouteResponse;

  factory RouteResponse.fromJson(Map<String, dynamic> json) =>
      _$RouteResponseFromJson(json);
}

@freezed
abstract class RoutePlaceResponse with _$RoutePlaceResponse {
  const factory RoutePlaceResponse({
    String? id,
    required String placeId,
    required int stopOrder,
    int? estimatedMinutes,
    String? notes,
    double? latitude,
    double? longitude,
    String? placeName,
    @Default(false) bool completed,
  }) = _RoutePlaceResponse;

  factory RoutePlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$RoutePlaceResponseFromJson(json);
}
