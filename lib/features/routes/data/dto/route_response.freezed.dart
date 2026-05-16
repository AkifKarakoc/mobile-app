// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RouteResponse {

 String get id; String get name; String? get description; DateTime? get createdAt; double get centerLatitude; double get centerLongitude; int get radiusMeters; int get estimatedMinutes; int get expReward; String? get thumbnailUrl; int get gpsThresholdMeters; int? get totalStops; String? get userStatus; List<RoutePlaceResponse> get places;
/// Create a copy of RouteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteResponseCopyWith<RouteResponse> get copyWith => _$RouteResponseCopyWithImpl<RouteResponse>(this as RouteResponse, _$identity);

  /// Serializes this RouteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.centerLatitude, centerLatitude) || other.centerLatitude == centerLatitude)&&(identical(other.centerLongitude, centerLongitude) || other.centerLongitude == centerLongitude)&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.expReward, expReward) || other.expReward == expReward)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.gpsThresholdMeters, gpsThresholdMeters) || other.gpsThresholdMeters == gpsThresholdMeters)&&(identical(other.totalStops, totalStops) || other.totalStops == totalStops)&&(identical(other.userStatus, userStatus) || other.userStatus == userStatus)&&const DeepCollectionEquality().equals(other.places, places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt,centerLatitude,centerLongitude,radiusMeters,estimatedMinutes,expReward,thumbnailUrl,gpsThresholdMeters,totalStops,userStatus,const DeepCollectionEquality().hash(places));

@override
String toString() {
  return 'RouteResponse(id: $id, name: $name, description: $description, createdAt: $createdAt, centerLatitude: $centerLatitude, centerLongitude: $centerLongitude, radiusMeters: $radiusMeters, estimatedMinutes: $estimatedMinutes, expReward: $expReward, thumbnailUrl: $thumbnailUrl, gpsThresholdMeters: $gpsThresholdMeters, totalStops: $totalStops, userStatus: $userStatus, places: $places)';
}


}

/// @nodoc
abstract mixin class $RouteResponseCopyWith<$Res>  {
  factory $RouteResponseCopyWith(RouteResponse value, $Res Function(RouteResponse) _then) = _$RouteResponseCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, DateTime? createdAt, double centerLatitude, double centerLongitude, int radiusMeters, int estimatedMinutes, int expReward, String? thumbnailUrl, int gpsThresholdMeters, int? totalStops, String? userStatus, List<RoutePlaceResponse> places
});




}
/// @nodoc
class _$RouteResponseCopyWithImpl<$Res>
    implements $RouteResponseCopyWith<$Res> {
  _$RouteResponseCopyWithImpl(this._self, this._then);

  final RouteResponse _self;
  final $Res Function(RouteResponse) _then;

/// Create a copy of RouteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? createdAt = freezed,Object? centerLatitude = null,Object? centerLongitude = null,Object? radiusMeters = null,Object? estimatedMinutes = null,Object? expReward = null,Object? thumbnailUrl = freezed,Object? gpsThresholdMeters = null,Object? totalStops = freezed,Object? userStatus = freezed,Object? places = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,centerLatitude: null == centerLatitude ? _self.centerLatitude : centerLatitude // ignore: cast_nullable_to_non_nullable
as double,centerLongitude: null == centerLongitude ? _self.centerLongitude : centerLongitude // ignore: cast_nullable_to_non_nullable
as double,radiusMeters: null == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as int,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,expReward: null == expReward ? _self.expReward : expReward // ignore: cast_nullable_to_non_nullable
as int,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,gpsThresholdMeters: null == gpsThresholdMeters ? _self.gpsThresholdMeters : gpsThresholdMeters // ignore: cast_nullable_to_non_nullable
as int,totalStops: freezed == totalStops ? _self.totalStops : totalStops // ignore: cast_nullable_to_non_nullable
as int?,userStatus: freezed == userStatus ? _self.userStatus : userStatus // ignore: cast_nullable_to_non_nullable
as String?,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<RoutePlaceResponse>,
  ));
}

}


