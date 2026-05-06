// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoRequest _$TodoRequestFromJson(Map<String, dynamic> json) => _TodoRequest(
  note: json['note'] as String,
  placeId: json['placeId'] as String?,
);

Map<String, dynamic> _$TodoRequestToJson(_TodoRequest instance) =>
    <String, dynamic>{'note': instance.note, 'placeId': instance.placeId};
