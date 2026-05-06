import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_response.freezed.dart';
part 'todo_response.g.dart';

@freezed
abstract class TodoResponse with _$TodoResponse {
  const factory TodoResponse({
    required String id,
    String? placeId,
    required String note,
    required bool isCompleted,
    required DateTime createdAt,
  }) = _TodoResponse;

  factory TodoResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoResponseFromJson(json);
}
