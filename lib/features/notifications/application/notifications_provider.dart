import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/notifications/data/dto/notification_response.dart';
import 'package:mobile/features/notifications/data/notifications_repository.dart';

class NotificationsNotifier extends AutoDisposeAsyncNotifier<List<NotificationResponse>> {
  late final NotificationsRepository _repository;

  @override
  FutureOr<List<NotificationResponse>> build() {
    _repository = ref.watch(notificationsRepositoryProvider);
    return _loadNotifications();
  }

  Future<List<NotificationResponse>> _loadNotifications() async {
    return _repository.getNotifications();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadNotifications);
  }

  Future<void> markAsRead(String id) async {
    await _repository.markAsRead(id);
    await refresh();
  }

  Future<void> markAllAsRead() async {
    await _repository.markAllAsRead();
    await refresh();
  }
}

final notificationsProvider =
    AsyncNotifierProvider.autoDispose<NotificationsNotifier, List<NotificationResponse>>(
      NotificationsNotifier.new,
    );
