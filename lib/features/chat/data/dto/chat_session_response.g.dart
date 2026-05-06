// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatSessionResponse _$ChatSessionResponseFromJson(Map<String, dynamic> json) =>
    _ChatSessionResponse(
      sessionId: json['sessionId'] as String,
      language: json['language'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
    );

Map<String, dynamic> _$ChatSessionResponseToJson(
  _ChatSessionResponse instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'language': instance.language,
  'startedAt': instance.startedAt.toIso8601String(),
};
