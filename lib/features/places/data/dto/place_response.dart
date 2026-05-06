import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_response.freezed.dart';
part 'place_response.g.dart';

@freezed
abstract class PlaceResponse with _$PlaceResponse {
  const factory PlaceResponse({
    required String id,
    String? name,
    String? nameTr,
    String? nameEn,
    String? category,
    double? latitude,
    double? longitude,
    String? address,
    String? photoUrl,
    double? avgRating,
    int? reviewCount,
    double? distance,
    bool? isFavorited,
  }) = _PlaceResponse;

  factory PlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceResponseFromJson(json);
}
