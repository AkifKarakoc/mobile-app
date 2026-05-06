// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceResponse _$PlaceResponseFromJson(Map<String, dynamic> json) =>
    _PlaceResponse(
      id: json['id'] as String,
      name: json['name'] as String?,
      nameTr: json['nameTr'] as String?,
      nameEn: json['nameEn'] as String?,
      category: json['category'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      photoUrl: json['photoUrl'] as String?,
      avgRating: (json['avgRating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      distance: (json['distance'] as num?)?.toDouble(),
      isFavorited: json['isFavorited'] as bool?,
    );

Map<String, dynamic> _$PlaceResponseToJson(_PlaceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'category': instance.category,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'photoUrl': instance.photoUrl,
      'avgRating': instance.avgRating,
      'reviewCount': instance.reviewCount,
      'distance': instance.distance,
      'isFavorited': instance.isFavorited,
    };
