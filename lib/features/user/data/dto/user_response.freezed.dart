// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserResponse {

 String get id; String get email; String get firstName; String get lastName; String? get phoneCountryCode; String? get phoneNumber; String? get profilePhotoUrl; String get preferredLanguage; DateTime? get birthDate; String get role; int get expPoints; int get level;
/// Create a copy of UserResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserResponseCopyWith<UserResponse> get copyWith => _$UserResponseCopyWithImpl<UserResponse>(this as UserResponse, _$identity);

  /// Serializes this UserResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneCountryCode, phoneCountryCode) || other.phoneCountryCode == phoneCountryCode)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.role, role) || other.role == role)&&(identical(other.expPoints, expPoints) || other.expPoints == expPoints)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,phoneCountryCode,phoneNumber,profilePhotoUrl,preferredLanguage,birthDate,role,expPoints,level);

@override
String toString() {
  return 'UserResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, phoneCountryCode: $phoneCountryCode, phoneNumber: $phoneNumber, profilePhotoUrl: $profilePhotoUrl, preferredLanguage: $preferredLanguage, birthDate: $birthDate, role: $role, expPoints: $expPoints, level: $level)';
}


}

/// @nodoc
abstract mixin class $UserResponseCopyWith<$Res>  {
  factory $UserResponseCopyWith(UserResponse value, $Res Function(UserResponse) _then) = _$UserResponseCopyWithImpl;
@useResult
$Res call({
 String id, String email, String firstName, String lastName, String? phoneCountryCode, String? phoneNumber, String? profilePhotoUrl, String preferredLanguage, DateTime? birthDate, String role, int expPoints, int level
});




}
/// @nodoc
class _$UserResponseCopyWithImpl<$Res>
    implements $UserResponseCopyWith<$Res> {
  _$UserResponseCopyWithImpl(this._self, this._then);

  final UserResponse _self;
  final $Res Function(UserResponse) _then;

/// Create a copy of UserResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? phoneCountryCode = freezed,Object? phoneNumber = freezed,Object? profilePhotoUrl = freezed,Object? preferredLanguage = null,Object? birthDate = freezed,Object? role = null,Object? expPoints = null,Object? level = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneCountryCode: freezed == phoneCountryCode ? _self.phoneCountryCode : phoneCountryCode // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,expPoints: null == expPoints ? _self.expPoints : expPoints // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserResponse].
extension UserResponsePatterns on UserResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String firstName,  String lastName,  String? phoneCountryCode,  String? phoneNumber,  String? profilePhotoUrl,  String preferredLanguage,  DateTime? birthDate,  String role,  int expPoints,  int level)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserResponse() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.phoneCountryCode,_that.phoneNumber,_that.profilePhotoUrl,_that.preferredLanguage,_that.birthDate,_that.role,_that.expPoints,_that.level);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String firstName,  String lastName,  String? phoneCountryCode,  String? phoneNumber,  String? profilePhotoUrl,  String preferredLanguage,  DateTime? birthDate,  String role,  int expPoints,  int level)  $default,) {final _that = this;
switch (_that) {
case _UserResponse():
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.phoneCountryCode,_that.phoneNumber,_that.profilePhotoUrl,_that.preferredLanguage,_that.birthDate,_that.role,_that.expPoints,_that.level);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String firstName,  String lastName,  String? phoneCountryCode,  String? phoneNumber,  String? profilePhotoUrl,  String preferredLanguage,  DateTime? birthDate,  String role,  int expPoints,  int level)?  $default,) {final _that = this;
switch (_that) {
case _UserResponse() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.phoneCountryCode,_that.phoneNumber,_that.profilePhotoUrl,_that.preferredLanguage,_that.birthDate,_that.role,_that.expPoints,_that.level);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserResponse implements UserResponse {
  const _UserResponse({required this.id, required this.email, required this.firstName, required this.lastName, this.phoneCountryCode, this.phoneNumber, this.profilePhotoUrl, required this.preferredLanguage, this.birthDate, required this.role, required this.expPoints, required this.level});
  factory _UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

@override final  String id;
@override final  String email;
@override final  String firstName;
@override final  String lastName;
@override final  String? phoneCountryCode;
@override final  String? phoneNumber;
@override final  String? profilePhotoUrl;
@override final  String preferredLanguage;
@override final  DateTime? birthDate;
@override final  String role;
@override final  int expPoints;
@override final  int level;

/// Create a copy of UserResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserResponseCopyWith<_UserResponse> get copyWith => __$UserResponseCopyWithImpl<_UserResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneCountryCode, phoneCountryCode) || other.phoneCountryCode == phoneCountryCode)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.role, role) || other.role == role)&&(identical(other.expPoints, expPoints) || other.expPoints == expPoints)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,phoneCountryCode,phoneNumber,profilePhotoUrl,preferredLanguage,birthDate,role,expPoints,level);

@override
String toString() {
  return 'UserResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, phoneCountryCode: $phoneCountryCode, phoneNumber: $phoneNumber, profilePhotoUrl: $profilePhotoUrl, preferredLanguage: $preferredLanguage, birthDate: $birthDate, role: $role, expPoints: $expPoints, level: $level)';
}


}

/// @nodoc
abstract mixin class _$UserResponseCopyWith<$Res> implements $UserResponseCopyWith<$Res> {
  factory _$UserResponseCopyWith(_UserResponse value, $Res Function(_UserResponse) _then) = __$UserResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String firstName, String lastName, String? phoneCountryCode, String? phoneNumber, String? profilePhotoUrl, String preferredLanguage, DateTime? birthDate, String role, int expPoints, int level
});




}
/// @nodoc
class __$UserResponseCopyWithImpl<$Res>
    implements _$UserResponseCopyWith<$Res> {
  __$UserResponseCopyWithImpl(this._self, this._then);

  final _UserResponse _self;
  final $Res Function(_UserResponse) _then;

/// Create a copy of UserResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? phoneCountryCode = freezed,Object? phoneNumber = freezed,Object? profilePhotoUrl = freezed,Object? preferredLanguage = null,Object? birthDate = freezed,Object? role = null,Object? expPoints = null,Object? level = null,}) {
  return _then(_UserResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneCountryCode: freezed == phoneCountryCode ? _self.phoneCountryCode : phoneCountryCode // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,expPoints: null == expPoints ? _self.expPoints : expPoints // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
