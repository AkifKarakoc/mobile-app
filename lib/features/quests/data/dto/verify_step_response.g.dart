// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_step_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyStepResponse _$VerifyStepResponseFromJson(Map<String, dynamic> json) =>
    _VerifyStepResponse(
      verificationId: json['verificationId'] as String,
      status: json['status'] as String,
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      expEarned: (json['expEarned'] as num).toInt(),
      questCompleted: json['questCompleted'] as bool,
    );

Map<String, dynamic> _$VerifyStepResponseToJson(_VerifyStepResponse instance) =>
    <String, dynamic>{
      'verificationId': instance.verificationId,
      'status': instance.status,
      'confidenceScore': instance.confidenceScore,
      'expEarned': instance.expEarned,
      'questCompleted': instance.questCompleted,
    };
