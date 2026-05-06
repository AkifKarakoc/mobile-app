// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteResponse {

 String get id; String get placeId; DateTime get savedAt;
/// Create a copy of FavoriteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteResponseCopyWith<FavoriteResponse> get copyWith => _$FavoriteResponseCopyWithImpl<FavoriteResponse>(this as FavoriteResponse, _$identity);

  /// Serializes this FavoriteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,savedAt);

@override
String toString() {
  return 'FavoriteResponse(id: $id, placeId: $placeId, savedAt: $savedAt)';
}


}

/// @nodoc
abstract mixin class $FavoriteResponseCopyWith<$Res>  {
  factory $FavoriteResponseCopyWith(FavoriteResponse value, $Res Function(FavoriteResponse) _then) = _$FavoriteResponseCopyWithImpl;
@useResult
$Res call({
 String id, String placeId, DateTime savedAt
});




}
/// @nodoc
class _$FavoriteResponseCopyWithImpl<$Res>
    implements $FavoriteResponseCopyWith<$Res> {
  _$FavoriteResponseCopyWithImpl(this._self, this._then);

  final FavoriteResponse _self;
  final $Res Function(FavoriteResponse) _then;

/// Create a copy of FavoriteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placeId = null,Object? savedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteResponse].
extension FavoriteResponsePatterns on FavoriteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteResponse value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String placeId,  DateTime savedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteResponse() when $default != null:
return $default(_that.id,_that.placeId,_that.savedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String placeId,  DateTime savedAt)  $default,) {final _that = this;
switch (_that) {
case _FavoriteResponse():
return $default(_that.id,_that.placeId,_that.savedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String placeId,  DateTime savedAt)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteResponse() when $default != null:
return $default(_that.id,_that.placeId,_that.savedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteResponse implements FavoriteResponse {
  const _FavoriteResponse({required this.id, required this.placeId, required this.savedAt});
  factory _FavoriteResponse.fromJson(Map<String, dynamic> json) => _$FavoriteResponseFromJson(json);

@override final  String id;
@override final  String placeId;
@override final  DateTime savedAt;

/// Create a copy of FavoriteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteResponseCopyWith<_FavoriteResponse> get copyWith => __$FavoriteResponseCopyWithImpl<_FavoriteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,savedAt);

@override
String toString() {
  return 'FavoriteResponse(id: $id, placeId: $placeId, savedAt: $savedAt)';
}


}

/// @nodoc
abstract mixin class _$FavoriteResponseCopyWith<$Res> implements $FavoriteResponseCopyWith<$Res> {
  factory _$FavoriteResponseCopyWith(_FavoriteResponse value, $Res Function(_FavoriteResponse) _then) = __$FavoriteResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String placeId, DateTime savedAt
});




}
/// @nodoc
class __$FavoriteResponseCopyWithImpl<$Res>
    implements _$FavoriteResponseCopyWith<$Res> {
  __$FavoriteResponseCopyWithImpl(this._self, this._then);

  final _FavoriteResponse _self;
  final $Res Function(_FavoriteResponse) _then;

/// Create a copy of FavoriteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placeId = null,Object? savedAt = null,}) {
  return _then(_FavoriteResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
