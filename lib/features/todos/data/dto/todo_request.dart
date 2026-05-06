import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_request.freezed.dart';
part 'todo_request.g.dart';

@freezed
abstract class TodoRequest with _$TodoRequest {
  const factory TodoRequest({
    required String note,
    String? placeId,
  }) = _TodoRequest;

  factory TodoRequest.fromJson(Map<String, dynamic> json) =>
      _$TodoRequestFromJson(json);
}
