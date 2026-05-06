import 'package:dio/dio.dart';
import 'package:mobile/features/badges/data/dto/badge_response.dart';
import 'package:retrofit/retrofit.dart';

part 'badges_api.g.dart';

@RestApi()
abstract class BadgesApi {
  factory BadgesApi(Dio dio, {String baseUrl}) = _BadgesApi;

  @GET('/badges')
  Future<List<BadgeResponse>> getAllBadges();

  @GET('/users/me/badges')
  Future<List<UserBadgeResponse>> getMyBadges();
}
