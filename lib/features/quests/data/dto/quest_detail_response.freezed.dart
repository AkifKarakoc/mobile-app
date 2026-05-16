// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quest_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestDetailResponse {

 String get id; String get title; String get description; int get expReward; String get region; String? get thumbnailUrl; String? get badgeId; int get gpsThresholdMeters; List<StepResponse> get steps; String? get userStatus;
/// Create a copy of QuestDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestDetailResponseCopyWith<QuestDetailResponse> get copyWith => _$QuestDetailResponseCopyWithImpl<QuestDetailResponse>(this as QuestDetailResponse, _$identity);

  /// Serializes this QuestDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestDetailResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.expReward, expReward) || other.expReward == expReward)&&(identical(other.region, region) || other.region == region)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.badgeId, badgeId) || other.badgeId == badgeId)&&(identical(other.gpsThresholdMeters, gpsThresholdMeters) || other.gpsThresholdMeters == gpsThresholdMeters)&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.userStatus, userStatus) || other.userStatus == userStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,expReward,region,thumbnailUrl,badgeId,gpsThresholdMeters,const DeepCollectionEquality().hash(steps),userStatus);

@override
String toString() {
  return 'QuestDetailResponse(id: $id, title: $title, description: $description, expReward: $expReward, region: $region, thumbnailUrl: $thumbnailUrl, badgeId: $badgeId, gpsThresholdMeters: $gpsThresholdMeters, steps: $steps, userStatus: $userStatus)';
}


}

