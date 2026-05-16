// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceDetailResponse _$PlaceDetailResponseFromJson(Map<String, dynamic> json) =>
    _PlaceDetailResponse(
      id: json['id'] as String,
      name: json['name'] as String?,
      nameTr: json['nameTr'] as String?,
      nameEn: json['nameEn'] as String?,
      category: json['category'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      description: json['description'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      openingHours: json['openingHours'] as String?,
      photoUrl: json['photoUrl'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => PlaceImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      avgRating: (json['avgRating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      isFavorited: json['isFavorited'] as bool?,
      popularityScore: (json['popularityScore'] as num?)?.toInt(),
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ratingDistribution: (json['ratingDistribution'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(int.parse(k), (e as num).toInt())),
    );

Map<String, dynamic> _$PlaceDetailResponseToJson(
  _PlaceDetailResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'nameTr': instance.nameTr,
  'nameEn': instance.nameEn,
  'category': instance.category,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'description': instance.description,
  'address': instance.address,
  'phone': instance.phone,
  'website': instance.website,
  'openingHours': instance.openingHours,
  'photoUrl': instance.photoUrl,
  'images': instance.images,
  'avgRating': instance.avgRating,
  'reviewCount': instance.reviewCount,
  'isFavorited': instance.isFavorited,
  'popularityScore': instance.popularityScore,
  'keywords': instance.keywords,
  'ratingDistribution': instance.ratingDistribution?.map(
    (k, e) => MapEntry(k.toString(), e),
  ),
};
