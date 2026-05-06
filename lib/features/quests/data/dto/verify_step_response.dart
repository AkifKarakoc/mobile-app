import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_step_response.freezed.dart';
part 'verify_step_response.g.dart';

@freezed
abstract class VerifyStepResponse with _$VerifyStepResponse {
  const factory VerifyStepResponse({
    required String verificationId,
    required String status,
    required double confidenceScore,
    required int expEarned,
    required bool questCompleted,
  }) = _VerifyStepResponse;

  factory VerifyStepResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyStepResponseFromJson(json);
}
