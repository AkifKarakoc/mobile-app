// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_step_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyStepResponse {

 String get verificationId; String get status; double get confidenceScore; int get expEarned; bool get questCompleted;
/// Create a copy of VerifyStepResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyStepResponseCopyWith<VerifyStepResponse> get copyWith => _$VerifyStepResponseCopyWithImpl<VerifyStepResponse>(this as VerifyStepResponse, _$identity);

  /// Serializes this VerifyStepResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyStepResponse&&(identical(other.verificationId, verificationId) || other.verificationId == verificationId)&&(identical(other.status, status) || other.status == status)&&(identical(other.confidenceScore, confidenceScore) || other.confidenceScore == confidenceScore)&&(identical(other.expEarned, expEarned) || other.expEarned == expEarned)&&(identical(other.questCompleted, questCompleted) || other.questCompleted == questCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verificationId,status,confidenceScore,expEarned,questCompleted);

@override
String toString() {
  return 'VerifyStepResponse(verificationId: $verificationId, status: $status, confidenceScore: $confidenceScore, expEarned: $expEarned, questCompleted: $questCompleted)';
}


}

/// @nodoc
abstract mixin class $VerifyStepResponseCopyWith<$Res>  {
  factory $VerifyStepResponseCopyWith(VerifyStepResponse value, $Res Function(VerifyStepResponse) _then) = _$VerifyStepResponseCopyWithImpl;
@useResult
$Res call({
 String verificationId, String status, double confidenceScore, int expEarned, bool questCompleted
});




}
/// @nodoc
class _$VerifyStepResponseCopyWithImpl<$Res>
    implements $VerifyStepResponseCopyWith<$Res> {
  _$VerifyStepResponseCopyWithImpl(this._self, this._then);

  final VerifyStepResponse _self;
  final $Res Function(VerifyStepResponse) _then;

/// Create a copy of VerifyStepResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verificationId = null,Object? status = null,Object? confidenceScore = null,Object? expEarned = null,Object? questCompleted = null,}) {
  return _then(_self.copyWith(
verificationId: null == verificationId ? _self.verificationId : verificationId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,confidenceScore: null == confidenceScore ? _self.confidenceScore : confidenceScore // ignore: cast_nullable_to_non_nullable
as double,expEarned: null == expEarned ? _self.expEarned : expEarned // ignore: cast_nullable_to_non_nullable
as int,questCompleted: null == questCompleted ? _self.questCompleted : questCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyStepResponse].
extension VerifyStepResponsePatterns on VerifyStepResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyStepResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyStepResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyStepResponse value)  $default,){
final _that = this;
switch (_that) {
case _VerifyStepResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyStepResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyStepResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String verificationId,  String status,  double confidenceScore,  int expEarned,  bool questCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyStepResponse() when $default != null:
return $default(_that.verificationId,_that.status,_that.confidenceScore,_that.expEarned,_that.questCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String verificationId,  String status,  double confidenceScore,  int expEarned,  bool questCompleted)  $default,) {final _that = this;
switch (_that) {
case _VerifyStepResponse():
return $default(_that.verificationId,_that.status,_that.confidenceScore,_that.expEarned,_that.questCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String verificationId,  String status,  double confidenceScore,  int expEarned,  bool questCompleted)?  $default,) {final _that = this;
switch (_that) {
case _VerifyStepResponse() when $default != null:
return $default(_that.verificationId,_that.status,_that.confidenceScore,_that.expEarned,_that.questCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyStepResponse implements VerifyStepResponse {
  const _VerifyStepResponse({required this.verificationId, required this.status, required this.confidenceScore, required this.expEarned, required this.questCompleted});
  factory _VerifyStepResponse.fromJson(Map<String, dynamic> json) => _$VerifyStepResponseFromJson(json);

@override final  String verificationId;
@override final  String status;
@override final  double confidenceScore;
@override final  int expEarned;
@override final  bool questCompleted;

/// Create a copy of VerifyStepResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyStepResponseCopyWith<_VerifyStepResponse> get copyWith => __$VerifyStepResponseCopyWithImpl<_VerifyStepResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyStepResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyStepResponse&&(identical(other.verificationId, verificationId) || other.verificationId == verificationId)&&(identical(other.status, status) || other.status == status)&&(identical(other.confidenceScore, confidenceScore) || other.confidenceScore == confidenceScore)&&(identical(other.expEarned, expEarned) || other.expEarned == expEarned)&&(identical(other.questCompleted, questCompleted) || other.questCompleted == questCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verificationId,status,confidenceScore,expEarned,questCompleted);

@override
String toString() {
  return 'VerifyStepResponse(verificationId: $verificationId, status: $status, confidenceScore: $confidenceScore, expEarned: $expEarned, questCompleted: $questCompleted)';
}


}

/// @nodoc
abstract mixin class _$VerifyStepResponseCopyWith<$Res> implements $VerifyStepResponseCopyWith<$Res> {
  factory _$VerifyStepResponseCopyWith(_VerifyStepResponse value, $Res Function(_VerifyStepResponse) _then) = __$VerifyStepResponseCopyWithImpl;
@override @useResult
$Res call({
 String verificationId, String status, double confidenceScore, int expEarned, bool questCompleted
});




}
/// @nodoc
class __$VerifyStepResponseCopyWithImpl<$Res>
    implements _$VerifyStepResponseCopyWith<$Res> {
  __$VerifyStepResponseCopyWithImpl(this._self, this._then);

  final _VerifyStepResponse _self;
  final $Res Function(_VerifyStepResponse) _then;

/// Create a copy of VerifyStepResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verificationId = null,Object? status = null,Object? confidenceScore = null,Object? expEarned = null,Object? questCompleted = null,}) {
  return _then(_VerifyStepResponse(
verificationId: null == verificationId ? _self.verificationId : verificationId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,confidenceScore: null == confidenceScore ? _self.confidenceScore : confidenceScore // ignore: cast_nullable_to_non_nullable
as double,expEarned: null == expEarned ? _self.expEarned : expEarned // ignore: cast_nullable_to_non_nullable
as int,questCompleted: null == questCompleted ? _self.questCompleted : questCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