/// Adds pattern-matching-related methods to [RouteResponse].
extension RouteResponsePatterns on RouteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteResponse value)  $default,){
final _that = this;
switch (_that) {
case _RouteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RouteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  DateTime? createdAt,  double centerLatitude,  double centerLongitude,  int radiusMeters,  int estimatedMinutes,  int expReward,  String? thumbnailUrl,  int gpsThresholdMeters,  int? totalStops,  String? userStatus,  List<RoutePlaceResponse> places)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteResponse() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.centerLatitude,_that.centerLongitude,_that.radiusMeters,_that.estimatedMinutes,_that.expReward,_that.thumbnailUrl,_that.gpsThresholdMeters,_that.totalStops,_that.userStatus,_that.places);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  DateTime? createdAt,  double centerLatitude,  double centerLongitude,  int radiusMeters,  int estimatedMinutes,  int expReward,  String? thumbnailUrl,  int gpsThresholdMeters,  int? totalStops,  String? userStatus,  List<RoutePlaceResponse> places)  $default,) {final _that = this;
switch (_that) {
case _RouteResponse():
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.centerLatitude,_that.centerLongitude,_that.radiusMeters,_that.estimatedMinutes,_that.expReward,_that.thumbnailUrl,_that.gpsThresholdMeters,_that.totalStops,_that.userStatus,_that.places);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  DateTime? createdAt,  double centerLatitude,  double centerLongitude,  int radiusMeters,  int estimatedMinutes,  int expReward,  String? thumbnailUrl,  int gpsThresholdMeters,  int? totalStops,  String? userStatus,  List<RoutePlaceResponse> places)?  $default,) {final _that = this;
switch (_that) {
case _RouteResponse() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.centerLatitude,_that.centerLongitude,_that.radiusMeters,_that.estimatedMinutes,_that.expReward,_that.thumbnailUrl,_that.gpsThresholdMeters,_that.totalStops,_that.userStatus,_that.places);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RouteResponse implements RouteResponse {
  const _RouteResponse({required this.id, required this.name, this.description, this.createdAt, required this.centerLatitude, required this.centerLongitude, required this.radiusMeters, required this.estimatedMinutes, required this.expReward, this.thumbnailUrl, this.gpsThresholdMeters = 200, this.totalStops, this.userStatus, required final  List<RoutePlaceResponse> places}): _places = places;
  factory _RouteResponse.fromJson(Map<String, dynamic> json) => _$RouteResponseFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  DateTime? createdAt;
@override final  double centerLatitude;
@override final  double centerLongitude;
@override final  int radiusMeters;
@override final  int estimatedMinutes;
@override final  int expReward;
@override final  String? thumbnailUrl;
@override@JsonKey() final  int gpsThresholdMeters;
@override final  int? totalStops;
@override final  String? userStatus;
 final  List<RoutePlaceResponse> _places;
@override List<RoutePlaceResponse> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}


/// Create a copy of RouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteResponseCopyWith<_RouteResponse> get copyWith => __$RouteResponseCopyWithImpl<_RouteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RouteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.centerLatitude, centerLatitude) || other.centerLatitude == centerLatitude)&&(identical(other.centerLongitude, centerLongitude) || other.centerLongitude == centerLongitude)&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.expReward, expReward) || other.expReward == expReward)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.gpsThresholdMeters, gpsThresholdMeters) || other.gpsThresholdMeters == gpsThresholdMeters)&&(identical(other.totalStops, totalStops) || other.totalStops == totalStops)&&(identical(other.userStatus, userStatus) || other.userStatus == userStatus)&&const DeepCollectionEquality().equals(other._places, _places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt,centerLatitude,centerLongitude,radiusMeters,estimatedMinutes,expReward,thumbnailUrl,gpsThresholdMeters,totalStops,userStatus,const DeepCollectionEquality().hash(_places));

@override
String toString() {
  return 'RouteResponse(id: $id, name: $name, description: $description, createdAt: $createdAt, centerLatitude: $centerLatitude, centerLongitude: $centerLongitude, radiusMeters: $radiusMeters, estimatedMinutes: $estimatedMinutes, expReward: $expReward, thumbnailUrl: $thumbnailUrl, gpsThresholdMeters: $gpsThresholdMeters, totalStops: $totalStops, userStatus: $userStatus, places: $places)';
}


}

