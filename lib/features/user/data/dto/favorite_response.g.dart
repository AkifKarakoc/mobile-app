// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteResponse _$FavoriteResponseFromJson(Map<String, dynamic> json) =>
    _FavoriteResponse(
      id: json['id'] as String,
      placeId: json['placeId'] as String,
      savedAt: DateTime.parse(json['savedAt'] as String),
    );

Map<String, dynamic> _$FavoriteResponseToJson(_FavoriteResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'savedAt': instance.savedAt.toIso8601String(),
    };
