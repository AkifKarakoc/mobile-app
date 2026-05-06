import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_session_response.freezed.dart';
part 'chat_session_response.g.dart';

@freezed
abstract class ChatSessionResponse with _$ChatSessionResponse {
  const factory ChatSessionResponse({
    required String sessionId,
    required String language,
    required DateTime startedAt,
  }) = _ChatSessionResponse;

  factory ChatSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionResponseFromJson(json);
}