/// @nodoc
abstract mixin class _$RouteResponseCopyWith<$Res> implements $RouteResponseCopyWith<$Res> {
  factory _$RouteResponseCopyWith(_RouteResponse value, $Res Function(_RouteResponse) _then) = __$RouteResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, DateTime? createdAt, double centerLatitude, double centerLongitude, int radiusMeters, int estimatedMinutes, int expReward, String? thumbnailUrl, int gpsThresholdMeters, int? totalStops, String? userStatus, List<RoutePlaceResponse> places
});




}
/// @nodoc
class __$RouteResponseCopyWithImpl<$Res>
    implements _$RouteResponseCopyWith<$Res> {
  __$RouteResponseCopyWithImpl(this._self, this._then);

  final _RouteResponse _self;
  final $Res Function(_RouteResponse) _then;

/// Create a copy of RouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? createdAt = freezed,Object? centerLatitude = null,Object? centerLongitude = null,Object? radiusMeters = null,Object? estimatedMinutes = null,Object? expReward = null,Object? thumbnailUrl = freezed,Object? gpsThresholdMeters = null,Object? totalStops = freezed,Object? userStatus = freezed,Object? places = null,}) {
  return _then(_RouteResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,centerLatitude: null == centerLatitude ? _self.centerLatitude : centerLatitude // ignore: cast_nullable_to_non_nullable
as double,centerLongitude: null == centerLongitude ? _self.centerLongitude : centerLongitude // ignore: cast_nullable_to_non_nullable
as double,radiusMeters: null == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as int,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,expReward: null == expReward ? _self.expReward : expReward // ignore: cast_nullable_to_non_nullable
as int,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,gpsThresholdMeters: null == gpsThresholdMeters ? _self.gpsThresholdMeters : gpsThresholdMeters // ignore: cast_nullable_to_non_nullable
as int,totalStops: freezed == totalStops ? _self.totalStops : totalStops // ignore: cast_nullable_to_non_nullable
as int?,userStatus: freezed == userStatus ? _self.userStatus : userStatus // ignore: cast_nullable_to_non_nullable
as String?,places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<RoutePlaceResponse>,
  ));
}


}


/// @nodoc
mixin _$RoutePlaceResponse {

 String? get id; String get placeId; int get stopOrder; int? get estimatedMinutes; String? get notes; double? get latitude; double? get longitude; String? get placeName; bool get completed;
/// Create a copy of RoutePlaceResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutePlaceResponseCopyWith<RoutePlaceResponse> get copyWith => _$RoutePlaceResponseCopyWithImpl<RoutePlaceResponse>(this as RoutePlaceResponse, _$identity);

  /// Serializes this RoutePlaceResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutePlaceResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.stopOrder, stopOrder) || other.stopOrder == stopOrder)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,stopOrder,estimatedMinutes,notes,latitude,longitude,placeName,completed);

@override
String toString() {
  return 'RoutePlaceResponse(id: $id, placeId: $placeId, stopOrder: $stopOrder, estimatedMinutes: $estimatedMinutes, notes: $notes, latitude: $latitude, longitude: $longitude, placeName: $placeName, completed: $completed)';
}


}

