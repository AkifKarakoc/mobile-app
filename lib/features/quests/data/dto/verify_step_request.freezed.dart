// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_step_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifyStepRequest {

 MultipartFile? get photo; double get latitude; double get longitude;
/// Create a copy of VerifyStepRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyStepRequestCopyWith<VerifyStepRequest> get copyWith => _$VerifyStepRequestCopyWithImpl<VerifyStepRequest>(this as VerifyStepRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyStepRequest&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,photo,latitude,longitude);

@override
String toString() {
  return 'VerifyStepRequest(photo: $photo, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $VerifyStepRequestCopyWith<$Res>  {
  factory $VerifyStepRequestCopyWith(VerifyStepRequest value, $Res Function(VerifyStepRequest) _then) = _$VerifyStepRequestCopyWithImpl;
@useResult
$Res call({
 MultipartFile? photo, double latitude, double longitude
});




}
/// @nodoc
class _$VerifyStepRequestCopyWithImpl<$Res>
    implements $VerifyStepRequestCopyWith<$Res> {
  _$VerifyStepRequestCopyWithImpl(this._self, this._then);

  final VerifyStepRequest _self;
  final $Res Function(VerifyStepRequest) _then;

/// Create a copy of VerifyStepRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? photo = freezed,Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as MultipartFile?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyStepRequest].
extension VerifyStepRequestPatterns on VerifyStepRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyStepRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyStepRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyStepRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyStepRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyStepRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyStepRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MultipartFile? photo,  double latitude,  double longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyStepRequest() when $default != null:
return $default(_that.photo,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MultipartFile? photo,  double latitude,  double longitude)  $default,) {final _that = this;
switch (_that) {
case _VerifyStepRequest():
return $default(_that.photo,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MultipartFile? photo,  double latitude,  double longitude)?  $default,) {final _that = this;
switch (_that) {
case _VerifyStepRequest() when $default != null:
return $default(_that.photo,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc


class _VerifyStepRequest implements VerifyStepRequest {
  const _VerifyStepRequest({this.photo, required this.latitude, required this.longitude});
  

@override final  MultipartFile? photo;
@override final  double latitude;
@override final  double longitude;

/// Create a copy of VerifyStepRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyStepRequestCopyWith<_VerifyStepRequest> get copyWith => __$VerifyStepRequestCopyWithImpl<_VerifyStepRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyStepRequest&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,photo,latitude,longitude);

@override
String toString() {
  return 'VerifyStepRequest(photo: $photo, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$VerifyStepRequestCopyWith<$Res> implements $VerifyStepRequestCopyWith<$Res> {
  factory _$VerifyStepRequestCopyWith(_VerifyStepRequest value, $Res Function(_VerifyStepRequest) _then) = __$VerifyStepRequestCopyWithImpl;
@override @useResult
$Res call({
 MultipartFile? photo, double latitude, double longitude
});




}
/// @nodoc
class __$VerifyStepRequestCopyWithImpl<$Res>
    implements _$VerifyStepRequestCopyWith<$Res> {
  __$VerifyStepRequestCopyWithImpl(this._self, this._then);

  final _VerifyStepRequest _self;
  final $Res Function(_VerifyStepRequest) _then;

/// Create a copy of VerifyStepRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? photo = freezed,Object? latitude = null,Object? longitude = null,}) {
  return _then(_VerifyStepRequest(
photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as MultipartFile?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
