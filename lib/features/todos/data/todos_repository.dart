import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/todos/data/dto/todo_request.dart';
import 'package:mobile/features/todos/data/dto/todo_response.dart';
import 'package:mobile/features/todos/data/dto/update_todo_request.dart';
import 'package:mobile/features/todos/data/todos_api.dart';

abstract class TodosRepository {
  Future<List<TodoResponse>> getAll();

  Future<TodoResponse> create(TodoRequest request);

  Future<TodoResponse> update(String id, UpdateTodoRequest request);

  Future<void> delete(String id);
}

class TodosRepositoryImpl implements TodosRepository {
  TodosRepositoryImpl(this._api);

  final TodosApi _api;

  @override
  Future<List<TodoResponse>> getAll() async {
    try {
      return await _api.getAll();
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<TodoResponse> create(TodoRequest request) async {
    try {
      return await _api.create(request);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<TodoResponse> update(String id, UpdateTodoRequest request) async {
    try {
      return await _api.update(id, request);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      return await _api.delete(id);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
}

final todosRepositoryProvider = Provider<TodosRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final api = TodosApi(dio);
  return TodosRepositoryImpl(api);
});

ApiException _toApiException(DioException exception) {
  final error = exception.error;
  if (error is ApiException) {
    return error;
  }

  return ApiException.fromDio(exception);
}
