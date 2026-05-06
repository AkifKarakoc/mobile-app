// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_review_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateReviewRequest {

 int get rating; String? get comment;
/// Create a copy of CreateReviewRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateReviewRequestCopyWith<CreateReviewRequest> get copyWith => _$CreateReviewRequestCopyWithImpl<CreateReviewRequest>(this as CreateReviewRequest, _$identity);

  /// Serializes this CreateReviewRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateReviewRequest&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,comment);

@override
String toString() {
  return 'CreateReviewRequest(rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $CreateReviewRequestCopyWith<$Res>  {
  factory $CreateReviewRequestCopyWith(CreateReviewRequest value, $Res Function(CreateReviewRequest) _then) = _$CreateReviewRequestCopyWithImpl;
@useResult
$Res call({
 int rating, String? comment
});




}
/// @nodoc
class _$CreateReviewRequestCopyWithImpl<$Res>
    implements $CreateReviewRequestCopyWith<$Res> {
  _$CreateReviewRequestCopyWithImpl(this._self, this._then);

  final CreateReviewRequest _self;
  final $Res Function(CreateReviewRequest) _then;

/// Create a copy of CreateReviewRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? comment = freezed,}) {
  return _then(_self.copyWith(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateReviewRequest].
extension CreateReviewRequestPatterns on CreateReviewRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateReviewRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateReviewRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateReviewRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateReviewRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateReviewRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateReviewRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rating,  String? comment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateReviewRequest() when $default != null:
return $default(_that.rating,_that.comment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rating,  String? comment)  $default,) {final _that = this;
switch (_that) {
case _CreateReviewRequest():
return $default(_that.rating,_that.comment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rating,  String? comment)?  $default,) {final _that = this;
switch (_that) {
case _CreateReviewRequest() when $default != null:
return $default(_that.rating,_that.comment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateReviewRequest implements CreateReviewRequest {
  const _CreateReviewRequest({required this.rating, this.comment});
  factory _CreateReviewRequest.fromJson(Map<String, dynamic> json) => _$CreateReviewRequestFromJson(json);

@override final  int rating;
@override final  String? comment;

/// Create a copy of CreateReviewRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateReviewRequestCopyWith<_CreateReviewRequest> get copyWith => __$CreateReviewRequestCopyWithImpl<_CreateReviewRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateReviewRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateReviewRequest&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,comment);

@override
String toString() {
  return 'CreateReviewRequest(rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$CreateReviewRequestCopyWith<$Res> implements $CreateReviewRequestCopyWith<$Res> {
  factory _$CreateReviewRequestCopyWith(_CreateReviewRequest value, $Res Function(_CreateReviewRequest) _then) = __$CreateReviewRequestCopyWithImpl;
@override @useResult
$Res call({
 int rating, String? comment
});




}
/// @nodoc
class __$CreateReviewRequestCopyWithImpl<$Res>
    implements _$CreateReviewRequestCopyWith<$Res> {
  __$CreateReviewRequestCopyWithImpl(this._self, this._then);

  final _CreateReviewRequest _self;
  final $Res Function(_CreateReviewRequest) _then;

/// Create a copy of CreateReviewRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? comment = freezed,}) {
  return _then(_CreateReviewRequest(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
