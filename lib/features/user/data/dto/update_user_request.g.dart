// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    _UpdateUserRequest(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneCountryCode: json['phoneCountryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      preferredLanguage: json['preferredLanguage'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
    );

Map<String, dynamic> _$UpdateUserRequestToJson(_UpdateUserRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneCountryCode': instance.phoneCountryCode,
      'phoneNumber': instance.phoneNumber,
      'preferredLanguage': instance.preferredLanguage,
      'birthDate': instance.birthDate?.toIso8601String(),
    };
