import 'package:freezed_annotation/freezed_annotation.dart';

part 'quest_detail_response.freezed.dart';
part 'quest_detail_response.g.dart';

@freezed
abstract class QuestDetailResponse with _$QuestDetailResponse {
  const factory QuestDetailResponse({
    required String id,
    required String title,
    required String description,
    required int expReward,
    required String region,
    String? thumbnailUrl,
    String? badgeId,
    required List<StepResponse> steps,
    String? userStatus,
  }) = _QuestDetailResponse;

  factory QuestDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestDetailResponseFromJson(json);
}

@freezed
abstract class StepResponse with _$StepResponse {
  const factory StepResponse({
    required String id,
    required String placeId,
    required int stepOrder,
    required String hint,
    required bool requiresPhoto,
    required bool isCompleted,
  }) = _StepResponse;

  factory StepResponse.fromJson(Map<String, dynamic> json) =>
      _$StepResponseFromJson(json);
}
