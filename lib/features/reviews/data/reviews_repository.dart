import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/reviews/data/dto/create_review_request.dart';
import 'package:mobile/features/reviews/data/dto/review_response.dart';
import 'package:mobile/features/reviews/data/review_api.dart';

class ReviewsRepository {
  ReviewsRepository(this._api);

  final ReviewApi _api;

  Future<List<ReviewResponse>> getReviews(String placeId) async {
    try {
      return await _api.getReviews(placeId);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<ReviewResponse> createReview({
    required String placeId,
    required int rating,
    String? comment,
  }) async {
    try {
      return await _api.createReview(
        placeId,
        CreateReviewRequest(rating: rating, comment: comment),
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<void> deleteReview({
    required String placeId,
    required String reviewId,
  }) async {
    try {
      await _api.deleteReview(placeId, reviewId);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }
}

final reviewsRepositoryProvider = Provider<ReviewsRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final api = ReviewApi(dio);
  return ReviewsRepository(api);
});

ApiException _toApiException(DioException exception) {
  final error = exception.error;
  if (error is ApiException) {
    return error;
  }

  return ApiException.fromDio(exception);
}
