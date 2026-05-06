import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_analysis_response.freezed.dart';
part 'image_analysis_response.g.dart';

@freezed
abstract class ImageAnalysisResponse with _$ImageAnalysisResponse {
  const factory ImageAnalysisResponse({
    String? placeId,
    required String placeName,
    required double confidence,
    required String description,
    required String imageUrl,
  }) = _ImageAnalysisResponse;

  factory ImageAnalysisResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageAnalysisResponseFromJson(json);
}
