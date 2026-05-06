import 'package:dio/dio.dart';
import 'package:mobile/features/todos/data/dto/todo_request.dart';
import 'package:mobile/features/todos/data/dto/todo_response.dart';
import 'package:mobile/features/todos/data/dto/update_todo_request.dart';
import 'package:retrofit/retrofit.dart';

part 'todos_api.g.dart';

@RestApi()
abstract class TodosApi {
  factory TodosApi(Dio dio, {String baseUrl}) = _TodosApi;

  @GET('/todos')
  Future<List<TodoResponse>> getAll();

  @POST('/todos')
  Future<TodoResponse> create(@Body() TodoRequest request);

  @PATCH('/todos/{id}')
  Future<TodoResponse> update(
    @Path('id') String id,
    @Body() UpdateTodoRequest request,
  );

  @DELETE('/todos/{id}')
  Future<void> delete(@Path('id') String id);
}
