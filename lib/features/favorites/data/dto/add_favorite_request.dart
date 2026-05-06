class AddFavoriteRequest {
  const AddFavoriteRequest({required this.placeId});

  final String placeId;

  Map<String, dynamic> toJson() => {'placeId': placeId};
}
