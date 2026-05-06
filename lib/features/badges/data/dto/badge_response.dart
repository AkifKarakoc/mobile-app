import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_response.freezed.dart';
part 'badge_response.g.dart';

@freezed
abstract class BadgeResponse with _$BadgeResponse {
  const factory BadgeResponse({
    required String id,
    required String name,
    required String description,
    required String iconName,
    required String iconColor,
    String? tier,
    required bool earnedByUser,
  }) = _BadgeResponse;

  factory BadgeResponse.fromJson(Map<String, dynamic> json) =>
      _$BadgeResponseFromJson(json);
}

@freezed
abstract class UserBadgeResponse with _$UserBadgeResponse {
  const factory UserBadgeResponse({
    required String id,
    required String badgeId,
    required String badgeName,
    required String badgeDescription,
    required String badgeIconName,
    required String badgeIconColor,
    required DateTime earnedAt,
  }) = _UserBadgeResponse;

  factory UserBadgeResponse.fromJson(Map<String, dynamic> json) =>
      _$UserBadgeResponseFromJson(json);
}
