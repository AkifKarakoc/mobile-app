// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_todo_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateTodoRequest _$UpdateTodoRequestFromJson(Map<String, dynamic> json) =>
    _UpdateTodoRequest(
      note: json['note'] as String?,
      isCompleted: json['isCompleted'] as bool?,
    );

Map<String, dynamic> _$UpdateTodoRequestToJson(_UpdateTodoRequest instance) =>
    <String, dynamic>{
      'note': instance.note,
      'isCompleted': instance.isCompleted,
    };
