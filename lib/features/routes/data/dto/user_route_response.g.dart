// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_route_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserRouteResponse _$UserRouteResponseFromJson(Map<String, dynamic> json) =>
    _UserRouteResponse(
      id: json['id'] as String,
      routeId: json['routeId'] as String,
      routeName: json['routeName'] as String?,
      routeDescription: json['routeDescription'] as String?,
      routeThumbnailUrl: json['routeThumbnailUrl'] as String?,
      status: json['status'] as String,
      startedAt: json['startedAt'] as String,
      completedAt: json['completedAt'] as String?,
      totalStops: (json['totalStops'] as num).toInt(),
    );

Map<String, dynamic> _$UserRouteResponseToJson(_UserRouteResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeId': instance.routeId,
      'routeName': instance.routeName,
      'routeDescription': instance.routeDescription,
      'routeThumbnailUrl': instance.routeThumbnailUrl,
      'status': instance.status,
      'startedAt': instance.startedAt,
      'completedAt': instance.completedAt,
      'totalStops': instance.totalStops,
    };
