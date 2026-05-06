// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoRequest {

 String get note; String? get placeId;
/// Create a copy of TodoRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoRequestCopyWith<TodoRequest> get copyWith => _$TodoRequestCopyWithImpl<TodoRequest>(this as TodoRequest, _$identity);

  /// Serializes this TodoRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoRequest&&(identical(other.note, note) || other.note == note)&&(identical(other.placeId, placeId) || other.placeId == placeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,note,placeId);

@override
String toString() {
  return 'TodoRequest(note: $note, placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class $TodoRequestCopyWith<$Res>  {
  factory $TodoRequestCopyWith(TodoRequest value, $Res Function(TodoRequest) _then) = _$TodoRequestCopyWithImpl;
@useResult
$Res call({
 String note, String? placeId
});




}
/// @nodoc
class _$TodoRequestCopyWithImpl<$Res>
    implements $TodoRequestCopyWith<$Res> {
  _$TodoRequestCopyWithImpl(this._self, this._then);

  final TodoRequest _self;
  final $Res Function(TodoRequest) _then;

/// Create a copy of TodoRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? note = null,Object? placeId = freezed,}) {
  return _then(_self.copyWith(
note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoRequest].
extension TodoRequestPatterns on TodoRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoRequest value)  $default,){
final _that = this;
switch (_that) {
case _TodoRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TodoRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String note,  String? placeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoRequest() when $default != null:
return $default(_that.note,_that.placeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String note,  String? placeId)  $default,) {final _that = this;
switch (_that) {
case _TodoRequest():
return $default(_that.note,_that.placeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String note,  String? placeId)?  $default,) {final _that = this;
switch (_that) {
case _TodoRequest() when $default != null:
return $default(_that.note,_that.placeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodoRequest implements TodoRequest {
  const _TodoRequest({required this.note, this.placeId});
  factory _TodoRequest.fromJson(Map<String, dynamic> json) => _$TodoRequestFromJson(json);

@override final  String note;
@override final  String? placeId;

/// Create a copy of TodoRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoRequestCopyWith<_TodoRequest> get copyWith => __$TodoRequestCopyWithImpl<_TodoRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoRequest&&(identical(other.note, note) || other.note == note)&&(identical(other.placeId, placeId) || other.placeId == placeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,note,placeId);

@override
String toString() {
  return 'TodoRequest(note: $note, placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class _$TodoRequestCopyWith<$Res> implements $TodoRequestCopyWith<$Res> {
  factory _$TodoRequestCopyWith(_TodoRequest value, $Res Function(_TodoRequest) _then) = __$TodoRequestCopyWithImpl;
@override @useResult
$Res call({
 String note, String? placeId
});




}
/// @nodoc
class __$TodoRequestCopyWithImpl<$Res>
    implements _$TodoRequestCopyWith<$Res> {
  __$TodoRequestCopyWithImpl(this._self, this._then);

  final _TodoRequest _self;
  final $Res Function(_TodoRequest) _then;

/// Create a copy of TodoRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? note = null,Object? placeId = freezed,}) {
  return _then(_TodoRequest(
note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
