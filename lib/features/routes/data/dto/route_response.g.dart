// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RouteResponse _$RouteResponseFromJson(Map<String, dynamic> json) =>
    _RouteResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      centerLatitude: (json['centerLatitude'] as num).toDouble(),
      centerLongitude: (json['centerLongitude'] as num).toDouble(),
      radiusMeters: (json['radiusMeters'] as num).toInt(),
      estimatedMinutes: (json['estimatedMinutes'] as num).toInt(),
      expReward: (json['expReward'] as num).toInt(),
      thumbnailUrl: json['thumbnailUrl'] as String?,
      gpsThresholdMeters: (json['gpsThresholdMeters'] as num?)?.toInt() ?? 200,
      totalStops: (json['totalStops'] as num?)?.toInt(),
      userStatus: json['userStatus'] as String?,
      places: (json['places'] as List<dynamic>)
          .map((e) => RoutePlaceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RouteResponseToJson(_RouteResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'centerLatitude': instance.centerLatitude,
      'centerLongitude': instance.centerLongitude,
      'radiusMeters': instance.radiusMeters,
      'estimatedMinutes': instance.estimatedMinutes,
      'expReward': instance.expReward,
      'thumbnailUrl': instance.thumbnailUrl,
      'gpsThresholdMeters': instance.gpsThresholdMeters,
      'totalStops': instance.totalStops,
      'userStatus': instance.userStatus,
      'places': instance.places,
    };

_RoutePlaceResponse _$RoutePlaceResponseFromJson(Map<String, dynamic> json) =>
    _RoutePlaceResponse(
      id: json['id'] as String?,
      placeId: json['placeId'] as String,
      stopOrder: (json['stopOrder'] as num).toInt(),
      estimatedMinutes: (json['estimatedMinutes'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      placeName: json['placeName'] as String?,
      completed: json['completed'] as bool? ?? false,
    );

Map<String, dynamic> _$RoutePlaceResponseToJson(_RoutePlaceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'stopOrder': instance.stopOrder,
      'estimatedMinutes': instance.estimatedMinutes,
      'notes': instance.notes,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'placeName': instance.placeName,
      'completed': instance.completed,
    };
