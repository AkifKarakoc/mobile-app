// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_route_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRouteResponse {

 String get id; String get routeId; String get routeName; String get routeDescription; String? get routeThumbnailUrl; String get status; String get startedAt; String? get completedAt; int get totalStops;
/// Create a copy of UserRouteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserRouteResponseCopyWith<UserRouteResponse> get copyWith => _$UserRouteResponseCopyWithImpl<UserRouteResponse>(this as UserRouteResponse, _$identity);

  /// Serializes this UserRouteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRouteResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.routeName, routeName) || other.routeName == routeName)&&(identical(other.routeDescription, routeDescription) || other.routeDescription == routeDescription)&&(identical(other.routeThumbnailUrl, routeThumbnailUrl) || other.routeThumbnailUrl == routeThumbnailUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.totalStops, totalStops) || other.totalStops == totalStops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,routeId,routeName,routeDescription,routeThumbnailUrl,status,startedAt,completedAt,totalStops);

@override
String toString() {
  return 'UserRouteResponse(id: $id, routeId: $routeId, routeName: $routeName, routeDescription: $routeDescription, routeThumbnailUrl: $routeThumbnailUrl, status: $status, startedAt: $startedAt, completedAt: $completedAt, totalStops: $totalStops)';
}


}

/// @nodoc
abstract mixin class $UserRouteResponseCopyWith<$Res>  {
  factory $UserRouteResponseCopyWith(UserRouteResponse value, $Res Function(UserRouteResponse) _then) = _$UserRouteResponseCopyWithImpl;
@useResult
$Res call({
 String id, String routeId, String routeName, String routeDescription, String? routeThumbnailUrl, String status, String startedAt, String? completedAt, int totalStops
});




}
/// @nodoc
class _$UserRouteResponseCopyWithImpl<$Res>
    implements $UserRouteResponseCopyWith<$Res> {
  _$UserRouteResponseCopyWithImpl(this._self, this._then);

  final UserRouteResponse _self;
  final $Res Function(UserRouteResponse) _then;

/// Create a copy of UserRouteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? routeId = null,Object? routeName = null,Object? routeDescription = null,Object? routeThumbnailUrl = freezed,Object? status = null,Object? startedAt = null,Object? completedAt = freezed,Object? totalStops = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,routeName: null == routeName ? _self.routeName : routeName // ignore: cast_nullable_to_non_nullable
as String,routeDescription: null == routeDescription ? _self.routeDescription : routeDescription // ignore: cast_nullable_to_non_nullable
as String,routeThumbnailUrl: freezed == routeThumbnailUrl ? _self.routeThumbnailUrl : routeThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,totalStops: null == totalStops ? _self.totalStops : totalStops // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserRouteResponse].
extension UserRouteResponsePatterns on UserRouteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserRouteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserRouteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserRouteResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserRouteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserRouteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserRouteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String routeId,  String routeName,  String routeDescription,  String? routeThumbnailUrl,  String status,  String startedAt,  String? completedAt,  int totalStops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserRouteResponse() when $default != null:
return $default(_that.id,_that.routeId,_that.routeName,_that.routeDescription,_that.routeThumbnailUrl,_that.status,_that.startedAt,_that.completedAt,_that.totalStops);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String routeId,  String routeName,  String routeDescription,  String? routeThumbnailUrl,  String status,  String startedAt,  String? completedAt,  int totalStops)  $default,) {final _that = this;
switch (_that) {
case _UserRouteResponse():
return $default(_that.id,_that.routeId,_that.routeName,_that.routeDescription,_that.routeThumbnailUrl,_that.status,_that.startedAt,_that.completedAt,_that.totalStops);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String routeId,  String routeName,  String routeDescription,  String? routeThumbnailUrl,  String status,  String startedAt,  String? completedAt,  int totalStops)?  $default,) {final _that = this;
switch (_that) {
case _UserRouteResponse() when $default != null:
return $default(_that.id,_that.routeId,_that.routeName,_that.routeDescription,_that.routeThumbnailUrl,_that.status,_that.startedAt,_that.completedAt,_that.totalStops);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserRouteResponse implements UserRouteResponse {
  const _UserRouteResponse({required this.id, required this.routeId, required this.routeName, required this.routeDescription, this.routeThumbnailUrl, required this.status, required this.startedAt, this.completedAt, required this.totalStops});
  factory _UserRouteResponse.fromJson(Map<String, dynamic> json) => _$UserRouteResponseFromJson(json);

@override final  String id;
@override final  String routeId;
@override final  String routeName;
@override final  String routeDescription;
@override final  String? routeThumbnailUrl;
@override final  String status;
@override final  String startedAt;
@override final  String? completedAt;
@override final  int totalStops;

/// Create a copy of UserRouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRouteResponseCopyWith<_UserRouteResponse> get copyWith => __$UserRouteResponseCopyWithImpl<_UserRouteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserRouteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRouteResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.routeName, routeName) || other.routeName == routeName)&&(identical(other.routeDescription, routeDescription) || other.routeDescription == routeDescription)&&(identical(other.routeThumbnailUrl, routeThumbnailUrl) || other.routeThumbnailUrl == routeThumbnailUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.totalStops, totalStops) || other.totalStops == totalStops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,routeId,routeName,routeDescription,routeThumbnailUrl,status,startedAt,completedAt,totalStops);

@override
String toString() {
  return 'UserRouteResponse(id: $id, routeId: $routeId, routeName: $routeName, routeDescription: $routeDescription, routeThumbnailUrl: $routeThumbnailUrl, status: $status, startedAt: $startedAt, completedAt: $completedAt, totalStops: $totalStops)';
}


}

/// @nodoc
abstract mixin class _$UserRouteResponseCopyWith<$Res> implements $UserRouteResponseCopyWith<$Res> {
  factory _$UserRouteResponseCopyWith(_UserRouteResponse value, $Res Function(_UserRouteResponse) _then) = __$UserRouteResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String routeId, String routeName, String routeDescription, String? routeThumbnailUrl, String status, String startedAt, String? completedAt, int totalStops
});




}
/// @nodoc
class __$UserRouteResponseCopyWithImpl<$Res>
    implements _$UserRouteResponseCopyWith<$Res> {
  __$UserRouteResponseCopyWithImpl(this._self, this._then);

  final _UserRouteResponse _self;
  final $Res Function(_UserRouteResponse) _then;

/// Create a copy of UserRouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? routeId = null,Object? routeName = null,Object? routeDescription = null,Object? routeThumbnailUrl = freezed,Object? status = null,Object? startedAt = null,Object? completedAt = freezed,Object? totalStops = null,}) {
  return _then(_UserRouteResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,routeName: null == routeName ? _self.routeName : routeName // ignore: cast_nullable_to_non_nullable
as String,routeDescription: null == routeDescription ? _self.routeDescription : routeDescription // ignore: cast_nullable_to_non_nullable
as String,routeThumbnailUrl: freezed == routeThumbnailUrl ? _self.routeThumbnailUrl : routeThumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,totalStops: null == totalStops ? _self.totalStops : totalStops // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
