// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceImage {

 String get id; String get imageUrl; String get createdAt;
/// Create a copy of PlaceImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceImageCopyWith<PlaceImage> get copyWith => _$PlaceImageCopyWithImpl<PlaceImage>(this as PlaceImage, _$identity);

  /// Serializes this PlaceImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceImage&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,createdAt);

@override
String toString() {
  return 'PlaceImage(id: $id, imageUrl: $imageUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PlaceImageCopyWith<$Res>  {
  factory $PlaceImageCopyWith(PlaceImage value, $Res Function(PlaceImage) _then) = _$PlaceImageCopyWithImpl;
@useResult
$Res call({
 String id, String imageUrl, String createdAt
});




}
/// @nodoc
class _$PlaceImageCopyWithImpl<$Res>
    implements $PlaceImageCopyWith<$Res> {
  _$PlaceImageCopyWithImpl(this._self, this._then);

  final PlaceImage _self;
  final $Res Function(PlaceImage) _then;

/// Create a copy of PlaceImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageUrl = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceImage].
extension PlaceImagePatterns on PlaceImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceImage value)  $default,){
final _that = this;
switch (_that) {
case _PlaceImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceImage value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceImage() when $default != null:
return $default(_that.id,_that.imageUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _PlaceImage():
return $default(_that.id,_that.imageUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imageUrl,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PlaceImage() when $default != null:
return $default(_that.id,_that.imageUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceImage implements PlaceImage {
  const _PlaceImage({required this.id, required this.imageUrl, required this.createdAt});
  factory _PlaceImage.fromJson(Map<String, dynamic> json) => _$PlaceImageFromJson(json);

@override final  String id;
@override final  String imageUrl;
@override final  String createdAt;

/// Create a copy of PlaceImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceImageCopyWith<_PlaceImage> get copyWith => __$PlaceImageCopyWithImpl<_PlaceImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceImage&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,createdAt);

@override
String toString() {
  return 'PlaceImage(id: $id, imageUrl: $imageUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PlaceImageCopyWith<$Res> implements $PlaceImageCopyWith<$Res> {
  factory _$PlaceImageCopyWith(_PlaceImage value, $Res Function(_PlaceImage) _then) = __$PlaceImageCopyWithImpl;
@override @useResult
$Res call({
 String id, String imageUrl, String createdAt
});




}
/// @nodoc
class __$PlaceImageCopyWithImpl<$Res>
    implements _$PlaceImageCopyWith<$Res> {
  __$PlaceImageCopyWithImpl(this._self, this._then);

  final _PlaceImage _self;
  final $Res Function(_PlaceImage) _then;

/// Create a copy of PlaceImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,Object? createdAt = null,}) {
  return _then(_PlaceImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
