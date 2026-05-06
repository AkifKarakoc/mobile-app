import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/chat/data/chat_api.dart';
import 'package:mobile/features/chat/data/chat_repository.dart';
import 'package:mobile/features/chat/data/dto/chat_response.dart';
import 'package:mobile/features/chat/data/dto/chat_session_response.dart';
import 'package:mobile/features/chat/data/dto/send_message_request.dart';

class MockChatApi extends Mock implements ChatApi {}

void main() {
  late MockChatApi mockApi;
  late ChatRepository repository;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/chat/sessions'));
    registerFallbackValue(SendMessageRequest(content: 'test'));
    registerFallbackValue(CreateSessionRequest());
  });

  setUp(() {
    mockApi = MockChatApi();
    repository = ChatRepositoryImpl(mockApi);
  });

  group('getSessions', () {
    test('returns sessions on successful API call', () async {
      final sessions = [
        ChatSessionResponse(
          sessionId: 'session-1',
          language: 'tr',
          startedAt: DateTime(2026, 5, 5, 10, 0),
        ),
      ];

      when(() => mockApi.getSessions()).thenAnswer((_) async => sessions);

      final result = await repository.getSessions();

      expect(result, equals(sessions));
      expect(result.single.language, equals('tr'));
      verify(() => mockApi.getSessions()).called(1);
    });

    test('throws NetworkException on connection timeout', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/chat/sessions'),
        type: DioExceptionType.connectionTimeout,
        message: 'Connection timeout',
      );

      when(() => mockApi.getSessions()).thenThrow(dioException);

      expect(
        () => repository.getSessions(),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('createSession', () {
    test('returns session on successful API call without language', () async {
      final session = ChatSessionResponse(
        sessionId: 'new-session',
        language: 'en',
        startedAt: DateTime(2026, 5, 5, 12, 0),
      );

      when(
        () => mockApi.createSession(request: any(named: 'request')),
      ).thenAnswer((_) async => session);

      final result = await repository.createSession();

      expect(result, equals(session));
      expect(result.sessionId, equals('new-session'));
      verify(
        () => mockApi.createSession(request: any(named: 'request')),
      ).called(1);
    });

    test('returns session on successful API call with language', () async {
      final session = ChatSessionResponse(
        sessionId: 'new-session-tr',
        language: 'tr',
        startedAt: DateTime(2026, 5, 5, 12, 0),
      );

      when(
        () => mockApi.createSession(request: any(named: 'request')),
      ).thenAnswer((_) async => session);

      final result = await repository.createSession(language: 'tr');

      expect(result, equals(session));
      verify(
        () => mockApi.createSession(request: any(named: 'request')),
      ).called(1);
    });

    test('throws NetworkException on connection error', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/chat/sessions'),
        type: DioExceptionType.connectionError,
        message: 'Connection error',
      );

      when(
        () => mockApi.createSession(request: any(named: 'request')),
      ).thenThrow(dioException);

      expect(
        () => repository.createSession(),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('getMessages', () {
    test('returns messages on successful API call', () async {
      final messages = [
        const ChatResponse(
          role: 'user',
          content: 'Merhaba',
          sentAt: '2026-05-05T10:01:00',
        ),
        const ChatResponse(
          role: 'assistant',
          content: 'Merhaba! Size nasıl yardımcı olabilirim?',
          sentAt: '2026-05-05T10:02:00',
        ),
      ];

      when(
        () => mockApi.getMessages(sessionId: 'session-1'),
      ).thenAnswer((_) async => messages);

      final result = await repository.getMessages('session-1');

      expect(result, equals(messages));
      expect(result.length, equals(2));
      expect(result.first.role, equals('user'));
      verify(() => mockApi.getMessages(sessionId: 'session-1')).called(1);
    });

    test('throws NotFoundException on 404 response', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(
          path: '/chat/sessions/nonexistent/messages',
        ),
        response: Response(
          requestOptions: RequestOptions(
            path: '/chat/sessions/nonexistent/messages',
          ),
          statusCode: 404,
        ),
        type: DioExceptionType.badResponse,
      );

      when(
        () => mockApi.getMessages(sessionId: 'nonexistent'),
      ).thenThrow(dioException);

      expect(
        () => repository.getMessages('nonexistent'),
        throwsA(isA<NotFoundException>()),
      );
    });
  });
}
