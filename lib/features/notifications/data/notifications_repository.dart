import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/notifications/data/dto/device_token_request.dart';
import 'package:mobile/features/notifications/data/dto/notification_response.dart';
import 'package:mobile/features/notifications/data/notifications_api.dart';

abstract class NotificationsRepository {
  Future<List<NotificationResponse>> getNotifications({int page, int size});

  Future<void> markAsRead(String id);

  Future<void> markAllAsRead();

  Future<void> registerDeviceToken(DeviceTokenRequest request);
}

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._api);

  final NotificationsApi _api;

  @override
  Future<List<NotificationResponse>> getNotifications({
    int page = 0,
    int size = 20,
  }) async {
    try {
      return await _api.getNotifications(page: page, size: size);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      await _api.markAsRead(id);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await _api.markAllAsRead();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<void> registerDeviceToken(DeviceTokenRequest request) async {
    try {
      await _api.registerDeviceToken(request);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}

final notificationsRepositoryProvider = Provider<NotificationsRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final api = NotificationsApi(dio);
  return NotificationsRepositoryImpl(api);
});
