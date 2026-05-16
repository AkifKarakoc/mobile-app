import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/chat/data/chat_repository.dart';
import 'package:mobile/features/chat/data/dto/chat_session_response.dart';

class ChatSessionsNotifier extends AutoDisposeAsyncNotifier<List<ChatSessionResponse>> {
  ChatRepository? _repository;

  @override
  FutureOr<List<ChatSessionResponse>> build() {
    _repository ??= ref.watch(chatRepositoryProvider);
    return _loadSessions();
  }

  Future<List<ChatSessionResponse>> _loadSessions() {
    return _repository!.getSessions();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadSessions);
  }

  Future<void> createSession({String? language}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = await _repository!.createSession(language: language);
      final current = await _loadSessions();
      return [session, ...current];
    });
  }

  Future<void> deleteSession(String sessionId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repository!.deleteSession(sessionId);
      final current = await _loadSessions();
      return current.where((s) => s.sessionId != sessionId).toList();
    });
  }
}

final chatSessionsProvider =
    AsyncNotifierProvider.autoDispose<ChatSessionsNotifier, List<ChatSessionResponse>>(
      ChatSessionsNotifier.new,
    );
