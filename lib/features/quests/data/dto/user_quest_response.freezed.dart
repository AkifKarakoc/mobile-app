// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_quest_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserQuestResponse {

 String get id; String get questId; String get questTitle; String get questDescription; String? get questThumbnailUrl; String get status; String get startedAt; String? get completedAt; int get totalSteps; int get completedSteps;
/// Create a copy of UserQuestResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserQuestResponseCopyWith<UserQuestResponse> get copyWith => _$UserQuestResponseCopyWithImpl<UserQuestResponse>(this as UserQuestResponse, _$identity);

  /// Serializes this UserQuestResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserQuestResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.questTitle, questTitle) || other.questTitle == questTitle)&&(identical(other.questDescription, questDescription) || other.questDescription == questDescription)&&(identical(other.questThumbnailUrl, questThumbnailUrl) || other.questThumbnailUrl == questThumbnailUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.totalSteps, totalSteps) || other.totalSteps == totalSteps)&&(identical(other.completedSteps, completedSteps) || other.completedSteps == completedSteps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,questId,questTitle,questDescription,questThumbnailUrl,status,startedAt,completedAt,totalSteps,completedSteps);

@override
String toString() {
  return 'UserQuestResponse(id: $id, questId: $questId, questTitle: $questTitle, questDescription: $questDescription, questThumbnailUrl: $questThumbnailUrl, status: $status, startedAt: $startedAt, completedAt: $completedAt, totalSteps: $totalSteps, completedSteps: $completedSteps)';
}


}

