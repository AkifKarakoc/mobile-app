// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoResponse {

 String get id; String? get placeId; String get note; bool get isCompleted; DateTime get createdAt;
/// Create a copy of TodoResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoResponseCopyWith<TodoResponse> get copyWith => _$TodoResponseCopyWithImpl<TodoResponse>(this as TodoResponse, _$identity);

  /// Serializes this TodoResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.note, note) || other.note == note)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,note,isCompleted,createdAt);

@override
String toString() {
  return 'TodoResponse(id: $id, placeId: $placeId, note: $note, isCompleted: $isCompleted, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TodoResponseCopyWith<$Res>  {
  factory $TodoResponseCopyWith(TodoResponse value, $Res Function(TodoResponse) _then) = _$TodoResponseCopyWithImpl;
@useResult
$Res call({
 String id, String? placeId, String note, bool isCompleted, DateTime createdAt
});




}
/// @nodoc
class _$TodoResponseCopyWithImpl<$Res>
    implements $TodoResponseCopyWith<$Res> {
  _$TodoResponseCopyWithImpl(this._self, this._then);

  final TodoResponse _self;
  final $Res Function(TodoResponse) _then;

/// Create a copy of TodoResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placeId = freezed,Object? note = null,Object? isCompleted = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoResponse].
extension TodoResponsePatterns on TodoResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoResponse value)  $default,){
final _that = this;
switch (_that) {
case _TodoResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TodoResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? placeId,  String note,  bool isCompleted,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoResponse() when $default != null:
return $default(_that.id,_that.placeId,_that.note,_that.isCompleted,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? placeId,  String note,  bool isCompleted,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _TodoResponse():
return $default(_that.id,_that.placeId,_that.note,_that.isCompleted,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? placeId,  String note,  bool isCompleted,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TodoResponse() when $default != null:
return $default(_that.id,_that.placeId,_that.note,_that.isCompleted,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodoResponse implements TodoResponse {
  const _TodoResponse({required this.id, this.placeId, required this.note, required this.isCompleted, required this.createdAt});
  factory _TodoResponse.fromJson(Map<String, dynamic> json) => _$TodoResponseFromJson(json);

@override final  String id;
@override final  String? placeId;
@override final  String note;
@override final  bool isCompleted;
@override final  DateTime createdAt;

/// Create a copy of TodoResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoResponseCopyWith<_TodoResponse> get copyWith => __$TodoResponseCopyWithImpl<_TodoResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.note, note) || other.note == note)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,note,isCompleted,createdAt);

@override
String toString() {
  return 'TodoResponse(id: $id, placeId: $placeId, note: $note, isCompleted: $isCompleted, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TodoResponseCopyWith<$Res> implements $TodoResponseCopyWith<$Res> {
  factory _$TodoResponseCopyWith(_TodoResponse value, $Res Function(_TodoResponse) _then) = __$TodoResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String? placeId, String note, bool isCompleted, DateTime createdAt
});




}
/// @nodoc
class __$TodoResponseCopyWithImpl<$Res>
    implements _$TodoResponseCopyWith<$Res> {
  __$TodoResponseCopyWithImpl(this._self, this._then);

  final _TodoResponse _self;
  final $Res Function(_TodoResponse) _then;

/// Create a copy of TodoResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placeId = freezed,Object? note = null,Object? isCompleted = null,Object? createdAt = null,}) {
  return _then(_TodoResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
