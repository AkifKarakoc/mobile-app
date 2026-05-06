// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceResponse {

 String get id; String? get name; String? get nameTr; String? get nameEn; String? get category; double? get latitude; double? get longitude; String? get address; String? get photoUrl; double? get avgRating; int? get reviewCount; double? get distance; bool? get isFavorited;
/// Create a copy of PlaceResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceResponseCopyWith<PlaceResponse> get copyWith => _$PlaceResponseCopyWithImpl<PlaceResponse>(this as PlaceResponse, _$identity);

  /// Serializes this PlaceResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameTr, nameTr) || other.nameTr == nameTr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.category, category) || other.category == category)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,nameTr,nameEn,category,latitude,longitude,address,photoUrl,avgRating,reviewCount,distance,isFavorited);

@override
String toString() {
  return 'PlaceResponse(id: $id, name: $name, nameTr: $nameTr, nameEn: $nameEn, category: $category, latitude: $latitude, longitude: $longitude, address: $address, photoUrl: $photoUrl, avgRating: $avgRating, reviewCount: $reviewCount, distance: $distance, isFavorited: $isFavorited)';
}


}

/// @nodoc
abstract mixin class $PlaceResponseCopyWith<$Res>  {
  factory $PlaceResponseCopyWith(PlaceResponse value, $Res Function(PlaceResponse) _then) = _$PlaceResponseCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String? nameTr, String? nameEn, String? category, double? latitude, double? longitude, String? address, String? photoUrl, double? avgRating, int? reviewCount, double? distance, bool? isFavorited
});




}
/// @nodoc
class _$PlaceResponseCopyWithImpl<$Res>
    implements $PlaceResponseCopyWith<$Res> {
  _$PlaceResponseCopyWithImpl(this._self, this._then);

  final PlaceResponse _self;
  final $Res Function(PlaceResponse) _then;

/// Create a copy of PlaceResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? nameTr = freezed,Object? nameEn = freezed,Object? category = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,Object? photoUrl = freezed,Object? avgRating = freezed,Object? reviewCount = freezed,Object? distance = freezed,Object? isFavorited = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameTr: freezed == nameTr ? _self.nameTr : nameTr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,avgRating: freezed == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,isFavorited: freezed == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceResponse].
extension PlaceResponsePatterns on PlaceResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceResponse value)  $default,){
final _that = this;
switch (_that) {
case _PlaceResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String? nameTr,  String? nameEn,  String? category,  double? latitude,  double? longitude,  String? address,  String? photoUrl,  double? avgRating,  int? reviewCount,  double? distance,  bool? isFavorited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceResponse() when $default != null:
return $default(_that.id,_that.name,_that.nameTr,_that.nameEn,_that.category,_that.latitude,_that.longitude,_that.address,_that.photoUrl,_that.avgRating,_that.reviewCount,_that.distance,_that.isFavorited);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String? nameTr,  String? nameEn,  String? category,  double? latitude,  double? longitude,  String? address,  String? photoUrl,  double? avgRating,  int? reviewCount,  double? distance,  bool? isFavorited)  $default,) {final _that = this;
switch (_that) {
case _PlaceResponse():
return $default(_that.id,_that.name,_that.nameTr,_that.nameEn,_that.category,_that.latitude,_that.longitude,_that.address,_that.photoUrl,_that.avgRating,_that.reviewCount,_that.distance,_that.isFavorited);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String? nameTr,  String? nameEn,  String? category,  double? latitude,  double? longitude,  String? address,  String? photoUrl,  double? avgRating,  int? reviewCount,  double? distance,  bool? isFavorited)?  $default,) {final _that = this;
switch (_that) {
case _PlaceResponse() when $default != null:
return $default(_that.id,_that.name,_that.nameTr,_that.nameEn,_that.category,_that.latitude,_that.longitude,_that.address,_that.photoUrl,_that.avgRating,_that.reviewCount,_that.distance,_that.isFavorited);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceResponse implements PlaceResponse {
  const _PlaceResponse({required this.id, this.name, this.nameTr, this.nameEn, this.category, this.latitude, this.longitude, this.address, this.photoUrl, this.avgRating, this.reviewCount, this.distance, this.isFavorited});
  factory _PlaceResponse.fromJson(Map<String, dynamic> json) => _$PlaceResponseFromJson(json);

@override final  String id;
@override final  String? name;
@override final  String? nameTr;
@override final  String? nameEn;
@override final  String? category;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? address;
@override final  String? photoUrl;
@override final  double? avgRating;
@override final  int? reviewCount;
@override final  double? distance;
@override final  bool? isFavorited;

/// Create a copy of PlaceResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceResponseCopyWith<_PlaceResponse> get copyWith => __$PlaceResponseCopyWithImpl<_PlaceResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameTr, nameTr) || other.nameTr == nameTr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.category, category) || other.category == category)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,nameTr,nameEn,category,latitude,longitude,address,photoUrl,avgRating,reviewCount,distance,isFavorited);

@override
String toString() {
  return 'PlaceResponse(id: $id, name: $name, nameTr: $nameTr, nameEn: $nameEn, category: $category, latitude: $latitude, longitude: $longitude, address: $address, photoUrl: $photoUrl, avgRating: $avgRating, reviewCount: $reviewCount, distance: $distance, isFavorited: $isFavorited)';
}


}

/// @nodoc
abstract mixin class _$PlaceResponseCopyWith<$Res> implements $PlaceResponseCopyWith<$Res> {
  factory _$PlaceResponseCopyWith(_PlaceResponse value, $Res Function(_PlaceResponse) _then) = __$PlaceResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String? nameTr, String? nameEn, String? category, double? latitude, double? longitude, String? address, String? photoUrl, double? avgRating, int? reviewCount, double? distance, bool? isFavorited
});




}
/// @nodoc
class __$PlaceResponseCopyWithImpl<$Res>
    implements _$PlaceResponseCopyWith<$Res> {
  __$PlaceResponseCopyWithImpl(this._self, this._then);

  final _PlaceResponse _self;
  final $Res Function(_PlaceResponse) _then;

/// Create a copy of PlaceResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? nameTr = freezed,Object? nameEn = freezed,Object? category = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? address = freezed,Object? photoUrl = freezed,Object? avgRating = freezed,Object? reviewCount = freezed,Object? distance = freezed,Object? isFavorited = freezed,}) {
  return _then(_PlaceResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameTr: freezed == nameTr ? _self.nameTr : nameTr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,avgRating: freezed == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,isFavorited: freezed == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
