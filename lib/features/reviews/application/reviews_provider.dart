import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/reviews/data/dto/review_response.dart';
import 'package:mobile/features/reviews/data/reviews_repository.dart';

class PlaceReviews extends FamilyAsyncNotifier<List<ReviewResponse>, String> {
  ReviewsRepository? _repository;

  @override
  Future<List<ReviewResponse>> build(String arg) async {
    _repository ??= ref.watch(reviewsRepositoryProvider);
    return _repository!.getReviews(arg);
  }

  Future<ReviewResponse> submitReview({
    required int rating,
    String? comment,
  }) async {
    final review = await _repository!.createReview(
      placeId: arg,
      rating: rating,
      comment: comment,
    );
    ref.invalidateSelf();
    return review;
  }

  Future<void> deleteReview(String reviewId) async {
    await _repository!.deleteReview(placeId: arg, reviewId: reviewId);
    ref.invalidateSelf();
  }
}

final placeReviewsProvider =
    AsyncNotifierProvider.family<PlaceReviews, List<ReviewResponse>, String>(
      PlaceReviews.new,
    );
