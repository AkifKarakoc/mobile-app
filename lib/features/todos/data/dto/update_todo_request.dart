import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_todo_request.freezed.dart';
part 'update_todo_request.g.dart';

@freezed
abstract class UpdateTodoRequest with _$UpdateTodoRequest {
  const factory UpdateTodoRequest({
    String? note,
    bool? isCompleted,
  }) = _UpdateTodoRequest;

  factory UpdateTodoRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTodoRequestFromJson(json);
}
