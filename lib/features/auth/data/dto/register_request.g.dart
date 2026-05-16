// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneCountryCode: json['phoneCountryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      preferredLanguage: json['preferredLanguage'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneCountryCode': instance.phoneCountryCode,
      'phoneNumber': instance.phoneNumber,
      'preferredLanguage': instance.preferredLanguage,
      'birthDate': instance.birthDate?.toIso8601String(),
    };
