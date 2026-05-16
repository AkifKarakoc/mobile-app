// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestDetailResponse _$QuestDetailResponseFromJson(Map<String, dynamic> json) =>
    _QuestDetailResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      expReward: (json['expReward'] as num).toInt(),
      region: json['region'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      badgeId: json['badgeId'] as String?,
      gpsThresholdMeters: (json['gpsThresholdMeters'] as num?)?.toInt() ?? 200,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      userStatus: json['userStatus'] as String?,
    );

Map<String, dynamic> _$QuestDetailResponseToJson(
  _QuestDetailResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'expReward': instance.expReward,
  'region': instance.region,
  'thumbnailUrl': instance.thumbnailUrl,
  'badgeId': instance.badgeId,
  'gpsThresholdMeters': instance.gpsThresholdMeters,
  'steps': instance.steps,
  'userStatus': instance.userStatus,
};

_StepResponse _$StepResponseFromJson(Map<String, dynamic> json) =>
    _StepResponse(
      id: json['id'] as String,
      placeId: json['placeId'] as String,
      stepOrder: (json['stepOrder'] as num).toInt(),
      hint: json['hint'] as String?,
      requiresPhoto: json['requiresPhoto'] as bool,
      isCompleted: json['isCompleted'] as bool,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      placeName: json['placeName'] as String?,
    );

Map<String, dynamic> _$StepResponseToJson(_StepResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'stepOrder': instance.stepOrder,
      'hint': instance.hint,
      'requiresPhoto': instance.requiresPhoto,
      'isCompleted': instance.isCompleted,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'placeName': instance.placeName,
    };
