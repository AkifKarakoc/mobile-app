// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReviewResponse {

 String get id; String get userId; String get placeId; int get rating; String? get comment; String get status; String get createdAt;
/// Create a copy of ReviewResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewResponseCopyWith<ReviewResponse> get copyWith => _$ReviewResponseCopyWithImpl<ReviewResponse>(this as ReviewResponse, _$identity);

  /// Serializes this ReviewResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,placeId,rating,comment,status,createdAt);

@override
String toString() {
  return 'ReviewResponse(id: $id, userId: $userId, placeId: $placeId, rating: $rating, comment: $comment, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ReviewResponseCopyWith<$Res>  {
  factory $ReviewResponseCopyWith(ReviewResponse value, $Res Function(ReviewResponse) _then) = _$ReviewResponseCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String placeId, int rating, String? comment, String status, String createdAt
});




}
/// @nodoc
class _$ReviewResponseCopyWithImpl<$Res>
    implements $ReviewResponseCopyWith<$Res> {
  _$ReviewResponseCopyWithImpl(this._self, this._then);

  final ReviewResponse _self;
  final $Res Function(ReviewResponse) _then;

/// Create a copy of ReviewResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? placeId = null,Object? rating = null,Object? comment = freezed,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewResponse].
extension ReviewResponsePatterns on ReviewResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewResponse value)  $default,){
final _that = this;
switch (_that) {
case _ReviewResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String placeId,  int rating,  String? comment,  String status,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewResponse() when $default != null:
return $default(_that.id,_that.userId,_that.placeId,_that.rating,_that.comment,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String placeId,  int rating,  String? comment,  String status,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _ReviewResponse():
return $default(_that.id,_that.userId,_that.placeId,_that.rating,_that.comment,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String placeId,  int rating,  String? comment,  String status,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ReviewResponse() when $default != null:
return $default(_that.id,_that.userId,_that.placeId,_that.rating,_that.comment,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewResponse implements ReviewResponse {
  const _ReviewResponse({required this.id, required this.userId, required this.placeId, required this.rating, this.comment, required this.status, required this.createdAt});
  factory _ReviewResponse.fromJson(Map<String, dynamic> json) => _$ReviewResponseFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String placeId;
@override final  int rating;
@override final  String? comment;
@override final  String status;
@override final  String createdAt;

/// Create a copy of ReviewResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewResponseCopyWith<_ReviewResponse> get copyWith => __$ReviewResponseCopyWithImpl<_ReviewResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,placeId,rating,comment,status,createdAt);

@override
String toString() {
  return 'ReviewResponse(id: $id, userId: $userId, placeId: $placeId, rating: $rating, comment: $comment, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReviewResponseCopyWith<$Res> implements $ReviewResponseCopyWith<$Res> {
  factory _$ReviewResponseCopyWith(_ReviewResponse value, $Res Function(_ReviewResponse) _then) = __$ReviewResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String placeId, int rating, String? comment, String status, String createdAt
});




}
/// @nodoc
class __$ReviewResponseCopyWithImpl<$Res>
    implements _$ReviewResponseCopyWith<$Res> {
  __$ReviewResponseCopyWithImpl(this._self, this._then);

  final _ReviewResponse _self;
  final $Res Function(_ReviewResponse) _then;

/// Create a copy of ReviewResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? placeId = null,Object? rating = null,Object? comment = freezed,Object? status = null,Object? createdAt = null,}) {
  return _then(_ReviewResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