/// @nodoc
abstract mixin class $QuestDetailResponseCopyWith<$Res>  {
  factory $QuestDetailResponseCopyWith(QuestDetailResponse value, $Res Function(QuestDetailResponse) _then) = _$QuestDetailResponseCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, int expReward, String region, String? thumbnailUrl, String? badgeId, int gpsThresholdMeters, List<StepResponse> steps, String? userStatus
});




}
/// @nodoc
class _$QuestDetailResponseCopyWithImpl<$Res>
    implements $QuestDetailResponseCopyWith<$Res> {
  _$QuestDetailResponseCopyWithImpl(this._self, this._then);

  final QuestDetailResponse _self;
  final $Res Function(QuestDetailResponse) _then;

/// Create a copy of QuestDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? expReward = null,Object? region = null,Object? thumbnailUrl = freezed,Object? badgeId = freezed,Object? gpsThresholdMeters = null,Object? steps = null,Object? userStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,expReward: null == expReward ? _self.expReward : expReward // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,badgeId: freezed == badgeId ? _self.badgeId : badgeId // ignore: cast_nullable_to_non_nullable
as String?,gpsThresholdMeters: null == gpsThresholdMeters ? _self.gpsThresholdMeters : gpsThresholdMeters // ignore: cast_nullable_to_non_nullable
as int,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<StepResponse>,userStatus: freezed == userStatus ? _self.userStatus : userStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestDetailResponse].
extension QuestDetailResponsePatterns on QuestDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _QuestDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _QuestDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  int expReward,  String region,  String? thumbnailUrl,  String? badgeId,  int gpsThresholdMeters,  List<StepResponse> steps,  String? userStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestDetailResponse() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.expReward,_that.region,_that.thumbnailUrl,_that.badgeId,_that.gpsThresholdMeters,_that.steps,_that.userStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  int expReward,  String region,  String? thumbnailUrl,  String? badgeId,  int gpsThresholdMeters,  List<StepResponse> steps,  String? userStatus)  $default,) {final _that = this;
switch (_that) {
case _QuestDetailResponse():
return $default(_that.id,_that.title,_that.description,_that.expReward,_that.region,_that.thumbnailUrl,_that.badgeId,_that.gpsThresholdMeters,_that.steps,_that.userStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  int expReward,  String region,  String? thumbnailUrl,  String? badgeId,  int gpsThresholdMeters,  List<StepResponse> steps,  String? userStatus)?  $default,) {final _that = this;
switch (_that) {
case _QuestDetailResponse() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.expReward,_that.region,_that.thumbnailUrl,_that.badgeId,_that.gpsThresholdMeters,_that.steps,_that.userStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestDetailResponse implements QuestDetailResponse {
  const _QuestDetailResponse({required this.id, required this.title, required this.description, required this.expReward, required this.region, this.thumbnailUrl, this.badgeId, this.gpsThresholdMeters = 200, required final  List<StepResponse> steps, this.userStatus}): _steps = steps;
  factory _QuestDetailResponse.fromJson(Map<String, dynamic> json) => _$QuestDetailResponseFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  int expReward;
@override final  String region;
@override final  String? thumbnailUrl;
@override final  String? badgeId;
@override@JsonKey() final  int gpsThresholdMeters;
 final  List<StepResponse> _steps;
@override List<StepResponse> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override final  String? userStatus;

/// Create a copy of QuestDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestDetailResponseCopyWith<_QuestDetailResponse> get copyWith => __$QuestDetailResponseCopyWithImpl<_QuestDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestDetailResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.expReward, expReward) || other.expReward == expReward)&&(identical(other.region, region) || other.region == region)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.badgeId, badgeId) || other.badgeId == badgeId)&&(identical(other.gpsThresholdMeters, gpsThresholdMeters) || other.gpsThresholdMeters == gpsThresholdMeters)&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.userStatus, userStatus) || other.userStatus == userStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,expReward,region,thumbnailUrl,badgeId,gpsThresholdMeters,const DeepCollectionEquality().hash(_steps),userStatus);

@override
String toString() {
  return 'QuestDetailResponse(id: $id, title: $title, description: $description, expReward: $expReward, region: $region, thumbnailUrl: $thumbnailUrl, badgeId: $badgeId, gpsThresholdMeters: $gpsThresholdMeters, steps: $steps, userStatus: $userStatus)';
}


}

/// @nodoc
abstract mixin class _$QuestDetailResponseCopyWith<$Res> implements $QuestDetailResponseCopyWith<$Res> {
  factory _$QuestDetailResponseCopyWith(_QuestDetailResponse value, $Res Function(_QuestDetailResponse) _then) = __$QuestDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, int expReward, String region, String? thumbnailUrl, String? badgeId, int gpsThresholdMeters, List<StepResponse> steps, String? userStatus
});




}
/// @nodoc
class __$QuestDetailResponseCopyWithImpl<$Res>
    implements _$QuestDetailResponseCopyWith<$Res> {
  __$QuestDetailResponseCopyWithImpl(this._self, this._then);

  final _QuestDetailResponse _self;
  final $Res Function(_QuestDetailResponse) _then;

/// Create a copy of QuestDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? expReward = null,Object? region = null,Object? thumbnailUrl = freezed,Object? badgeId = freezed,Object? gpsThresholdMeters = null,Object? steps = null,Object? userStatus = freezed,}) {
  return _then(_QuestDetailResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,expReward: null == expReward ? _self.expReward : expReward // ignore: cast_nullable_to_non_nullable
as int,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,badgeId: freezed == badgeId ? _self.badgeId : badgeId // ignore: cast_nullable_to_non_nullable
as String?,gpsThresholdMeters: null == gpsThresholdMeters ? _self.gpsThresholdMeters : gpsThresholdMeters // ignore: cast_nullable_to_non_nullable
as int,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<StepResponse>,userStatus: freezed == userStatus ? _self.userStatus : userStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StepResponse {

 String get id; String get placeId; int get stepOrder; String? get hint; bool get requiresPhoto; bool get isCompleted; double? get latitude; double? get longitude; String? get placeName;
/// Create a copy of StepResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepResponseCopyWith<StepResponse> get copyWith => _$StepResponseCopyWithImpl<StepResponse>(this as StepResponse, _$identity);

  /// Serializes this StepResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.stepOrder, stepOrder) || other.stepOrder == stepOrder)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.requiresPhoto, requiresPhoto) || other.requiresPhoto == requiresPhoto)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.placeName, placeName) || other.placeName == placeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,stepOrder,hint,requiresPhoto,isCompleted,latitude,longitude,placeName);

@override
String toString() {
  return 'StepResponse(id: $id, placeId: $placeId, stepOrder: $stepOrder, hint: $hint, requiresPhoto: $requiresPhoto, isCompleted: $isCompleted, latitude: $latitude, longitude: $longitude, placeName: $placeName)';
}


}

/// @nodoc
abstract mixin class $StepResponseCopyWith<$Res>  {
  factory $StepResponseCopyWith(StepResponse value, $Res Function(StepResponse) _then) = _$StepResponseCopyWithImpl;
@useResult
$Res call({
 String id, String placeId, int stepOrder, String? hint, bool requiresPhoto, bool isCompleted, double? latitude, double? longitude, String? placeName
});




}
/// @nodoc
class _$StepResponseCopyWithImpl<$Res>
    implements $StepResponseCopyWith<$Res> {
  _$StepResponseCopyWithImpl(this._self, this._then);

  final StepResponse _self;
  final $Res Function(StepResponse) _then;

/// Create a copy of StepResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placeId = null,Object? stepOrder = null,Object? hint = freezed,Object? requiresPhoto = null,Object? isCompleted = null,Object? latitude = freezed,Object? longitude = freezed,Object? placeName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,stepOrder: null == stepOrder ? _self.stepOrder : stepOrder // ignore: cast_nullable_to_non_nullable
as int,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,requiresPhoto: null == requiresPhoto ? _self.requiresPhoto : requiresPhoto // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,placeName: freezed == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StepResponse].
extension StepResponsePatterns on StepResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StepResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StepResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StepResponse value)  $default,){
final _that = this;
switch (_that) {
case _StepResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StepResponse value)?  $default,){
final _that = this;
switch (_that) {
case _StepResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String placeId,  int stepOrder,  String? hint,  bool requiresPhoto,  bool isCompleted,  double? latitude,  double? longitude,  String? placeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StepResponse() when $default != null:
return $default(_that.id,_that.placeId,_that.stepOrder,_that.hint,_that.requiresPhoto,_that.isCompleted,_that.latitude,_that.longitude,_that.placeName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String placeId,  int stepOrder,  String? hint,  bool requiresPhoto,  bool isCompleted,  double? latitude,  double? longitude,  String? placeName)  $default,) {final _that = this;
switch (_that) {
case _StepResponse():
return $default(_that.id,_that.placeId,_that.stepOrder,_that.hint,_that.requiresPhoto,_that.isCompleted,_that.latitude,_that.longitude,_that.placeName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String placeId,  int stepOrder,  String? hint,  bool requiresPhoto,  bool isCompleted,  double? latitude,  double? longitude,  String? placeName)?  $default,) {final _that = this;
switch (_that) {
case _StepResponse() when $default != null:
return $default(_that.id,_that.placeId,_that.stepOrder,_that.hint,_that.requiresPhoto,_that.isCompleted,_that.latitude,_that.longitude,_that.placeName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StepResponse implements StepResponse {
  const _StepResponse({required this.id, required this.placeId, required this.stepOrder, this.hint, required this.requiresPhoto, required this.isCompleted, this.latitude, this.longitude, this.placeName});
  factory _StepResponse.fromJson(Map<String, dynamic> json) => _$StepResponseFromJson(json);

@override final  String id;
@override final  String placeId;
@override final  int stepOrder;
@override final  String? hint;
@override final  bool requiresPhoto;
@override final  bool isCompleted;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? placeName;

/// Create a copy of StepResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepResponseCopyWith<_StepResponse> get copyWith => __$StepResponseCopyWithImpl<_StepResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StepResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.stepOrder, stepOrder) || other.stepOrder == stepOrder)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.requiresPhoto, requiresPhoto) || other.requiresPhoto == requiresPhoto)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.placeName, placeName) || other.placeName == placeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,stepOrder,hint,requiresPhoto,isCompleted,latitude,longitude,placeName);

@override
String toString() {
  return 'StepResponse(id: $id, placeId: $placeId, stepOrder: $stepOrder, hint: $hint, requiresPhoto: $requiresPhoto, isCompleted: $isCompleted, latitude: $latitude, longitude: $longitude, placeName: $placeName)';
}


}

/// @nodoc
abstract mixin class _$StepResponseCopyWith<$Res> implements $StepResponseCopyWith<$Res> {
  factory _$StepResponseCopyWith(_StepResponse value, $Res Function(_StepResponse) _then) = __$StepResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String placeId, int stepOrder, String? hint, bool requiresPhoto, bool isCompleted, double? latitude, double? longitude, String? placeName
});




}
/// @nodoc
class __$StepResponseCopyWithImpl<$Res>
    implements _$StepResponseCopyWith<$Res> {
  __$StepResponseCopyWithImpl(this._self, this._then);

  final _StepResponse _self;
  final $Res Function(_StepResponse) _then;

/// Create a copy of StepResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placeId = null,Object? stepOrder = null,Object? hint = freezed,Object? requiresPhoto = null,Object? isCompleted = null,Object? latitude = freezed,Object? longitude = freezed,Object? placeName = freezed,}) {
  return _then(_StepResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,stepOrder: null == stepOrder ? _self.stepOrder : stepOrder // ignore: cast_nullable_to_non_nullable
as int,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,requiresPhoto: null == requiresPhoto ? _self.requiresPhoto : requiresPhoto // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,placeName: freezed == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
