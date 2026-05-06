// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BadgeResponse {

 String get id; String get name; String get description; String get iconName; String get iconColor; String? get tier; bool get earnedByUser;
/// Create a copy of BadgeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadgeResponseCopyWith<BadgeResponse> get copyWith => _$BadgeResponseCopyWithImpl<BadgeResponse>(this as BadgeResponse, _$identity);

  /// Serializes this BadgeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BadgeResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.iconColor, iconColor) || other.iconColor == iconColor)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.earnedByUser, earnedByUser) || other.earnedByUser == earnedByUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,iconName,iconColor,tier,earnedByUser);

@override
String toString() {
  return 'BadgeResponse(id: $id, name: $name, description: $description, iconName: $iconName, iconColor: $iconColor, tier: $tier, earnedByUser: $earnedByUser)';
}


}

/// @nodoc
abstract mixin class $BadgeResponseCopyWith<$Res>  {
  factory $BadgeResponseCopyWith(BadgeResponse value, $Res Function(BadgeResponse) _then) = _$BadgeResponseCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String iconName, String iconColor, String? tier, bool earnedByUser
});




}
/// @nodoc
class _$BadgeResponseCopyWithImpl<$Res>
    implements $BadgeResponseCopyWith<$Res> {
  _$BadgeResponseCopyWithImpl(this._self, this._then);

  final BadgeResponse _self;
  final $Res Function(BadgeResponse) _then;

/// Create a copy of BadgeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? iconName = null,Object? iconColor = null,Object? tier = freezed,Object? earnedByUser = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,iconColor: null == iconColor ? _self.iconColor : iconColor // ignore: cast_nullable_to_non_nullable
as String,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String?,earnedByUser: null == earnedByUser ? _self.earnedByUser : earnedByUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BadgeResponse].
extension BadgeResponsePatterns on BadgeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BadgeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BadgeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BadgeResponse value)  $default,){
final _that = this;
switch (_that) {
case _BadgeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BadgeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _BadgeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String iconName,  String iconColor,  String? tier,  bool earnedByUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BadgeResponse() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.iconName,_that.iconColor,_that.tier,_that.earnedByUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String iconName,  String iconColor,  String? tier,  bool earnedByUser)  $default,) {final _that = this;
switch (_that) {
case _BadgeResponse():
return $default(_that.id,_that.name,_that.description,_that.iconName,_that.iconColor,_that.tier,_that.earnedByUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String iconName,  String iconColor,  String? tier,  bool earnedByUser)?  $default,) {final _that = this;
switch (_that) {
case _BadgeResponse() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.iconName,_that.iconColor,_that.tier,_that.earnedByUser);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BadgeResponse implements BadgeResponse {
  const _BadgeResponse({required this.id, required this.name, required this.description, required this.iconName, required this.iconColor, this.tier, required this.earnedByUser});
  factory _BadgeResponse.fromJson(Map<String, dynamic> json) => _$BadgeResponseFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String iconName;
@override final  String iconColor;
@override final  String? tier;
@override final  bool earnedByUser;

/// Create a copy of BadgeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BadgeResponseCopyWith<_BadgeResponse> get copyWith => __$BadgeResponseCopyWithImpl<_BadgeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BadgeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BadgeResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.iconColor, iconColor) || other.iconColor == iconColor)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.earnedByUser, earnedByUser) || other.earnedByUser == earnedByUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,iconName,iconColor,tier,earnedByUser);

@override
String toString() {
  return 'BadgeResponse(id: $id, name: $name, description: $description, iconName: $iconName, iconColor: $iconColor, tier: $tier, earnedByUser: $earnedByUser)';
}


}

/// @nodoc
abstract mixin class _$BadgeResponseCopyWith<$Res> implements $BadgeResponseCopyWith<$Res> {
  factory _$BadgeResponseCopyWith(_BadgeResponse value, $Res Function(_BadgeResponse) _then) = __$BadgeResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String iconName, String iconColor, String? tier, bool earnedByUser
});




}
/// @nodoc
class __$BadgeResponseCopyWithImpl<$Res>
    implements _$BadgeResponseCopyWith<$Res> {
  __$BadgeResponseCopyWithImpl(this._self, this._then);

  final _BadgeResponse _self;
  final $Res Function(_BadgeResponse) _then;

/// Create a copy of BadgeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? iconName = null,Object? iconColor = null,Object? tier = freezed,Object? earnedByUser = null,}) {
  return _then(_BadgeResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,iconColor: null == iconColor ? _self.iconColor : iconColor // ignore: cast_nullable_to_non_nullable
as String,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String?,earnedByUser: null == earnedByUser ? _self.earnedByUser : earnedByUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$UserBadgeResponse {

 String get id; String get badgeId; String get badgeName; String get badgeDescription; String get badgeIconName; String get badgeIconColor; DateTime get earnedAt;
/// Create a copy of UserBadgeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserBadgeResponseCopyWith<UserBadgeResponse> get copyWith => _$UserBadgeResponseCopyWithImpl<UserBadgeResponse>(this as UserBadgeResponse, _$identity);

  /// Serializes this UserBadgeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserBadgeResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.badgeId, badgeId) || other.badgeId == badgeId)&&(identical(other.badgeName, badgeName) || other.badgeName == badgeName)&&(identical(other.badgeDescription, badgeDescription) || other.badgeDescription == badgeDescription)&&(identical(other.badgeIconName, badgeIconName) || other.badgeIconName == badgeIconName)&&(identical(other.badgeIconColor, badgeIconColor) || other.badgeIconColor == badgeIconColor)&&(identical(other.earnedAt, earnedAt) || other.earnedAt == earnedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,badgeId,badgeName,badgeDescription,badgeIconName,badgeIconColor,earnedAt);

@override
String toString() {
  return 'UserBadgeResponse(id: $id, badgeId: $badgeId, badgeName: $badgeName, badgeDescription: $badgeDescription, badgeIconName: $badgeIconName, badgeIconColor: $badgeIconColor, earnedAt: $earnedAt)';
}


}

/// @nodoc
abstract mixin class $UserBadgeResponseCopyWith<$Res>  {
  factory $UserBadgeResponseCopyWith(UserBadgeResponse value, $Res Function(UserBadgeResponse) _then) = _$UserBadgeResponseCopyWithImpl;
@useResult
$Res call({
 String id, String badgeId, String badgeName, String badgeDescription, String badgeIconName, String badgeIconColor, DateTime earnedAt
});




}
/// @nodoc
class _$UserBadgeResponseCopyWithImpl<$Res>
    implements $UserBadgeResponseCopyWith<$Res> {
  _$UserBadgeResponseCopyWithImpl(this._self, this._then);

  final UserBadgeResponse _self;
  final $Res Function(UserBadgeResponse) _then;

/// Create a copy of UserBadgeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? badgeId = null,Object? badgeName = null,Object? badgeDescription = null,Object? badgeIconName = null,Object? badgeIconColor = null,Object? earnedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,badgeId: null == badgeId ? _self.badgeId : badgeId // ignore: cast_nullable_to_non_nullable
as String,badgeName: null == badgeName ? _self.badgeName : badgeName // ignore: cast_nullable_to_non_nullable
as String,badgeDescription: null == badgeDescription ? _self.badgeDescription : badgeDescription // ignore: cast_nullable_to_non_nullable
as String,badgeIconName: null == badgeIconName ? _self.badgeIconName : badgeIconName // ignore: cast_nullable_to_non_nullable
as String,badgeIconColor: null == badgeIconColor ? _self.badgeIconColor : badgeIconColor // ignore: cast_nullable_to_non_nullable
as String,earnedAt: null == earnedAt ? _self.earnedAt : earnedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserBadgeResponse].
extension UserBadgeResponsePatterns on UserBadgeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserBadgeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserBadgeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserBadgeResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserBadgeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserBadgeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserBadgeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String badgeId,  String badgeName,  String badgeDescription,  String badgeIconName,  String badgeIconColor,  DateTime earnedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserBadgeResponse() when $default != null:
return $default(_that.id,_that.badgeId,_that.badgeName,_that.badgeDescription,_that.badgeIconName,_that.badgeIconColor,_that.earnedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String badgeId,  String badgeName,  String badgeDescription,  String badgeIconName,  String badgeIconColor,  DateTime earnedAt)  $default,) {final _that = this;
switch (_that) {
case _UserBadgeResponse():
return $default(_that.id,_that.badgeId,_that.badgeName,_that.badgeDescription,_that.badgeIconName,_that.badgeIconColor,_that.earnedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String badgeId,  String badgeName,  String badgeDescription,  String badgeIconName,  String badgeIconColor,  DateTime earnedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserBadgeResponse() when $default != null:
return $default(_that.id,_that.badgeId,_that.badgeName,_that.badgeDescription,_that.badgeIconName,_that.badgeIconColor,_that.earnedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserBadgeResponse implements UserBadgeResponse {
  const _UserBadgeResponse({required this.id, required this.badgeId, required this.badgeName, required this.badgeDescription, required this.badgeIconName, required this.badgeIconColor, required this.earnedAt});
  factory _UserBadgeResponse.fromJson(Map<String, dynamic> json) => _$UserBadgeResponseFromJson(json);

@override final  String id;
@override final  String badgeId;
@override final  String badgeName;
@override final  String badgeDescription;
@override final  String badgeIconName;
@override final  String badgeIconColor;
@override final  DateTime earnedAt;

/// Create a copy of UserBadgeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserBadgeResponseCopyWith<_UserBadgeResponse> get copyWith => __$UserBadgeResponseCopyWithImpl<_UserBadgeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserBadgeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserBadgeResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.badgeId, badgeId) || other.badgeId == badgeId)&&(identical(other.badgeName, badgeName) || other.badgeName == badgeName)&&(identical(other.badgeDescription, badgeDescription) || other.badgeDescription == badgeDescription)&&(identical(other.badgeIconName, badgeIconName) || other.badgeIconName == badgeIconName)&&(identical(other.badgeIconColor, badgeIconColor) || other.badgeIconColor == badgeIconColor)&&(identical(other.earnedAt, earnedAt) || other.earnedAt == earnedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,badgeId,badgeName,badgeDescription,badgeIconName,badgeIconColor,earnedAt);

@override
String toString() {
  return 'UserBadgeResponse(id: $id, badgeId: $badgeId, badgeName: $badgeName, badgeDescription: $badgeDescription, badgeIconName: $badgeIconName, badgeIconColor: $badgeIconColor, earnedAt: $earnedAt)';
}


}

/// @nodoc
abstract mixin class _$UserBadgeResponseCopyWith<$Res> implements $UserBadgeResponseCopyWith<$Res> {
  factory _$UserBadgeResponseCopyWith(_UserBadgeResponse value, $Res Function(_UserBadgeResponse) _then) = __$UserBadgeResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String badgeId, String badgeName, String badgeDescription, String badgeIconName, String badgeIconColor, DateTime earnedAt
});




}
/// @nodoc
class __$UserBadgeResponseCopyWithImpl<$Res>
    implements _$UserBadgeResponseCopyWith<$Res> {
  __$UserBadgeResponseCopyWithImpl(this._self, this._then);

  final _UserBadgeResponse _self;
  final $Res Function(_UserBadgeResponse) _then;

/// Create a copy of UserBadgeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? badgeId = null,Object? badgeName = null,Object? badgeDescription = null,Object? badgeIconName = null,Object? badgeIconColor = null,Object? earnedAt = null,}) {
  return _then(_UserBadgeResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,badgeId: null == badgeId ? _self.badgeId : badgeId // ignore: cast_nullable_to_non_nullable
as String,badgeName: null == badgeName ? _self.badgeName : badgeName // ignore: cast_nullable_to_non_nullable
as String,badgeDescription: null == badgeDescription ? _self.badgeDescription : badgeDescription // ignore: cast_nullable_to_non_nullable
as String,badgeIconName: null == badgeIconName ? _self.badgeIconName : badgeIconName // ignore: cast_nullable_to_non_nullable
as String,badgeIconColor: null == badgeIconColor ? _self.badgeIconColor : badgeIconColor // ignore: cast_nullable_to_non_nullable
as String,earnedAt: null == earnedAt ? _self.earnedAt : earnedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
