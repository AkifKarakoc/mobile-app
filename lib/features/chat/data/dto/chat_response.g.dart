// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) =>
    _ChatResponse(
      role: json['role'] as String,
      content: json['content'] as String,
      sentAt: json['sentAt'] as String,
    );

Map<String, dynamic> _$ChatResponseToJson(_ChatResponse instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
      'sentAt': instance.sentAt,
    };
