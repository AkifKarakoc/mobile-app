// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_favorite_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddFavoriteRequest {

 String get placeId;
/// Create a copy of AddFavoriteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddFavoriteRequestCopyWith<AddFavoriteRequest> get copyWith => _$AddFavoriteRequestCopyWithImpl<AddFavoriteRequest>(this as AddFavoriteRequest, _$identity);

  /// Serializes this AddFavoriteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddFavoriteRequest&&(identical(other.placeId, placeId) || other.placeId == placeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId);

@override
String toString() {
  return 'AddFavoriteRequest(placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class $AddFavoriteRequestCopyWith<$Res>  {
  factory $AddFavoriteRequestCopyWith(AddFavoriteRequest value, $Res Function(AddFavoriteRequest) _then) = _$AddFavoriteRequestCopyWithImpl;
@useResult
$Res call({
 String placeId
});




}
/// @nodoc
class _$AddFavoriteRequestCopyWithImpl<$Res>
    implements $AddFavoriteRequestCopyWith<$Res> {
  _$AddFavoriteRequestCopyWithImpl(this._self, this._then);

  final AddFavoriteRequest _self;
  final $Res Function(AddFavoriteRequest) _then;

/// Create a copy of AddFavoriteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AddFavoriteRequest].
extension AddFavoriteRequestPatterns on AddFavoriteRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddFavoriteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddFavoriteRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddFavoriteRequest value)  $default,){
final _that = this;
switch (_that) {
case _AddFavoriteRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddFavoriteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AddFavoriteRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String placeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddFavoriteRequest() when $default != null:
return $default(_that.placeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String placeId)  $default,) {final _that = this;
switch (_that) {
case _AddFavoriteRequest():
return $default(_that.placeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String placeId)?  $default,) {final _that = this;
switch (_that) {
case _AddFavoriteRequest() when $default != null:
return $default(_that.placeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddFavoriteRequest implements AddFavoriteRequest {
  const _AddFavoriteRequest({required this.placeId});
  factory _AddFavoriteRequest.fromJson(Map<String, dynamic> json) => _$AddFavoriteRequestFromJson(json);

@override final  String placeId;

/// Create a copy of AddFavoriteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddFavoriteRequestCopyWith<_AddFavoriteRequest> get copyWith => __$AddFavoriteRequestCopyWithImpl<_AddFavoriteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddFavoriteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddFavoriteRequest&&(identical(other.placeId, placeId) || other.placeId == placeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId);

@override
String toString() {
  return 'AddFavoriteRequest(placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class _$AddFavoriteRequestCopyWith<$Res> implements $AddFavoriteRequestCopyWith<$Res> {
  factory _$AddFavoriteRequestCopyWith(_AddFavoriteRequest value, $Res Function(_AddFavoriteRequest) _then) = __$AddFavoriteRequestCopyWithImpl;
@override @useResult
$Res call({
 String placeId
});




}
/// @nodoc
class __$AddFavoriteRequestCopyWithImpl<$Res>
    implements _$AddFavoriteRequestCopyWith<$Res> {
  __$AddFavoriteRequestCopyWithImpl(this._self, this._then);

  final _AddFavoriteRequest _self;
  final $Res Function(_AddFavoriteRequest) _then;

/// Create a copy of AddFavoriteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,}) {
  return _then(_AddFavoriteRequest(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
