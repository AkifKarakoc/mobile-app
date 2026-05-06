import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/todos/data/dto/todo_request.dart';
import 'package:mobile/features/todos/data/dto/todo_response.dart';
import 'package:mobile/features/todos/data/dto/update_todo_request.dart';
import 'package:mobile/features/todos/data/todos_repository.dart';

class TodosNotifier extends AsyncNotifier<List<TodoResponse>> {
  late TodosRepository _repository;

  @override
  Future<List<TodoResponse>> build() async {
    _repository = ref.watch(todosRepositoryProvider);
    return _repository.getAll();
  }

  Future<void> loadTodos() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getAll());
  }

  Future<void> createTodo({required String note, String? placeId}) async {
    final previous = state.valueOrNull ?? [];
    state = const AsyncValue.loading();
    try {
      final todo = await _repository.create(
        TodoRequest(note: note, placeId: placeId),
      );
      state = AsyncValue.data([...previous, todo]);
    } catch (e) {
      state = AsyncValue.data(previous);
      rethrow;
    }
  }

  Future<void> toggleComplete(String id) async {
    final previous = state.valueOrNull;
    if (previous == null) return;

    final todo = previous.firstWhere((t) => t.id == id);
    final updated = todo.copyWith(isCompleted: !todo.isCompleted);
    final newList = previous.map((t) => t.id == id ? updated : t).toList();

    state = AsyncValue.data(newList);

    try {
      await _repository.update(
        id,
        UpdateTodoRequest(isCompleted: updated.isCompleted),
      );
    } catch (e) {
      state = AsyncValue.data(previous);
    }
  }

  Future<void> updateNote(String id, String note) async {
    final previous = state.valueOrNull;
    if (previous == null) return;

    final todo = previous.firstWhere((t) => t.id == id);
    final updated = todo.copyWith(note: note);
    final newList = previous.map((t) => t.id == id ? updated : t).toList();

    state = AsyncValue.data(newList);

    try {
      await _repository.update(id, UpdateTodoRequest(note: note));
    } catch (e) {
      state = AsyncValue.data(previous);
    }
  }

  Future<void> deleteTodo(String id) async {
    final previous = state.valueOrNull;
    if (previous == null) return;

    final newList = previous.where((t) => t.id != id).toList();
    state = AsyncValue.data(newList);

    try {
      await _repository.delete(id);
    } catch (e) {
      state = AsyncValue.data(previous);
    }
  }
}

final todosProvider =
    AsyncNotifierProvider<TodosNotifier, List<TodoResponse>>(
      TodosNotifier.new,
    );
