// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceImage _$PlaceImageFromJson(Map<String, dynamic> json) => _PlaceImage(
  id: json['id'] as String,
  imageUrl: json['imageUrl'] as String,
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$PlaceImageToJson(_PlaceImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
    };
