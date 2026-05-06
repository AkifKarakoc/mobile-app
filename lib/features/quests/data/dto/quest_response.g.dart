// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestResponse _$QuestResponseFromJson(Map<String, dynamic> json) =>
    _QuestResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      expReward: (json['expReward'] as num).toInt(),
      region: json['region'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      totalSteps: (json['totalSteps'] as num).toInt(),
      userStatus: json['userStatus'] as String?,
    );

Map<String, dynamic> _$QuestResponseToJson(_QuestResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'expReward': instance.expReward,
      'region': instance.region,
      'thumbnailUrl': instance.thumbnailUrl,
      'totalSteps': instance.totalSteps,
      'userStatus': instance.userStatus,
    };
