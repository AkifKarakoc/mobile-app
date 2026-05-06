// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_session_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatSessionResponse {

 String get sessionId; String get language; DateTime get startedAt;
/// Create a copy of ChatSessionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSessionResponseCopyWith<ChatSessionResponse> get copyWith => _$ChatSessionResponseCopyWithImpl<ChatSessionResponse>(this as ChatSessionResponse, _$identity);

  /// Serializes this ChatSessionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSessionResponse&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.language, language) || other.language == language)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,language,startedAt);

@override
String toString() {
  return 'ChatSessionResponse(sessionId: $sessionId, language: $language, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class $ChatSessionResponseCopyWith<$Res>  {
  factory $ChatSessionResponseCopyWith(ChatSessionResponse value, $Res Function(ChatSessionResponse) _then) = _$ChatSessionResponseCopyWithImpl;
@useResult
$Res call({
 String sessionId, String language, DateTime startedAt
});




}
/// @nodoc
class _$ChatSessionResponseCopyWithImpl<$Res>
    implements $ChatSessionResponseCopyWith<$Res> {
  _$ChatSessionResponseCopyWithImpl(this._self, this._then);

  final ChatSessionResponse _self;
  final $Res Function(ChatSessionResponse) _then;

/// Create a copy of ChatSessionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? language = null,Object? startedAt = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatSessionResponse].
extension ChatSessionResponsePatterns on ChatSessionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatSessionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatSessionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatSessionResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChatSessionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatSessionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChatSessionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String language,  DateTime startedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatSessionResponse() when $default != null:
return $default(_that.sessionId,_that.language,_that.startedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String language,  DateTime startedAt)  $default,) {final _that = this;
switch (_that) {
case _ChatSessionResponse():
return $default(_that.sessionId,_that.language,_that.startedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String language,  DateTime startedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatSessionResponse() when $default != null:
return $default(_that.sessionId,_that.language,_that.startedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatSessionResponse implements ChatSessionResponse {
  const _ChatSessionResponse({required this.sessionId, required this.language, required this.startedAt});
  factory _ChatSessionResponse.fromJson(Map<String, dynamic> json) => _$ChatSessionResponseFromJson(json);

@override final  String sessionId;
@override final  String language;
@override final  DateTime startedAt;

/// Create a copy of ChatSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatSessionResponseCopyWith<_ChatSessionResponse> get copyWith => __$ChatSessionResponseCopyWithImpl<_ChatSessionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatSessionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatSessionResponse&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.language, language) || other.language == language)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,language,startedAt);

@override
String toString() {
  return 'ChatSessionResponse(sessionId: $sessionId, language: $language, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class _$ChatSessionResponseCopyWith<$Res> implements $ChatSessionResponseCopyWith<$Res> {
  factory _$ChatSessionResponseCopyWith(_ChatSessionResponse value, $Res Function(_ChatSessionResponse) _then) = __$ChatSessionResponseCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String language, DateTime startedAt
});




}
/// @nodoc
class __$ChatSessionResponseCopyWithImpl<$Res>
    implements _$ChatSessionResponseCopyWith<$Res> {
  __$ChatSessionResponseCopyWithImpl(this._self, this._then);

  final _ChatSessionResponse _self;
  final $Res Function(_ChatSessionResponse) _then;

/// Create a copy of ChatSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? language = null,Object? startedAt = null,}) {
  return _then(_ChatSessionResponse(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
