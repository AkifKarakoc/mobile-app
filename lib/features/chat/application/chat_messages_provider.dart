import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/chat/data/chat_repository.dart';
import 'package:mobile/features/chat/data/dto/chat_response.dart';

class ChatMessagesNotifier
    extends FamilyAsyncNotifier<List<ChatResponse>, String> {
  static const typingRole = 'assistant_typing';

  ChatRepository? _repository;
  Object? _lastSendError;

  Object? get lastSendError => _lastSendError;

  @override
  Future<List<ChatResponse>> build(String sessionId) async {
    _repository ??= ref.watch(chatRepositoryProvider);
    return _repository!.getMessages(sessionId);
  }

  Future<void> sendMessage(
    String content, {
    double? latitude,
    double? longitude,
  }) async {
    final sessionId = arg;
    if (content.trim().isEmpty) return;
    _lastSendError = null;

    final optimisticMessage = ChatResponse(
      role: 'user',
      content: content,
      sentAt: DateTime.now().toIso8601String(),
    );
    final typingMessage = ChatResponse(
      role: typingRole,
      content: '',
      sentAt: DateTime.now().toIso8601String(),
    );

    final previousMessages = state.valueOrNull ?? [];
    state = AsyncValue.data([
      ...previousMessages,
      optimisticMessage,
      typingMessage,
    ]);

    try {
      final response = await _repository!.sendMessage(
        sessionId,
        content,
        latitude: latitude,
        longitude: longitude,
      );
      final currentMessages = state.valueOrNull ?? [];
      state = AsyncValue.data([
        ...currentMessages.where((message) => message.role != typingRole),
        response,
      ]);
    } catch (e, st) {
      _lastSendError = e;
      state = AsyncValue.data(previousMessages);
      Error.throwWithStackTrace(e, st);
    }
  }

  Future<void> deleteSession() async {
    final sessionId = arg;
    try {
      await _repository!.deleteSession(sessionId);
      state = const AsyncValue.data([]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final chatMessagesProvider =
    AsyncNotifierProvider.family<
      ChatMessagesNotifier,
      List<ChatResponse>,
      String
    >(ChatMessagesNotifier.new);
