// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_quest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserQuestResponse _$UserQuestResponseFromJson(Map<String, dynamic> json) =>
    _UserQuestResponse(
      id: json['id'] as String,
      questId: json['questId'] as String,
      questTitle: json['questTitle'] as String,
      questDescription: json['questDescription'] as String,
      questThumbnailUrl: json['questThumbnailUrl'] as String?,
      status: json['status'] as String,
      startedAt: json['startedAt'] as String,
      completedAt: json['completedAt'] as String?,
      totalSteps: (json['totalSteps'] as num).toInt(),
      completedSteps: (json['completedSteps'] as num).toInt(),
    );

Map<String, dynamic> _$UserQuestResponseToJson(_UserQuestResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questId': instance.questId,
      'questTitle': instance.questTitle,
      'questDescription': instance.questDescription,
      'questThumbnailUrl': instance.questThumbnailUrl,
      'status': instance.status,
      'startedAt': instance.startedAt,
      'completedAt': instance.completedAt,
      'totalSteps': instance.totalSteps,
      'completedSteps': instance.completedSteps,
    };
