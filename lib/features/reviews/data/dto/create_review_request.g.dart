// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateReviewRequest _$CreateReviewRequestFromJson(Map<String, dynamic> json) =>
    _CreateReviewRequest(
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$CreateReviewRequestToJson(
  _CreateReviewRequest instance,
) => <String, dynamic>{'rating': instance.rating, 'comment': instance.comment};
