// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quest_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestResponse {

 String get id; String get title; String get description; int get expReward; String get region; String? get thumbnailUrl; int get totalSteps; String? get userStatus;
/// Create a copy of QuestResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestResponseCopyWith<QuestResponse> get copyWith => _$QuestResponseCopyWithImpl<QuestResponse>(this as QuestResponse, _$identity);

  /// Serializes this QuestResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.expReward, expReward) || other.expReward == expReward)&&(identical(other.region, region) || other.region == region)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.totalSteps, totalSteps) || other.totalSteps == totalSteps)&&(identical(other.userStatus, userStatus) || other.userStatus == userStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,expReward,region,thumbnailUrl,totalSteps,userStatus);

@override
String toString() {
  return 'QuestResponse(id: $id, title: $title, description: $description, expReward: $expReward, region: $region, thumbnailUrl: $thumbnailUrl, totalSteps: $totalSteps, userStatus: $userStatus)';
}


}

/// @nodoc
abstract mixin class $QuestResponseCopyWith<$Res>  {
  factory $QuestResponseCopyWith(QuestResponse value, $Res Function(QuestResponse) _then) = _$QuestResponseCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, int expReward, String region, String? thumbnailUrl, int totalSteps, String? userStatus
});




}
/// @nodoc
class _$QuestResponseCopyWithImpl<$Res>
    implements $QuestResponseCopyWith<$Res> {
  _$QuestResponseCopyWithImpl(this._self, this._then);

  final QuestResponse _self;
  final $Res Function(QuestResponse) _then;

/// Create a copy of QuestResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? expReward = null,Object? region = null,Object? thumbnailUrl = freezed,Object? totalSteps = null,Object? userStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,expReward: null == expReward ? _self.expReward : expReward // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,totalSteps: null == totalSteps ? _self.totalSteps : totalSteps // ignore: cast_nullable_to_non_nullable
as int,userStatus: freezed == userStatus ? _self.userStatus : userStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestResponse].
extension QuestResponsePatterns on QuestResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestResponse value)  $default,){
final _that = this;
switch (_that) {
case _QuestResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestResponse value)?  $default,){
final _that = this;
switch (_that) {
case _QuestResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  int expReward,  String region,  String? thumbnailUrl,  int totalSteps,  String? userStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestResponse() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.expReward,_that.region,_that.thumbnailUrl,_that.totalSteps,_that.userStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  int expReward,  String region,  String? thumbnailUrl,  int totalSteps,  String? userStatus)  $default,) {final _that = this;
switch (_that) {
case _QuestResponse():
return $default(_that.id,_that.title,_that.description,_that.expReward,_that.region,_that.thumbnailUrl,_that.totalSteps,_that.userStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  int expReward,  String region,  String? thumbnailUrl,  int totalSteps,  String? userStatus)?  $default,) {final _that = this;
switch (_that) {
case _QuestResponse() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.expReward,_that.region,_that.thumbnailUrl,_that.totalSteps,_that.userStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestResponse implements QuestResponse {
  const _QuestResponse({required this.id, required this.title, required this.description, required this.expReward, required this.region, this.thumbnailUrl, required this.totalSteps, this.userStatus});
  factory _QuestResponse.fromJson(Map<String, dynamic> json) => _$QuestResponseFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  int expReward;
@override final  String region;
@override final  String? thumbnailUrl;
@override final  int totalSteps;
@override final  String? userStatus;

/// Create a copy of QuestResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestResponseCopyWith<_QuestResponse> get copyWith => __$QuestResponseCopyWithImpl<_QuestResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.expReward, expReward) || other.expReward == expReward)&&(identical(other.region, region) || other.region == region)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.totalSteps, totalSteps) || other.totalSteps == totalSteps)&&(identical(other.userStatus, userStatus) || other.userStatus == userStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,expReward,region,thumbnailUrl,totalSteps,userStatus);

@override
String toString() {
  return 'QuestResponse(id: $id, title: $title, description: $description, expReward: $expReward, region: $region, thumbnailUrl: $thumbnailUrl, totalSteps: $totalSteps, userStatus: $userStatus)';
}


}

/// @nodoc
abstract mixin class _$QuestResponseCopyWith<$Res> implements $QuestResponseCopyWith<$Res> {
  factory _$QuestResponseCopyWith(_QuestResponse value, $Res Function(_QuestResponse) _then) = __$QuestResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, int expReward, String region, String? thumbnailUrl, int totalSteps, String? userStatus
});




}
/// @nodoc
class __$QuestResponseCopyWithImpl<$Res>
    implements _$QuestResponseCopyWith<$Res> {
  __$QuestResponseCopyWithImpl(this._self, this._then);

  final _QuestResponse _self;
  final $Res Function(_QuestResponse) _then;

/// Create a copy of QuestResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? expReward = null,Object? region = null,Object? thumbnailUrl = freezed,Object? totalSteps = null,Object? userStatus = freezed,}) {
  return _then(_QuestResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,expReward: null == expReward ? _self.expReward : expReward // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,totalSteps: null == totalSteps ? _self.totalSteps : totalSteps // ignore: cast_nullable_to_non_nullable
as int,userStatus: freezed == userStatus ? _self.userStatus : userStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
