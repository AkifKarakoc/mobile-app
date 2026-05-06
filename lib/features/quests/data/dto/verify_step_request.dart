import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_step_request.freezed.dart';

@freezed
abstract class VerifyStepRequest with _$VerifyStepRequest {
  const factory VerifyStepRequest({
    MultipartFile? photo,
    required double latitude,
    required double longitude,
  }) = _VerifyStepRequest;
}
