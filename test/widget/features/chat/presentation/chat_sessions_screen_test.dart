import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/features/chat/data/chat_repository.dart';
import 'package:mobile/features/chat/data/dto/chat_session_response.dart';
import 'package:mobile/features/chat/presentation/chat_sessions_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../test_helpers/pump_app.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockChatRepository chatRepository;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    chatRepository = MockChatRepository();
  });

  List<Override> overrides() {
    return [
      chatRepositoryProvider.overrideWithValue(chatRepository),
    ];
  }

  group('ChatSessionsScreen', () {
    testWidgets('displays loading indicator while loading sessions', (
      tester,
    ) async {
      final completer = Completer<List<ChatSessionResponse>>();
      when(() => chatRepository.getSessions()).thenAnswer((_) => completer.future);

      await pumpAppWidget(
        tester,
        child: const ChatSessionsScreen(),
        overrides: overrides(),
        settle: false,
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      completer.complete([]);
      await tester.pump();
    });

    testWidgets('displays session list when data loads', (tester) async {
      final sessions = [
        ChatSessionResponse(
          sessionId: 'session-1',
          language: 'tr',
          startedAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        ChatSessionResponse(
          sessionId: 'session-2',
          language: 'en',
          startedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];

      when(() => chatRepository.getSessions()).thenAnswer((_) async => sessions);

      await pumpAppWidget(
        tester,
        child: const ChatSessionsScreen(),
        overrides: overrides(),
      );

      expect(find.text('chat.language_tr'), findsOneWidget);
      expect(find.text('chat.language_en'), findsOneWidget);
    });

    testWidgets('displays empty state when sessions list is empty', (
      tester,
    ) async {
      when(() => chatRepository.getSessions()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const ChatSessionsScreen(),
        overrides: overrides(),
      );

      expect(find.text('chat.empty_title'), findsOneWidget);
      expect(find.text('chat.empty_description'), findsOneWidget);
      expect(find.text('chat.start_chat'), findsOneWidget);
    });

    testWidgets('displays error view when sessions provider fails', (
      tester,
    ) async {
      when(() => chatRepository.getSessions()).thenThrow(Exception('network error'));

      await pumpAppWidget(
        tester,
        child: const ChatSessionsScreen(),
        overrides: overrides(),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('displays new session button in AppBar', (tester) async {
      when(() => chatRepository.getSessions()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const ChatSessionsScreen(),
        overrides: overrides(),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
