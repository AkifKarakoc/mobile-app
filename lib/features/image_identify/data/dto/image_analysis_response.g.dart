// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_analysis_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageAnalysisResponse _$ImageAnalysisResponseFromJson(
  Map<String, dynamic> json,
) => _ImageAnalysisResponse(
  placeId: json['placeId'] as String?,
  placeName: json['placeName'] as String,
  confidence: (json['confidence'] as num).toDouble(),
  description: json['description'] as String,
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$ImageAnalysisResponseToJson(
  _ImageAnalysisResponse instance,
) => <String, dynamic>{
  'placeId': instance.placeId,
  'placeName': instance.placeName,
  'confidence': instance.confidence,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
};
