import 'package:dio/dio.dart';
import 'package:mobile/features/reviews/data/dto/create_review_request.dart';
import 'package:mobile/features/reviews/data/dto/review_response.dart';
import 'package:retrofit/retrofit.dart';

part 'review_api.g.dart';

@RestApi()
abstract class ReviewApi {
  factory ReviewApi(Dio dio, {String baseUrl}) = _ReviewApi;

  @GET('/places/{placeId}/reviews')
  Future<List<ReviewResponse>> getReviews(@Path('placeId') String placeId);

  @POST('/places/{placeId}/reviews')
  Future<ReviewResponse> createReview(
    @Path('placeId') String placeId,
    @Body() CreateReviewRequest body,
  );

  @DELETE('/places/{placeId}/reviews/{reviewId}')
  Future<void> deleteReview(
    @Path('placeId') String placeId,
    @Path('reviewId') String reviewId,
  );
}
