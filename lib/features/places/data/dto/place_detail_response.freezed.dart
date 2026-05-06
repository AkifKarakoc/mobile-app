// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceDetailResponse {

 String get id; String? get name; String? get nameTr; String? get nameEn; String? get category; double? get latitude; double? get longitude; String? get description; String? get address; String? get phone; String? get website; String? get openingHours; String? get photoUrl; double? get avgRating; int? get reviewCount; bool? get isFavorited; int? get popularityScore; List<String>? get keywords;
/// Create a copy of PlaceDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceDetailResponseCopyWith<PlaceDetailResponse> get copyWith => _$PlaceDetailResponseCopyWithImpl<PlaceDetailResponse>(this as PlaceDetailResponse, _$identity);

  /// Serializes this PlaceDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceDetailResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameTr, nameTr) || other.nameTr == nameTr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.category, category) || other.category == category)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.website, website) || other.website == website)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.popularityScore, popularityScore) || other.popularityScore == popularityScore)&&const DeepCollectionEquality().equals(other.keywords, keywords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,nameTr,nameEn,category,latitude,longitude,description,address,phone,website,openingHours,photoUrl,avgRating,reviewCount,isFavorited,popularityScore,const DeepCollectionEquality().hash(keywords));

@override
String toString() {
  return 'PlaceDetailResponse(id: $id, name: $name, nameTr: $nameTr, nameEn: $nameEn, category: $category, latitude: $latitude, longitude: $longitude, description: $description, address: $address, phone: $phone, website: $website, openingHours: $openingHours, photoUrl: $photoUrl, avgRating: $avgRating, reviewCount: $reviewCount, isFavorited: $isFavorited, popularityScore: $popularityScore, keywords: $keywords)';
}


}

/// @nodoc
abstract mixin class $PlaceDetailResponseCopyWith<$Res>  {
  factory $PlaceDetailResponseCopyWith(PlaceDetailResponse value, $Res Function(PlaceDetailResponse) _then) = _$PlaceDetailResponseCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String? nameTr, String? nameEn, String? category, double? latitude, double? longitude, String? description, String? address, String? phone, String? website, String? openingHours, String? photoUrl, double? avgRating, int? reviewCount, bool? isFavorited, int? popularityScore, List<String>? keywords
});




}
/// @nodoc
class _$PlaceDetailResponseCopyWithImpl<$Res>
    implements $PlaceDetailResponseCopyWith<$Res> {
  _$PlaceDetailResponseCopyWithImpl(this._self, this._then);

  final PlaceDetailResponse _self;
  final $Res Function(PlaceDetailResponse) _then;

/// Create a copy of PlaceDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? nameTr = freezed,Object? nameEn = freezed,Object? category = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? description = freezed,Object? address = freezed,Object? phone = freezed,Object? website = freezed,Object? openingHours = freezed,Object? photoUrl = freezed,Object? avgRating = freezed,Object? reviewCount = freezed,Object? isFavorited = freezed,Object? popularityScore = freezed,Object? keywords = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameTr: freezed == nameTr ? _self.nameTr : nameTr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,avgRating: freezed == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,isFavorited: freezed == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool?,popularityScore: freezed == popularityScore ? _self.popularityScore : popularityScore // ignore: cast_nullable_to_non_nullable
as int?,keywords: freezed == keywords ? _self.keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceDetailResponse].
extension PlaceDetailResponsePatterns on PlaceDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _PlaceDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String? nameTr,  String? nameEn,  String? category,  double? latitude,  double? longitude,  String? description,  String? address,  String? phone,  String? website,  String? openingHours,  String? photoUrl,  double? avgRating,  int? reviewCount,  bool? isFavorited,  int? popularityScore,  List<String>? keywords)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceDetailResponse() when $default != null:
return $default(_that.id,_that.name,_that.nameTr,_that.nameEn,_that.category,_that.latitude,_that.longitude,_that.description,_that.address,_that.phone,_that.website,_that.openingHours,_that.photoUrl,_that.avgRating,_that.reviewCount,_that.isFavorited,_that.popularityScore,_that.keywords);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String? nameTr,  String? nameEn,  String? category,  double? latitude,  double? longitude,  String? description,  String? address,  String? phone,  String? website,  String? openingHours,  String? photoUrl,  double? avgRating,  int? reviewCount,  bool? isFavorited,  int? popularityScore,  List<String>? keywords)  $default,) {final _that = this;
switch (_that) {
case _PlaceDetailResponse():
return $default(_that.id,_that.name,_that.nameTr,_that.nameEn,_that.category,_that.latitude,_that.longitude,_that.description,_that.address,_that.phone,_that.website,_that.openingHours,_that.photoUrl,_that.avgRating,_that.reviewCount,_that.isFavorited,_that.popularityScore,_that.keywords);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String? nameTr,  String? nameEn,  String? category,  double? latitude,  double? longitude,  String? description,  String? address,  String? phone,  String? website,  String? openingHours,  String? photoUrl,  double? avgRating,  int? reviewCount,  bool? isFavorited,  int? popularityScore,  List<String>? keywords)?  $default,) {final _that = this;
switch (_that) {
case _PlaceDetailResponse() when $default != null:
return $default(_that.id,_that.name,_that.nameTr,_that.nameEn,_that.category,_that.latitude,_that.longitude,_that.description,_that.address,_that.phone,_that.website,_that.openingHours,_that.photoUrl,_that.avgRating,_that.reviewCount,_that.isFavorited,_that.popularityScore,_that.keywords);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceDetailResponse implements PlaceDetailResponse {
  const _PlaceDetailResponse({required this.id, this.name, this.nameTr, this.nameEn, this.category, this.latitude, this.longitude, this.description, this.address, this.phone, this.website, this.openingHours, this.photoUrl, this.avgRating, this.reviewCount, this.isFavorited, this.popularityScore, final  List<String>? keywords}): _keywords = keywords;
  factory _PlaceDetailResponse.fromJson(Map<String, dynamic> json) => _$PlaceDetailResponseFromJson(json);

@override final  String id;
@override final  String? name;
@override final  String? nameTr;
@override final  String? nameEn;
@override final  String? category;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? description;
@override final  String? address;
@override final  String? phone;
@override final  String? website;
@override final  String? openingHours;
@override final  String? photoUrl;
@override final  double? avgRating;
@override final  int? reviewCount;
@override final  bool? isFavorited;
@override final  int? popularityScore;
 final  List<String>? _keywords;
@override List<String>? get keywords {
  final value = _keywords;
  if (value == null) return null;
  if (_keywords is EqualUnmodifiableListView) return _keywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PlaceDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceDetailResponseCopyWith<_PlaceDetailResponse> get copyWith => __$PlaceDetailResponseCopyWithImpl<_PlaceDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceDetailResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameTr, nameTr) || other.nameTr == nameTr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.category, category) || other.category == category)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.website, website) || other.website == website)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.popularityScore, popularityScore) || other.popularityScore == popularityScore)&&const DeepCollectionEquality().equals(other._keywords, _keywords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,nameTr,nameEn,category,latitude,longitude,description,address,phone,website,openingHours,photoUrl,avgRating,reviewCount,isFavorited,popularityScore,const DeepCollectionEquality().hash(_keywords));

