import 'package:freezed_annotation/freezed_annotation.dart';

part 'quest_response.freezed.dart';
part 'quest_response.g.dart';

@freezed
abstract class QuestResponse with _$QuestResponse {
  const factory QuestResponse({
    required String id,
    required String title,
    required String description,
    required int expReward,
    required String region,
    String? thumbnailUrl,
    required int totalSteps,
    String? userStatus,
  }) = _QuestResponse;

  factory QuestResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestResponseFromJson(json);
}
