import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_review_request.freezed.dart';
part 'create_review_request.g.dart';

@freezed
abstract class CreateReviewRequest with _$CreateReviewRequest {
  const factory CreateReviewRequest({
    required int rating,
    String? comment,
  }) = _CreateReviewRequest;

  factory CreateReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewRequestFromJson(json);
}
