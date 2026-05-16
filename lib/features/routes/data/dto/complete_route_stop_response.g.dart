// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_route_stop_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteRouteStopResponse _$CompleteRouteStopResponseFromJson(
  Map<String, dynamic> json,
) => CompleteRouteStopResponse(
  stopId: json['stopId'] as String,
  routeCompleted: json['routeCompleted'] as bool,
  expEarned: (json['expEarned'] as num).toInt(),
  distance: (json['distance'] as num).toDouble(),
);

Map<String, dynamic> _$CompleteRouteStopResponseToJson(
  CompleteRouteStopResponse instance,
) => <String, dynamic>{
  'stopId': instance.stopId,
  'routeCompleted': instance.routeCompleted,
  'expEarned': instance.expEarned,
  'distance': instance.distance,
};
