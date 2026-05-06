// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BadgeResponse _$BadgeResponseFromJson(Map<String, dynamic> json) =>
    _BadgeResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconName: json['iconName'] as String,
      iconColor: json['iconColor'] as String,
      tier: json['tier'] as String?,
      earnedByUser: json['earnedByUser'] as bool,
    );

Map<String, dynamic> _$BadgeResponseToJson(_BadgeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconName': instance.iconName,
      'iconColor': instance.iconColor,
      'tier': instance.tier,
      'earnedByUser': instance.earnedByUser,
    };

_UserBadgeResponse _$UserBadgeResponseFromJson(Map<String, dynamic> json) =>
    _UserBadgeResponse(
      id: json['id'] as String,
      badgeId: json['badgeId'] as String,
      badgeName: json['badgeName'] as String,
      badgeDescription: json['badgeDescription'] as String,
      badgeIconName: json['badgeIconName'] as String,
      badgeIconColor: json['badgeIconColor'] as String,
      earnedAt: DateTime.parse(json['earnedAt'] as String),
    );

Map<String, dynamic> _$UserBadgeResponseToJson(_UserBadgeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'badgeId': instance.badgeId,
      'badgeName': instance.badgeName,
      'badgeDescription': instance.badgeDescription,
      'badgeIconName': instance.badgeIconName,
      'badgeIconColor': instance.badgeIconColor,
      'earnedAt': instance.earnedAt.toIso8601String(),
    };
