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
      phoneCountryCode: json['phoneCountryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      preferredLanguage: json['preferredLanguage'] as String,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
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
      'phoneCountryCode': instance.phoneCountryCode,
      'phoneNumber': instance.phoneNumber,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'preferredLanguage': instance.preferredLanguage,
      'birthDate': instance.birthDate?.toIso8601String(),
      'role': instance.role,
      'expPoints': instance.expPoints,
      'level': instance.level,
    };
