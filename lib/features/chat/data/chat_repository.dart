import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/chat/data/chat_api.dart';
import 'package:mobile/features/chat/data/dto/chat_response.dart';
import 'package:mobile/features/chat/data/dto/chat_session_response.dart';
import 'package:mobile/features/chat/data/dto/send_message_request.dart';

export 'package:mobile/features/chat/data/chat_api.dart' show CreateSessionRequest;

abstract class ChatRepository {
  Future<List<ChatSessionResponse>> getSessions();

  Future<ChatSessionResponse> createSession({String? language});

  Future<List<ChatResponse>> getMessages(String sessionId);

  Future<ChatResponse> sendMessage(
    String sessionId,
    String content, {
    double? latitude,
    double? longitude,
  });

  Future<void> deleteSession(String sessionId);
}

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._api);

  final ChatApi _api;

  @override
  Future<List<ChatSessionResponse>> getSessions() async {
    try {
      return await _api.getSessions();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<ChatSessionResponse> createSession({String? language}) async {
    try {
      return await _api.createSession(
        request: CreateSessionRequest(language: language),
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<List<ChatResponse>> getMessages(String sessionId) async {
    try {
      return await _api.getMessages(sessionId: sessionId);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<ChatResponse> sendMessage(
    String sessionId,
    String content, {
    double? latitude,
    double? longitude,
  }) async {
    try {
      return await _api.sendMessage(
        sessionId: sessionId,
        request: SendMessageRequest(
          content: content,
          latitude: latitude,
          longitude: longitude,
        ),
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    try {
      return await _api.deleteSession(sessionId: sessionId);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
}

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final api = ChatApi(dio);
  return ChatRepositoryImpl(api);
});

ApiException _toApiException(DioException exception) {
  final error = exception.error;
  if (error is ApiException) {
    return error;
  }

  return ApiException.fromDio(exception);
}
