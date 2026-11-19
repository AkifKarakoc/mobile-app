import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/notifications/data/dto/device_token_request.dart';
import 'package:mobile/features/notifications/data/notifications_repository.dart';

final fcmManagerProvider = Provider<FCMManager>((ref) {
  return FCMManager(ref);
});

class FCMManager {
  FCMManager(this._ref);

  final Ref _ref;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  FirebaseMessaging get _messaging => FirebaseMessaging.instance;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    if (Firebase.apps.isEmpty) {
      debugPrint('Firebase is not initialized; skipping FCM setup');
      return;
    }

    try {
      await _initLocalNotifications();
      await _requestPermission();
      await _setupForegroundHandler();
      await _registerToken();
    } catch (e) {
      debugPrint('FCM setup failed: $e');
    }
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _localNotifications.initialize(initSettings);
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint('FCM permission status: ${settings.authorizationStatus}');
  }

  Future<void> _setupForegroundHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('FCM foreground message: ${message.notification?.title}');
      _showLocalNotification(message);
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const androidDetails = AndroidNotificationDetails(
      'tourguide_notifications',
      'TourGuide Bildirimleri',
      channelDescription: 'Turizm rehberi bildirimleri',
      importance: Importance.high,
      priority: Priority.high,
    );

    const darwinDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
      payload: message.data['route'] as String?,
    );
  }

  Future<void> _registerToken() async {
    try {
      String? token;
      if (kIsWeb) {
        token = await _messaging.getToken(vapidKey: null);
      } else {
        token = await _messaging.getToken();
      }

      if (token != null) {
        debugPrint('FCM token: $token');
        final platform = Platform.isIOS ? 'ios' : 'android';
        final request = DeviceTokenRequest(token: token, platform: platform);
        await _ref.read(notificationsRepositoryProvider).registerDeviceToken(request);
      }
    } catch (e) {
      debugPrint('FCM token registration failed: $e');
    }

    _messaging.onTokenRefresh.listen((newToken) async {
      debugPrint('FCM token refreshed: $newToken');
      final platform = Platform.isIOS ? 'ios' : 'android';
      final request = DeviceTokenRequest(token: newToken, platform: platform);
      await _ref.read(notificationsRepositoryProvider).registerDeviceToken(request);
    });
  }

  Future<void> deleteToken() async {
    if (Firebase.apps.isEmpty) return;

    try {
      await _messaging.deleteToken();
    } catch (e) {
      debugPrint('FCM delete token failed: $e');
    }
  }
}
