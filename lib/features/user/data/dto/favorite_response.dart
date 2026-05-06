import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_response.freezed.dart';
part 'favorite_response.g.dart';

@freezed
abstract class FavoriteResponse with _$FavoriteResponse {
  const factory FavoriteResponse({
    required String id,
    required String placeId,
    required DateTime savedAt,
  }) = _FavoriteResponse;

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteResponseFromJson(json);
}
