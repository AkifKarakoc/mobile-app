import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/features/places/data/dto/place_image.dart';

part 'place_detail_response.freezed.dart';
part 'place_detail_response.g.dart';

@freezed
abstract class PlaceDetailResponse with _$PlaceDetailResponse {
  const factory PlaceDetailResponse({
    required String id,
    String? name,
    String? nameTr,
    String? nameEn,
    String? category,
    double? latitude,
    double? longitude,
    String? description,
    String? address,
    String? phone,
    String? website,
    String? openingHours,
    String? photoUrl,
    List<PlaceImage>? images,
    double? avgRating,
    int? reviewCount,
    bool? isFavorited,
    int? popularityScore,
    List<String>? keywords,
    Map<int, int>? ratingDistribution,
  }) = _PlaceDetailResponse;

  factory PlaceDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailResponseFromJson(json);
}