@override
String toString() {
  return 'PlaceDetailResponse(id: $id, name: $name, nameTr: $nameTr, nameEn: $nameEn, category: $category, latitude: $latitude, longitude: $longitude, description: $description, address: $address, phone: $phone, website: $website, openingHours: $openingHours, photoUrl: $photoUrl, avgRating: $avgRating, reviewCount: $reviewCount, isFavorited: $isFavorited, popularityScore: $popularityScore, keywords: $keywords)';
}


}

/// @nodoc
abstract mixin class _$PlaceDetailResponseCopyWith<$Res> implements $PlaceDetailResponseCopyWith<$Res> {
  factory _$PlaceDetailResponseCopyWith(_PlaceDetailResponse value, $Res Function(_PlaceDetailResponse) _then) = __$PlaceDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String? nameTr, String? nameEn, String? category, double? latitude, double? longitude, String? description, String? address, String? phone, String? website, String? openingHours, String? photoUrl, double? avgRating, int? reviewCount, bool? isFavorited, int? popularityScore, List<String>? keywords
});




}
/// @nodoc
class __$PlaceDetailResponseCopyWithImpl<$Res>
    implements _$PlaceDetailResponseCopyWith<$Res> {
  __$PlaceDetailResponseCopyWithImpl(this._self, this._then);

  final _PlaceDetailResponse _self;
  final $Res Function(_PlaceDetailResponse) _then;

/// Create a copy of PlaceDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? nameTr = freezed,Object? nameEn = freezed,Object? category = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? description = freezed,Object? address = freezed,Object? phone = freezed,Object? website = freezed,Object? openingHours = freezed,Object? photoUrl = freezed,Object? avgRating = freezed,Object? reviewCount = freezed,Object? isFavorited = freezed,Object? popularityScore = freezed,Object? keywords = freezed,}) {
  return _then(_PlaceDetailResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameTr: freezed == nameTr ? _self.nameTr : nameTr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,avgRating: freezed == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,isFavorited: freezed == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool?,popularityScore: freezed == popularityScore ? _self.popularityScore : popularityScore // ignore: cast_nullable_to_non_nullable
as int?,keywords: freezed == keywords ? _self._keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
