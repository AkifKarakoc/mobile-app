// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accept_route_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AcceptRouteResponse {

 String get userRouteId; String get routeId; String get status; String get startedAt;
/// Create a copy of AcceptRouteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AcceptRouteResponseCopyWith<AcceptRouteResponse> get copyWith => _$AcceptRouteResponseCopyWithImpl<AcceptRouteResponse>(this as AcceptRouteResponse, _$identity);

  /// Serializes this AcceptRouteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcceptRouteResponse&&(identical(other.userRouteId, userRouteId) || other.userRouteId == userRouteId)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userRouteId,routeId,status,startedAt);

@override
String toString() {
  return 'AcceptRouteResponse(userRouteId: $userRouteId, routeId: $routeId, status: $status, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class $AcceptRouteResponseCopyWith<$Res>  {
  factory $AcceptRouteResponseCopyWith(AcceptRouteResponse value, $Res Function(AcceptRouteResponse) _then) = _$AcceptRouteResponseCopyWithImpl;
@useResult
$Res call({
 String userRouteId, String routeId, String status, String startedAt
});




}
/// @nodoc
class _$AcceptRouteResponseCopyWithImpl<$Res>
    implements $AcceptRouteResponseCopyWith<$Res> {
  _$AcceptRouteResponseCopyWithImpl(this._self, this._then);

  final AcceptRouteResponse _self;
  final $Res Function(AcceptRouteResponse) _then;

/// Create a copy of AcceptRouteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userRouteId = null,Object? routeId = null,Object? status = null,Object? startedAt = null,}) {
  return _then(_self.copyWith(
userRouteId: null == userRouteId ? _self.userRouteId : userRouteId // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AcceptRouteResponse].
extension AcceptRouteResponsePatterns on AcceptRouteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AcceptRouteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AcceptRouteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AcceptRouteResponse value)  $default,){
final _that = this;
switch (_that) {
case _AcceptRouteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AcceptRouteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AcceptRouteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userRouteId,  String routeId,  String status,  String startedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AcceptRouteResponse() when $default != null:
return $default(_that.userRouteId,_that.routeId,_that.status,_that.startedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userRouteId,  String routeId,  String status,  String startedAt)  $default,) {final _that = this;
switch (_that) {
case _AcceptRouteResponse():
return $default(_that.userRouteId,_that.routeId,_that.status,_that.startedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userRouteId,  String routeId,  String status,  String startedAt)?  $default,) {final _that = this;
switch (_that) {
case _AcceptRouteResponse() when $default != null:
return $default(_that.userRouteId,_that.routeId,_that.status,_that.startedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AcceptRouteResponse implements AcceptRouteResponse {
  const _AcceptRouteResponse({required this.userRouteId, required this.routeId, required this.status, required this.startedAt});
  factory _AcceptRouteResponse.fromJson(Map<String, dynamic> json) => _$AcceptRouteResponseFromJson(json);

@override final  String userRouteId;
@override final  String routeId;
@override final  String status;
@override final  String startedAt;

/// Create a copy of AcceptRouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptRouteResponseCopyWith<_AcceptRouteResponse> get copyWith => __$AcceptRouteResponseCopyWithImpl<_AcceptRouteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AcceptRouteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptRouteResponse&&(identical(other.userRouteId, userRouteId) || other.userRouteId == userRouteId)&&(identical(other.routeId, routeId) || other.routeId == routeId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userRouteId,routeId,status,startedAt);

@override
String toString() {
  return 'AcceptRouteResponse(userRouteId: $userRouteId, routeId: $routeId, status: $status, startedAt: $startedAt)';
}


}

/// @nodoc
abstract mixin class _$AcceptRouteResponseCopyWith<$Res> implements $AcceptRouteResponseCopyWith<$Res> {
  factory _$AcceptRouteResponseCopyWith(_AcceptRouteResponse value, $Res Function(_AcceptRouteResponse) _then) = __$AcceptRouteResponseCopyWithImpl;
@override @useResult
$Res call({
 String userRouteId, String routeId, String status, String startedAt
});




}
/// @nodoc
class __$AcceptRouteResponseCopyWithImpl<$Res>
    implements _$AcceptRouteResponseCopyWith<$Res> {
  __$AcceptRouteResponseCopyWithImpl(this._self, this._then);

  final _AcceptRouteResponse _self;
  final $Res Function(_AcceptRouteResponse) _then;

/// Create a copy of AcceptRouteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userRouteId = null,Object? routeId = null,Object? status = null,Object? startedAt = null,}) {
  return _then(_AcceptRouteResponse(
userRouteId: null == userRouteId ? _self.userRouteId : userRouteId // ignore: cast_nullable_to_non_nullable
as String,routeId: null == routeId ? _self.routeId : routeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