/// @nodoc
abstract mixin class $RoutePlaceResponseCopyWith<$Res>  {
  factory $RoutePlaceResponseCopyWith(RoutePlaceResponse value, $Res Function(RoutePlaceResponse) _then) = _$RoutePlaceResponseCopyWithImpl;
@useResult
$Res call({
 String? id, String placeId, int stopOrder, int? estimatedMinutes, String? notes, double? latitude, double? longitude, String? placeName, bool completed
});




}
/// @nodoc
class _$RoutePlaceResponseCopyWithImpl<$Res>
    implements $RoutePlaceResponseCopyWith<$Res> {
  _$RoutePlaceResponseCopyWithImpl(this._self, this._then);

  final RoutePlaceResponse _self;
  final $Res Function(RoutePlaceResponse) _then;

/// Create a copy of RoutePlaceResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? placeId = null,Object? stopOrder = null,Object? estimatedMinutes = freezed,Object? notes = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? placeName = freezed,Object? completed = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,stopOrder: null == stopOrder ? _self.stopOrder : stopOrder // ignore: cast_nullable_to_non_nullable
as int,estimatedMinutes: freezed == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,placeName: freezed == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutePlaceResponse].
extension RoutePlaceResponsePatterns on RoutePlaceResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutePlaceResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutePlaceResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutePlaceResponse value)  $default,){
final _that = this;
switch (_that) {
case _RoutePlaceResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutePlaceResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RoutePlaceResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String placeId,  int stopOrder,  int? estimatedMinutes,  String? notes,  double? latitude,  double? longitude,  String? placeName,  bool completed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutePlaceResponse() when $default != null:
return $default(_that.id,_that.placeId,_that.stopOrder,_that.estimatedMinutes,_that.notes,_that.latitude,_that.longitude,_that.placeName,_that.completed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String placeId,  int stopOrder,  int? estimatedMinutes,  String? notes,  double? latitude,  double? longitude,  String? placeName,  bool completed)  $default,) {final _that = this;
switch (_that) {
case _RoutePlaceResponse():
return $default(_that.id,_that.placeId,_that.stopOrder,_that.estimatedMinutes,_that.notes,_that.latitude,_that.longitude,_that.placeName,_that.completed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String placeId,  int stopOrder,  int? estimatedMinutes,  String? notes,  double? latitude,  double? longitude,  String? placeName,  bool completed)?  $default,) {final _that = this;
switch (_that) {
case _RoutePlaceResponse() when $default != null:
return $default(_that.id,_that.placeId,_that.stopOrder,_that.estimatedMinutes,_that.notes,_that.latitude,_that.longitude,_that.placeName,_that.completed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoutePlaceResponse implements RoutePlaceResponse {
  const _RoutePlaceResponse({this.id, required this.placeId, required this.stopOrder, this.estimatedMinutes, this.notes, this.latitude, this.longitude, this.placeName, this.completed = false});
  factory _RoutePlaceResponse.fromJson(Map<String, dynamic> json) => _$RoutePlaceResponseFromJson(json);

@override final  String? id;
@override final  String placeId;
@override final  int stopOrder;
@override final  int? estimatedMinutes;
@override final  String? notes;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? placeName;
@override@JsonKey() final  bool completed;

/// Create a copy of RoutePlaceResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutePlaceResponseCopyWith<_RoutePlaceResponse> get copyWith => __$RoutePlaceResponseCopyWithImpl<_RoutePlaceResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoutePlaceResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutePlaceResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.stopOrder, stopOrder) || other.stopOrder == stopOrder)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,stopOrder,estimatedMinutes,notes,latitude,longitude,placeName,completed);

@override
String toString() {
  return 'RoutePlaceResponse(id: $id, placeId: $placeId, stopOrder: $stopOrder, estimatedMinutes: $estimatedMinutes, notes: $notes, latitude: $latitude, longitude: $longitude, placeName: $placeName, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$RoutePlaceResponseCopyWith<$Res> implements $RoutePlaceResponseCopyWith<$Res> {
  factory _$RoutePlaceResponseCopyWith(_RoutePlaceResponse value, $Res Function(_RoutePlaceResponse) _then) = __$RoutePlaceResponseCopyWithImpl;
@override @useResult
$Res call({
 String? id, String placeId, int stopOrder, int? estimatedMinutes, String? notes, double? latitude, double? longitude, String? placeName, bool completed
});




}
/// @nodoc
class __$RoutePlaceResponseCopyWithImpl<$Res>
    implements _$RoutePlaceResponseCopyWith<$Res> {
  __$RoutePlaceResponseCopyWithImpl(this._self, this._then);

  final _RoutePlaceResponse _self;
  final $Res Function(_RoutePlaceResponse) _then;

/// Create a copy of RoutePlaceResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? placeId = null,Object? stopOrder = null,Object? estimatedMinutes = freezed,Object? notes = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? placeName = freezed,Object? completed = null,}) {
  return _then(_RoutePlaceResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,stopOrder: null == stopOrder ? _self.stopOrder : stopOrder // ignore: cast_nullable_to_non_nullable
as int,estimatedMinutes: freezed == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,placeName: freezed == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
