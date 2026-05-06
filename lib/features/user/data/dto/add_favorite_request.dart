import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_favorite_request.freezed.dart';
part 'add_favorite_request.g.dart';

@freezed
abstract class AddFavoriteRequest with _$AddFavoriteRequest {
  const factory AddFavoriteRequest({required String placeId}) =
      _AddFavoriteRequest;

  factory AddFavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFavoriteRequestFromJson(json);
}
