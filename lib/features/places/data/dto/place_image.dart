import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_image.freezed.dart';
part 'place_image.g.dart';

@freezed
abstract class PlaceImage with _$PlaceImage {
  const factory PlaceImage({
    required String id,
    required String imageUrl,
    required String createdAt,
  }) = _PlaceImage;

  factory PlaceImage.fromJson(Map<String, dynamic> json) =>
      _$PlaceImageFromJson(json);
}
