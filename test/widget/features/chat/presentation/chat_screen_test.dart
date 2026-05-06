import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_text_field.dart';
import 'package:mobile/features/chat/data/chat_repository.dart';
import 'package:mobile/features/chat/data/dto/chat_response.dart';
import 'package:mobile/features/chat/presentation/chat_screen.dart';
import 'package:mobile/features/chat/presentation/widgets/message_bubble.dart';
import 'package:mobile/features/chat/presentation/widgets/typing_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../test_helpers/pump_app.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockChatRepository chatRepository;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    chatRepository = MockChatRepository();
  });

  List<Override> overrides() {
    return [
      chatRepositoryProvider.overrideWithValue(chatRepository),
    ];
  }

  group('ChatScreen Widget Tests', () {
    testWidgets('renders AppBar and message input area', (
      WidgetTester tester,
    ) async {
      when(
        () => chatRepository.getMessages('test-session'),
      ).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const ChatScreen(sessionId: 'test-session'),
        overrides: overrides(),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(AppTextField), findsOneWidget);
      expect(find.byType(AppButton), findsOneWidget);
    });

    testWidgets('renders empty message list when no messages', (
      WidgetTester tester,
    ) async {
      when(
        () => chatRepository.getMessages('test-session'),
      ).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const ChatScreen(sessionId: 'test-session'),
        overrides: overrides(),
      );

      expect(find.byType(MessageBubble), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('renders user and AI message bubbles', (
      WidgetTester tester,
    ) async {
      final messages = [
        const ChatResponse(
          role: 'user',
          content: 'Merhaba',
          sentAt: '2026-05-05T10:00:00',
        ),
        const ChatResponse(
          role: 'assistant',
          content: 'Selam! Size nasıl yardımcı olabilirim?',
          sentAt: '2026-05-05T10:00:01',
        ),
      ];

      when(
        () => chatRepository.getMessages('test-session'),
      ).thenAnswer((_) async => messages);

      await pumpAppWidget(
        tester,
        child: const ChatScreen(sessionId: 'test-session'),
        overrides: overrides(),
      );

      expect(find.byType(MessageBubble), findsNWidgets(2));
      expect(find.text('Merhaba'), findsOneWidget);
      expect(find.text('Selam! Size nasıl yardımcı olabilirim?'), findsOneWidget);
    });

    testWidgets('displays error state when provider fails', (
      WidgetTester tester,
    ) async {
      when(
        () => chatRepository.getMessages('test-session'),
      ).thenThrow(Exception('network error'));

      await pumpAppWidget(
        tester,
        child: const ChatScreen(sessionId: 'test-session'),
        overrides: overrides(),
      );

      expect(find.byType(AppButton), findsAtLeast(1));
    });

    testWidgets('send button is disabled when input is empty', (
      WidgetTester tester,
    ) async {
      when(
        () => chatRepository.getMessages('test-session'),
      ).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const ChatScreen(sessionId: 'test-session'),
        overrides: overrides(),
      );

      final button = tester.widget<AppButton>(find.byType(AppButton));
      expect(button.onPressed, isNull);
    });
  });

  group('MessageBubble Widget Tests', () {
    testWidgets('renders user message', (WidgetTester tester) async {
      await pumpAppWidget(
        tester,
        child: const MessageBubble(
          message: ChatResponse(
            role: 'user',
            content: 'Test mesaj',
            sentAt: '2026-05-05T10:00:00',
          ),
          isUser: true,
        ),
      );

      expect(find.text('Test mesaj'), findsOneWidget);
    });

    testWidgets('renders AI message with icon', (WidgetTester tester) async {
      await pumpAppWidget(
        tester,
        child: const MessageBubble(
          message: ChatResponse(
            role: 'assistant',
            content: 'AI yanıtı',
            sentAt: '2026-05-05T10:00:00',
          ),
          isUser: false,
        ),
      );

      expect(find.text('AI yanıtı'), findsOneWidget);
      expect(find.byIcon(Icons.smart_toy_outlined), findsOneWidget);
    });
  });

  group('TypingIndicator Widget Tests', () {
    testWidgets('renders typing indicator', (WidgetTester tester) async {
      await pumpAppWidget(
        tester,
        child: const TypingIndicator(),
        settle: false,
      );

      expect(find.byIcon(Icons.smart_toy_outlined), findsOneWidget);
    });
  });
}
