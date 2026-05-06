import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mobile/features/chat/data/dto/chat_response.dart';
import 'package:mobile/features/chat/data/dto/chat_session_response.dart';
import 'package:mobile/features/chat/data/dto/send_message_request.dart';

part 'chat_api.g.dart';

@RestApi()
abstract class ChatApi {
  factory ChatApi(Dio dio, {String baseUrl}) = _ChatApi;

  @GET('/chat/sessions')
  Future<List<ChatSessionResponse>> getSessions();

  @POST('/chat/sessions')
  Future<ChatSessionResponse> createSession({
    @Body() required CreateSessionRequest request,
  });

  @GET('/chat/sessions/{sessionId}/messages')
  Future<List<ChatResponse>> getMessages({
    @Path('sessionId') required String sessionId,
  });

  @POST('/chat/sessions/{sessionId}/messages')
  Future<ChatResponse> sendMessage({
    @Path('sessionId') required String sessionId,
    @Body() required SendMessageRequest request,
  });

  @DELETE('/chat/sessions/{sessionId}')
  Future<void> deleteSession({
    @Path('sessionId') required String sessionId,
  });
}

class CreateSessionRequest {
  final String? language;

  CreateSessionRequest({this.language});

  Map<String, dynamic> toJson() =>
      {'language': language};
}