/// @nodoc
abstract mixin class $UserQuestResponseCopyWith<$Res>  {
  factory $UserQuestResponseCopyWith(UserQuestResponse value, $Res Function(UserQuestResponse) _then) = _$UserQuestResponseCopyWithImpl;
@useResult
$Res call({
 String id, String questId, String questTitle, String questDescription, String? questThumbnailUrl, String status, String startedAt, String? completedAt, int totalSteps, int completedSteps
});




}
/// @nodoc
class _$UserQuestResponseCopyWithImpl<$Res>
    implements $UserQuestResponseCopyWith<$Res> {
  _$UserQuestResponseCopyWithImpl(this._self, this._then);

  final UserQuestResponse _self;
  final $Res Function(UserQuestResponse) _then;

/// Create a copy of UserQuestResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? questId = null,Object? questTitle = null,Object? questDescription = null,Object? questThumbnailUrl = freezed,Object? status = null,Object? startedAt = null,Object? completedAt = freezed,Object? totalSteps = null,Object? completedSteps = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as String,questTitle: null == questTitle ? _self.questTitle : questTitle // ignore: cast_nullable_to_non_nullable
as String,questDescription: null == questDescription ? _self.questDescription : questDescription // ignore: cast_nullable_to_non_nullable
as String,questThumbnailUrl: freezed == questThumbnailUrl ? _self.questThumbnailUrl : questThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,totalSteps: null == totalSteps ? _self.totalSteps : totalSteps // ignore: cast_nullable_to_non_nullable
as int,completedSteps: null == completedSteps ? _self.completedSteps : completedSteps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserQuestResponse].
extension UserQuestResponsePatterns on UserQuestResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserQuestResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserQuestResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserQuestResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserQuestResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserQuestResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserQuestResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String questId,  String questTitle,  String questDescription,  String? questThumbnailUrl,  String status,  String startedAt,  String? completedAt,  int totalSteps,  int completedSteps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserQuestResponse() when $default != null:
return $default(_that.id,_that.questId,_that.questTitle,_that.questDescription,_that.questThumbnailUrl,_that.status,_that.startedAt,_that.completedAt,_that.totalSteps,_that.completedSteps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String questId,  String questTitle,  String questDescription,  String? questThumbnailUrl,  String status,  String startedAt,  String? completedAt,  int totalSteps,  int completedSteps)  $default,) {final _that = this;
switch (_that) {
case _UserQuestResponse():
return $default(_that.id,_that.questId,_that.questTitle,_that.questDescription,_that.questThumbnailUrl,_that.status,_that.startedAt,_that.completedAt,_that.totalSteps,_that.completedSteps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String questId,  String questTitle,  String questDescription,  String? questThumbnailUrl,  String status,  String startedAt,  String? completedAt,  int totalSteps,  int completedSteps)?  $default,) {final _that = this;
switch (_that) {
case _UserQuestResponse() when $default != null:
return $default(_that.id,_that.questId,_that.questTitle,_that.questDescription,_that.questThumbnailUrl,_that.status,_that.startedAt,_that.completedAt,_that.totalSteps,_that.completedSteps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserQuestResponse implements UserQuestResponse {
  const _UserQuestResponse({required this.id, required this.questId, required this.questTitle, required this.questDescription, this.questThumbnailUrl, required this.status, required this.startedAt, this.completedAt, required this.totalSteps, required this.completedSteps});
  factory _UserQuestResponse.fromJson(Map<String, dynamic> json) => _$UserQuestResponseFromJson(json);

@override final  String id;
@override final  String questId;
@override final  String questTitle;
@override final  String questDescription;
@override final  String? questThumbnailUrl;
@override final  String status;
@override final  String startedAt;
@override final  String? completedAt;
@override final  int totalSteps;
@override final  int completedSteps;

/// Create a copy of UserQuestResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserQuestResponseCopyWith<_UserQuestResponse> get copyWith => __$UserQuestResponseCopyWithImpl<_UserQuestResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserQuestResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserQuestResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.questId, questId) || other.questId == questId)&&(identical(other.questTitle, questTitle) || other.questTitle == questTitle)&&(identical(other.questDescription, questDescription) || other.questDescription == questDescription)&&(identical(other.questThumbnailUrl, questThumbnailUrl) || other.questThumbnailUrl == questThumbnailUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.totalSteps, totalSteps) || other.totalSteps == totalSteps)&&(identical(other.completedSteps, completedSteps) || other.completedSteps == completedSteps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,questId,questTitle,questDescription,questThumbnailUrl,status,startedAt,completedAt,totalSteps,completedSteps);

@override
String toString() {
  return 'UserQuestResponse(id: $id, questId: $questId, questTitle: $questTitle, questDescription: $questDescription, questThumbnailUrl: $questThumbnailUrl, status: $status, startedAt: $startedAt, completedAt: $completedAt, totalSteps: $totalSteps, completedSteps: $completedSteps)';
}


}

/// @nodoc
abstract mixin class _$UserQuestResponseCopyWith<$Res> implements $UserQuestResponseCopyWith<$Res> {
  factory _$UserQuestResponseCopyWith(_UserQuestResponse value, $Res Function(_UserQuestResponse) _then) = __$UserQuestResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String questId, String questTitle, String questDescription, String? questThumbnailUrl, String status, String startedAt, String? completedAt, int totalSteps, int completedSteps
});




}
/// @nodoc
class __$UserQuestResponseCopyWithImpl<$Res>
    implements _$UserQuestResponseCopyWith<$Res> {
  __$UserQuestResponseCopyWithImpl(this._self, this._then);

  final _UserQuestResponse _self;
  final $Res Function(_UserQuestResponse) _then;

/// Create a copy of UserQuestResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? questId = null,Object? questTitle = null,Object? questDescription = null,Object? questThumbnailUrl = freezed,Object? status = null,Object? startedAt = null,Object? completedAt = freezed,Object? totalSteps = null,Object? completedSteps = null,}) {
  return _then(_UserQuestResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,questId: null == questId ? _self.questId : questId // ignore: cast_nullable_to_non_nullable
as String,questTitle: null == questTitle ? _self.questTitle : questTitle // ignore: cast_nullable_to_non_nullable
as String,questDescription: null == questDescription ? _self.questDescription : questDescription // ignore: cast_nullable_to_non_nullable
as String,questThumbnailUrl: freezed == questThumbnailUrl ? _self.questThumbnailUrl : questThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,totalSteps: null == totalSteps ? _self.totalSteps : totalSteps // ignore: cast_nullable_to_non_nullable
as int,completedSteps: null == completedSteps ? _self.completedSteps : completedSteps // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
