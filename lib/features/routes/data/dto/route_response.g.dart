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
      createdAt: DateTime.parse(json['createdAt'] as String),
      centerLatitude: (json['centerLatitude'] as num).toDouble(),
      centerLongitude: (json['centerLongitude'] as num).toDouble(),
      radiusMeters: (json['radiusMeters'] as num).toInt(),
      estimatedMinutes: (json['estimatedMinutes'] as num).toInt(),
      expReward: (json['expReward'] as num).toInt(),
      thumbnailUrl: json['thumbnailUrl'] as String?,
      totalStops: (json['totalStops'] as num).toInt(),
      places: (json['places'] as List<dynamic>)
          .map((e) => RoutePlaceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RouteResponseToJson(_RouteResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'centerLatitude': instance.centerLatitude,
      'centerLongitude': instance.centerLongitude,
      'radiusMeters': instance.radiusMeters,
      'estimatedMinutes': instance.estimatedMinutes,
      'expReward': instance.expReward,
      'thumbnailUrl': instance.thumbnailUrl,
      'totalStops': instance.totalStops,
      'places': instance.places,
    };

_RoutePlaceResponse _$RoutePlaceResponseFromJson(Map<String, dynamic> json) =>
    _RoutePlaceResponse(
      placeId: json['placeId'] as String,
      stopOrder: (json['stopOrder'] as num).toInt(),
      estimatedMinutes: (json['estimatedMinutes'] as num).toInt(),
      notes: json['notes'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      placeName: json['placeName'] as String?,
    );

Map<String, dynamic> _$RoutePlaceResponseToJson(_RoutePlaceResponse instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'stopOrder': instance.stopOrder,
      'estimatedMinutes': instance.estimatedMinutes,
      'notes': instance.notes,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'placeName': instance.placeName,
    };
