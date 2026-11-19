class SendMessageRequest {
  final String content;
  final double? latitude;
  final double? longitude;

  SendMessageRequest({
    required this.content,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => {
        'content': content,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
      };
}
