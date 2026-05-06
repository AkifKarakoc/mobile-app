// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_analysis_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageAnalysisResponse {

 String? get placeId; String get placeName; double get confidence; String get description; String get imageUrl;
/// Create a copy of ImageAnalysisResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageAnalysisResponseCopyWith<ImageAnalysisResponse> get copyWith => _$ImageAnalysisResponseCopyWithImpl<ImageAnalysisResponse>(this as ImageAnalysisResponse, _$identity);

  /// Serializes this ImageAnalysisResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageAnalysisResponse&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,placeName,confidence,description,imageUrl);

@override
String toString() {
  return 'ImageAnalysisResponse(placeId: $placeId, placeName: $placeName, confidence: $confidence, description: $description, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $ImageAnalysisResponseCopyWith<$Res>  {
  factory $ImageAnalysisResponseCopyWith(ImageAnalysisResponse value, $Res Function(ImageAnalysisResponse) _then) = _$ImageAnalysisResponseCopyWithImpl;
@useResult
$Res call({
 String? placeId, String placeName, double confidence, String description, String imageUrl
});




}
/// @nodoc
class _$ImageAnalysisResponseCopyWithImpl<$Res>
    implements $ImageAnalysisResponseCopyWith<$Res> {
  _$ImageAnalysisResponseCopyWithImpl(this._self, this._then);

  final ImageAnalysisResponse _self;
  final $Res Function(ImageAnalysisResponse) _then;

/// Create a copy of ImageAnalysisResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = freezed,Object? placeName = null,Object? confidence = null,Object? description = null,Object? imageUrl = null,}) {
  return _then(_self.copyWith(
placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,placeName: null == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageAnalysisResponse].
extension ImageAnalysisResponsePatterns on ImageAnalysisResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageAnalysisResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageAnalysisResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageAnalysisResponse value)  $default,){
final _that = this;
switch (_that) {
case _ImageAnalysisResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageAnalysisResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ImageAnalysisResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? placeId,  String placeName,  double confidence,  String description,  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageAnalysisResponse() when $default != null:
return $default(_that.placeId,_that.placeName,_that.confidence,_that.description,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? placeId,  String placeName,  double confidence,  String description,  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ImageAnalysisResponse():
return $default(_that.placeId,_that.placeName,_that.confidence,_that.description,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? placeId,  String placeName,  double confidence,  String description,  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ImageAnalysisResponse() when $default != null:
return $default(_that.placeId,_that.placeName,_that.confidence,_that.description,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageAnalysisResponse implements ImageAnalysisResponse {
  const _ImageAnalysisResponse({this.placeId, required this.placeName, required this.confidence, required this.description, required this.imageUrl});
  factory _ImageAnalysisResponse.fromJson(Map<String, dynamic> json) => _$ImageAnalysisResponseFromJson(json);

@override final  String? placeId;
@override final  String placeName;
@override final  double confidence;
@override final  String description;
@override final  String imageUrl;

/// Create a copy of ImageAnalysisResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageAnalysisResponseCopyWith<_ImageAnalysisResponse> get copyWith => __$ImageAnalysisResponseCopyWithImpl<_ImageAnalysisResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageAnalysisResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageAnalysisResponse&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,placeName,confidence,description,imageUrl);

@override
String toString() {
  return 'ImageAnalysisResponse(placeId: $placeId, placeName: $placeName, confidence: $confidence, description: $description, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ImageAnalysisResponseCopyWith<$Res> implements $ImageAnalysisResponseCopyWith<$Res> {
  factory _$ImageAnalysisResponseCopyWith(_ImageAnalysisResponse value, $Res Function(_ImageAnalysisResponse) _then) = __$ImageAnalysisResponseCopyWithImpl;
@override @useResult
$Res call({
 String? placeId, String placeName, double confidence, String description, String imageUrl
});




}
/// @nodoc
class __$ImageAnalysisResponseCopyWithImpl<$Res>
    implements _$ImageAnalysisResponseCopyWith<$Res> {
  __$ImageAnalysisResponseCopyWithImpl(this._self, this._then);

  final _ImageAnalysisResponse _self;
  final $Res Function(_ImageAnalysisResponse) _then;

/// Create a copy of ImageAnalysisResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = freezed,Object? placeName = null,Object? confidence = null,Object? description = null,Object? imageUrl = null,}) {
  return _then(_ImageAnalysisResponse(
placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,placeName: null == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
