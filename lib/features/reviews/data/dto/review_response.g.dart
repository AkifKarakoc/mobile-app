// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) =>
    _ReviewResponse(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userFirstName: json['userFirstName'] as String?,
      userLastName: json['userLastName'] as String?,
      placeId: json['placeId'] as String,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ReviewResponseToJson(_ReviewResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
      'placeId': instance.placeId,
      'rating': instance.rating,
      'comment': instance.comment,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
