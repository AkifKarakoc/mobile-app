import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_response.freezed.dart';
part 'notification_response.g.dart';

@freezed
abstract class NotificationResponse with _$NotificationResponse {
  const factory NotificationResponse({
    required String id,
    required String type,
    required String title,
    required String body,
    @Default(false) bool isRead,
    required String createdAt,
  }) = _NotificationResponse;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}
