// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_route_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AcceptRouteResponse _$AcceptRouteResponseFromJson(Map<String, dynamic> json) =>
    _AcceptRouteResponse(
      userRouteId: json['userRouteId'] as String,
      routeId: json['routeId'] as String,
      status: json['status'] as String,
      startedAt: json['startedAt'] as String,
    );

Map<String, dynamic> _$AcceptRouteResponseToJson(
  _AcceptRouteResponse instance,
) => <String, dynamic>{
  'userRouteId': instance.userRouteId,
  'routeId': instance.routeId,
  'status': instance.status,
  'startedAt': instance.startedAt,
};
