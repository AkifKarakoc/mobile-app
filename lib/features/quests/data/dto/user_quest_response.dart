import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_quest_response.freezed.dart';
part 'user_quest_response.g.dart';

@freezed
abstract class UserQuestResponse with _$UserQuestResponse {
  const factory UserQuestResponse({
    required String id,
    required String questId,
    required String questTitle,
    required String questDescription,
    String? questThumbnailUrl,
    required String status,
    required String startedAt,
    String? completedAt,
    required int totalSteps,
    required int completedSteps,
  }) = _UserQuestResponse;

  factory UserQuestResponse.fromJson(Map<String, dynamic> json) =>
      _$UserQuestResponseFromJson(json);
}
