import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/todos/data/dto/todo_request.dart';
import 'package:mobile/features/todos/data/dto/todo_response.dart';
import 'package:mobile/features/todos/data/dto/update_todo_request.dart';
import 'package:mobile/features/todos/data/todos_api.dart';
import 'package:mobile/features/todos/data/todos_repository.dart';

class MockTodosApi extends Mock implements TodosApi {}

void main() {
  late MockTodosApi mockApi;
  late TodosRepository repository;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/todos'));
    registerFallbackValue(const TodoRequest(note: 'test'));
    registerFallbackValue(const UpdateTodoRequest());
  });

  setUp(() {
    mockApi = MockTodosApi();
    repository = TodosRepositoryImpl(mockApi);
  });

  group('TodosRepository', () {
    group('getAll', () {
      test('returns todos on successful API call', () async {
        final todos = [
          TodoResponse(
            id: 'todo-1',
            placeId: null,
            note: 'Kuleyi ziyaret et',
            isCompleted: false,
            createdAt: DateTime(2026, 5, 5),
          ),
          TodoResponse(
            id: 'todo-2',
            placeId: 'place-1',
            note: 'Muzeyi gez',
            isCompleted: true,
            createdAt: DateTime(2026, 5, 4),
          ),
        ];

        when(() => mockApi.getAll()).thenAnswer((_) async => todos);

        final result = await repository.getAll();

        expect(result, equals(todos));
        expect(result.first.isCompleted, isFalse);
        expect(result.last.isCompleted, isTrue);
        verify(() => mockApi.getAll()).called(1);
      });

      test('throws NetworkException on connection timeout', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          type: DioExceptionType.connectionTimeout,
          message: 'Connection timeout',
        );

        when(() => mockApi.getAll()).thenThrow(dioException);

        expect(
          () => repository.getAll(),
          throwsA(isA<NetworkException>()),
        );
      });

      test('throws NetworkException on connection error', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          type: DioExceptionType.connectionError,
          message: 'Connection error',
        );

        when(() => mockApi.getAll()).thenThrow(dioException);

        expect(
          () => repository.getAll(),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('create', () {
      test('returns created todo on successful API call', () async {
        const request = TodoRequest(note: 'Kuleyi ziyaret et', placeId: 'place-1');
        final created = TodoResponse(
          id: 'new-id',
          placeId: 'place-1',
          note: 'Kuleyi ziyaret et',
          isCompleted: false,
          createdAt: DateTime(2026, 5, 5),
        );

        when(() => mockApi.create(request)).thenAnswer((_) async => created);

        final result = await repository.create(request);

        expect(result, equals(created));
        expect(result.note, equals('Kuleyi ziyaret et'));
        expect(result.placeId, equals('place-1'));
        verify(() => mockApi.create(request)).called(1);
      });

      test('throws NetworkException on connection error', () async {
        const request = TodoRequest(note: 'Test');
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          type: DioExceptionType.connectionError,
          message: 'Connection error',
        );

        when(() => mockApi.create(request)).thenThrow(dioException);

        expect(
          () => repository.create(request),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('update', () {
      test('returns updated todo on successful API call', () async {
        const request = UpdateTodoRequest(isCompleted: true);
        final updated = TodoResponse(
          id: 'todo-1',
          placeId: null,
          note: 'Kuleyi ziyaret et',
          isCompleted: true,
          createdAt: DateTime(2026, 5, 5),
        );

        when(() => mockApi.update('todo-1', request)).thenAnswer((_) async => updated);

        final result = await repository.update('todo-1', request);

        expect(result, equals(updated));
        expect(result.isCompleted, isTrue);
        verify(() => mockApi.update('todo-1', request)).called(1);
      });

      test('throws NetworkException on connection error', () async {
        const request = UpdateTodoRequest(note: 'Updated');
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/todos/todo-1'),
          type: DioExceptionType.connectionError,
          message: 'Connection error',
        );

        when(() => mockApi.update('todo-1', request)).thenThrow(dioException);

        expect(
          () => repository.update('todo-1', request),
          throwsA(isA<NetworkException>()),
        );
      });
    });

    group('delete', () {
      test('completes successfully on 204 response', () async {
        when(() => mockApi.delete('todo-1')).thenAnswer((_) async {});

        await repository.delete('todo-1');

        verify(() => mockApi.delete('todo-1')).called(1);
      });

      test('throws NetworkException on connection error', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/todos/todo-1'),
          type: DioExceptionType.connectionError,
          message: 'Connection error',
        );

        when(() => mockApi.delete('todo-1')).thenThrow(dioException);

        expect(
          () => repository.delete('todo-1'),
          throwsA(isA<NetworkException>()),
        );
      });

      test('throws ServerException on 500 response', () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/todos/todo-1'),
          response: Response(
            requestOptions: RequestOptions(path: '/todos/todo-1'),
            statusCode: 500,
          ),
          type: DioExceptionType.badResponse,
        );

        when(() => mockApi.delete('todo-1')).thenThrow(dioException);

        expect(
          () => repository.delete('todo-1'),
          throwsA(isA<ServerException>()),
        );
      });
    });
  });
}
