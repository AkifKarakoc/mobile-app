import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_response.freezed.dart';
part 'review_response.g.dart';

@freezed
abstract class ReviewResponse with _$ReviewResponse {
  const factory ReviewResponse({
    required String id,
    required String userId,
    String? userFirstName,
    String? userLastName,
    required String placeId,
    required int rating,
    String? comment,
    required String status,
    required String createdAt,
  }) = _ReviewResponse;

  factory ReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseFromJson(json);
}
