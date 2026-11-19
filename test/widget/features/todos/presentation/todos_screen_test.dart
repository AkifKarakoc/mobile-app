import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/widgets/shimmer_placeholder.dart';
import 'package:mobile/features/todos/data/dto/todo_response.dart';
import 'package:mobile/features/todos/data/todos_repository.dart';
import 'package:mobile/features/todos/presentation/todos_screen.dart';
import 'package:mobile/features/todos/presentation/widgets/todo_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../test_helpers/pump_app.dart';

class MockTodosRepository extends Mock implements TodosRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockTodosRepository todosRepository;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    todosRepository = MockTodosRepository();
  });

  List<Override> overrides() {
    return [
      todosRepositoryProvider.overrideWithValue(todosRepository),
    ];
  }

  group('TodosScreen', () {
    testWidgets('displays loading indicator while loading', (tester) async {
      final completer = Completer<List<TodoResponse>>();
      when(() => todosRepository.getAll()).thenAnswer((_) => completer.future);

      await pumpAppWidget(
        tester,
        child: const TodosScreen(),
        overrides: overrides(),
        settle: false,
      );

      expect(find.byType(ShimmerPlaceholder), findsWidgets);
      completer.complete([]);
      await tester.pump();
    });

    testWidgets('displays todo list when data loads', (tester) async {
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

      when(() => todosRepository.getAll()).thenAnswer((_) async => todos);

      await pumpAppWidget(
        tester,
        child: const TodosScreen(),
        overrides: overrides(),
      );

      expect(find.text('Kuleyi ziyaret et'), findsOneWidget);
      expect(find.text('Muzeyi gez'), findsOneWidget);
      expect(find.byType(TodoTile), findsNWidgets(2));
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('displays empty state when list is empty', (tester) async {
      when(() => todosRepository.getAll()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const TodosScreen(),
        overrides: overrides(),
      );

      expect(find.text('todos.empty_title'), findsOneWidget);
      expect(find.text('todos.empty_description'), findsOneWidget);
      expect(find.byIcon(Icons.checklist_outlined), findsOneWidget);
    });

    testWidgets('displays filter chips', (tester) async {
      when(() => todosRepository.getAll()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const TodosScreen(),
        overrides: overrides(),
      );

      expect(find.text('todos.all'), findsOneWidget);
      expect(find.text('todos.active'), findsOneWidget);
      expect(find.text('todos.completed'), findsOneWidget);
    });

    testWidgets('displays error view when provider fails', (tester) async {
      when(() => todosRepository.getAll()).thenThrow(Exception('network error'));

      await pumpAppWidget(
        tester,
        child: const TodosScreen(),
        overrides: overrides(),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('shows place link when todo has placeId', (tester) async {
      final todos = [
        TodoResponse(
          id: 'todo-1',
          placeId: 'place-1',
          note: 'Kuleyi ziyaret et',
          isCompleted: false,
          createdAt: DateTime(2026, 5, 5),
        ),
      ];

      when(() => todosRepository.getAll()).thenAnswer((_) async => todos);

      await pumpAppWidget(
        tester,
        child: const TodosScreen(),
        overrides: overrides(),
      );

      expect(find.text('todos.place_link'), findsOneWidget);
      expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
    });

    testWidgets('does not show place link when todo has no placeId', (
      tester,
    ) async {
      final todos = [
        TodoResponse(
          id: 'todo-1',
          placeId: null,
          note: 'Kuleyi ziyaret et',
          isCompleted: false,
          createdAt: DateTime(2026, 5, 5),
        ),
      ];

      when(() => todosRepository.getAll()).thenAnswer((_) async => todos);

      await pumpAppWidget(
        tester,
        child: const TodosScreen(),
        overrides: overrides(),
      );

      expect(find.text('todos.place_link'), findsNothing);
    });
  });
}
