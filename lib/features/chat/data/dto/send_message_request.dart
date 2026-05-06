class SendMessageRequest {
  final String content;

  SendMessageRequest({required this.content});

  Map<String, dynamic> toJson() => {'content': content};
}
