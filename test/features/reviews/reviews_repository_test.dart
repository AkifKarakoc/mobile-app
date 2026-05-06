import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/reviews/data/dto/create_review_request.dart';
import 'package:mobile/features/reviews/data/dto/review_response.dart';
import 'package:mobile/features/reviews/data/review_api.dart';
import 'package:mobile/features/reviews/data/reviews_repository.dart';

class MockReviewApi extends Mock implements ReviewApi {}

void main() {
  group('ReviewsRepository', () {
    late MockReviewApi mockApi;
    late ReviewsRepository repository;

    const placeId = 'place-123';
    const reviewId = 'review-456';

    const review = ReviewResponse(
      id: reviewId,
      userId: 'user-789',
      placeId: placeId,
      rating: 4,
      comment: 'Great place!',
      status: 'APPROVED',
      createdAt: '2026-05-05T10:00:00Z',
    );

    setUp(() {
      mockApi = MockReviewApi();
      repository = ReviewsRepository(mockApi);
    });

    setUpAll(() {
      registerFallbackValue(
        const CreateReviewRequest(rating: 1),
      );
    });

    group('getReviews', () {
      test('returns list of reviews on successful API call', () async {
        const reviews = [review];

        when(() => mockApi.getReviews(placeId))
            .thenAnswer((_) async => reviews);

        final result = await repository.getReviews(placeId);

        expect(result, equals(reviews));
        expect(result.single.rating, equals(4));
        verify(() => mockApi.getReviews(placeId)).called(1);
      });
    });

    group('createReview', () {
      test('returns created review on successful API call', () async {
        when(() => mockApi.createReview(placeId, any()))
            .thenAnswer((_) async => review);

        final result = await repository.createReview(
          placeId: placeId,
          rating: 4,
          comment: 'Great place!',
        );

        expect(result, equals(review));
        expect(result.status, equals('APPROVED'));
        verify(() => mockApi.createReview(placeId, any())).called(1);
      });
    });

    group('deleteReview', () {
      test('completes without error on successful API call', () async {
        when(() => mockApi.deleteReview(placeId, reviewId))
            .thenAnswer((_) async {});

        await expectLater(
          repository.deleteReview(placeId: placeId, reviewId: reviewId),
          completes,
        );

        verify(() => mockApi.deleteReview(placeId, reviewId)).called(1);
      });
    });

    group('DioException conversion', () {
      test('converts DioException to ApiException on getReviews failure',
          () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/places/$placeId/reviews'),
          response: Response(
            requestOptions:
                RequestOptions(path: '/places/$placeId/reviews'),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        );

        when(() => mockApi.getReviews(placeId)).thenThrow(dioException);

        expect(
          () => repository.getReviews(placeId),
          throwsA(isA<UnauthorizedException>()),
        );
      });

      test('converts network timeout DioException to NetworkException',
          () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/places/$placeId/reviews'),
          type: DioExceptionType.connectionTimeout,
          message: 'Connection timeout',
        );

        when(() => mockApi.getReviews(placeId)).thenThrow(dioException);

        expect(
          () => repository.getReviews(placeId),
          throwsA(isA<NetworkException>()),
        );
      });
    });
  });
}
