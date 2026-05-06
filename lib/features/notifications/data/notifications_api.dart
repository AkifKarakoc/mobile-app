import 'package:dio/dio.dart';
import 'package:mobile/features/notifications/data/dto/device_token_request.dart';
import 'package:mobile/features/notifications/data/dto/notification_response.dart';
import 'package:retrofit/retrofit.dart';

part 'notifications_api.g.dart';

@RestApi()
abstract class NotificationsApi {
  factory NotificationsApi(Dio dio, {String baseUrl}) = _NotificationsApi;

  @GET('/notifications')
  Future<List<NotificationResponse>> getNotifications({
    @Query('page') int page = 0,
    @Query('size') int size = 20,
  });

  @PATCH('/notifications/{id}/read')
  Future<void> markAsRead(@Path('id') String id);

  @PATCH('/notifications/read-all')
  Future<void> markAllAsRead();

  @POST('/notifications/device-token')
  Future<void> registerDeviceToken(@Body() DeviceTokenRequest request);
}
