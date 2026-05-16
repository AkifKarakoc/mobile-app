import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/chat/data/chat_repository.dart';
import 'package:mobile/features/chat/data/dto/chat_response.dart';
import 'package:mobile/features/chat/data/dto/send_message_request.dart';

class ChatMessagesNotifier
    extends FamilyAsyncNotifier<List<ChatResponse>, String> {
  ChatRepository? _repository;

  @override
  Future<List<ChatResponse>> build(String sessionId) async {
    _repository ??= ref.watch(chatRepositoryProvider);
    return _repository!.getMessages(sessionId);
  }

  Future<void> sendMessage(String content) async {
    final sessionId = arg;
    if (content.trim().isEmpty) return;

    final optimisticMessage = ChatResponse(
      role: 'user',
      content: content,
      sentAt: DateTime.now().toIso8601String(),
    );

    state = AsyncValue.data([...state.value ?? [], optimisticMessage]);

    try {
      final response = await _repository!.sendMessage(
        sessionId,
        SendMessageRequest(content: content),
      );
      final currentMessages = state.value ?? [];
      state = AsyncValue.data([...currentMessages, response]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
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

final chatMessagesProvider = AsyncNotifierProvider.family<
    ChatMessagesNotifier, List<ChatResponse>, String>(
  ChatMessagesNotifier.new,
);
