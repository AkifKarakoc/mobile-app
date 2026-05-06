// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoResponse _$TodoResponseFromJson(Map<String, dynamic> json) =>
    _TodoResponse(
      id: json['id'] as String,
      placeId: json['placeId'] as String?,
      note: json['note'] as String,
      isCompleted: json['isCompleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$TodoResponseToJson(_TodoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'note': instance.note,
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
    };
