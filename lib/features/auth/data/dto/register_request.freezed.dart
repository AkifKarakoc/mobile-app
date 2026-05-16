// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterRequest {

 String get email; String get password; String get firstName; String get lastName; String? get phoneCountryCode; String? get phoneNumber; String? get preferredLanguage; DateTime? get birthDate;
/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterRequestCopyWith<RegisterRequest> get copyWith => _$RegisterRequestCopyWithImpl<RegisterRequest>(this as RegisterRequest, _$identity);

  /// Serializes this RegisterRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneCountryCode, phoneCountryCode) || other.phoneCountryCode == phoneCountryCode)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,firstName,lastName,phoneCountryCode,phoneNumber,preferredLanguage,birthDate);

@override
String toString() {
  return 'RegisterRequest(email: $email, password: $password, firstName: $firstName, lastName: $lastName, phoneCountryCode: $phoneCountryCode, phoneNumber: $phoneNumber, preferredLanguage: $preferredLanguage, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class $RegisterRequestCopyWith<$Res>  {
  factory $RegisterRequestCopyWith(RegisterRequest value, $Res Function(RegisterRequest) _then) = _$RegisterRequestCopyWithImpl;
@useResult
$Res call({
 String email, String password, String firstName, String lastName, String? phoneCountryCode, String? phoneNumber, String? preferredLanguage, DateTime? birthDate
});




}
/// @nodoc
class _$RegisterRequestCopyWithImpl<$Res>
    implements $RegisterRequestCopyWith<$Res> {
  _$RegisterRequestCopyWithImpl(this._self, this._then);

  final RegisterRequest _self;
  final $Res Function(RegisterRequest) _then;

/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? firstName = null,Object? lastName = null,Object? phoneCountryCode = freezed,Object? phoneNumber = freezed,Object? preferredLanguage = freezed,Object? birthDate = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneCountryCode: freezed == phoneCountryCode ? _self.phoneCountryCode : phoneCountryCode // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,preferredLanguage: freezed == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterRequest].
extension RegisterRequestPatterns on RegisterRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterRequest value)  $default,){
final _that = this;
switch (_that) {
case _RegisterRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  String firstName,  String lastName,  String? phoneCountryCode,  String? phoneNumber,  String? preferredLanguage,  DateTime? birthDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
return $default(_that.email,_that.password,_that.firstName,_that.lastName,_that.phoneCountryCode,_that.phoneNumber,_that.preferredLanguage,_that.birthDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  String firstName,  String lastName,  String? phoneCountryCode,  String? phoneNumber,  String? preferredLanguage,  DateTime? birthDate)  $default,) {final _that = this;
switch (_that) {
case _RegisterRequest():
return $default(_that.email,_that.password,_that.firstName,_that.lastName,_that.phoneCountryCode,_that.phoneNumber,_that.preferredLanguage,_that.birthDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  String firstName,  String lastName,  String? phoneCountryCode,  String? phoneNumber,  String? preferredLanguage,  DateTime? birthDate)?  $default,) {final _that = this;
switch (_that) {
case _RegisterRequest() when $default != null:
return $default(_that.email,_that.password,_that.firstName,_that.lastName,_that.phoneCountryCode,_that.phoneNumber,_that.preferredLanguage,_that.birthDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterRequest implements RegisterRequest {
  const _RegisterRequest({required this.email, required this.password, required this.firstName, required this.lastName, this.phoneCountryCode, this.phoneNumber, this.preferredLanguage, this.birthDate});
  factory _RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

@override final  String email;
@override final  String password;
@override final  String firstName;
@override final  String lastName;
@override final  String? phoneCountryCode;
@override final  String? phoneNumber;
@override final  String? preferredLanguage;
@override final  DateTime? birthDate;

/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterRequestCopyWith<_RegisterRequest> get copyWith => __$RegisterRequestCopyWithImpl<_RegisterRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneCountryCode, phoneCountryCode) || other.phoneCountryCode == phoneCountryCode)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,firstName,lastName,phoneCountryCode,phoneNumber,preferredLanguage,birthDate);

@override
String toString() {
  return 'RegisterRequest(email: $email, password: $password, firstName: $firstName, lastName: $lastName, phoneCountryCode: $phoneCountryCode, phoneNumber: $phoneNumber, preferredLanguage: $preferredLanguage, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class _$RegisterRequestCopyWith<$Res> implements $RegisterRequestCopyWith<$Res> {
  factory _$RegisterRequestCopyWith(_RegisterRequest value, $Res Function(_RegisterRequest) _then) = __$RegisterRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, String firstName, String lastName, String? phoneCountryCode, String? phoneNumber, String? preferredLanguage, DateTime? birthDate
});




}
/// @nodoc
class __$RegisterRequestCopyWithImpl<$Res>
    implements _$RegisterRequestCopyWith<$Res> {
  __$RegisterRequestCopyWithImpl(this._self, this._then);

  final _RegisterRequest _self;
  final $Res Function(_RegisterRequest) _then;

/// Create a copy of RegisterRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? firstName = null,Object? lastName = null,Object? phoneCountryCode = freezed,Object? phoneNumber = freezed,Object? preferredLanguage = freezed,Object? birthDate = freezed,}) {
  return _then(_RegisterRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneCountryCode: freezed == phoneCountryCode ? _self.phoneCountryCode : phoneCountryCode // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,preferredLanguage: freezed == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
