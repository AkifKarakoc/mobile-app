class FavoriteResponse {
  const FavoriteResponse({
    required this.id,
    required this.placeId,
    required this.savedAt,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      id: json['id'] as String,
      placeId: json['placeId'] as String,
      savedAt: DateTime.parse(json['savedAt'] as String),
    );
  }

  final String id;
  final String placeId;
  final DateTime savedAt;

  Map<String, dynamic> toJson() {
    return {'id': id, 'placeId': placeId, 'savedAt': savedAt.toIso8601String()};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is FavoriteResponse &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            placeId == other.placeId &&
            savedAt == other.savedAt;
  }

  @override
  int get hashCode => Object.hash(id, placeId, savedAt);
}
