// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserResponse _$UserResponseFromJson(Map<String, dynamic> json) =>
    _UserResponse(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      preferredLanguage: json['preferredLanguage'] as String,
      ageGroup: json['ageGroup'] as String?,
      role: json['role'] as String,
      expPoints: (json['expPoints'] as num).toInt(),
      level: (json['level'] as num).toInt(),
    );

Map<String, dynamic> _$UserResponseToJson(_UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'preferredLanguage': instance.preferredLanguage,
      'ageGroup': instance.ageGroup,
      'role': instance.role,
      'expPoints': instance.expPoints,
      'level': instance.level,
    };
