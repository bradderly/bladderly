import 'dart:async';

import 'package:bladderly/core/notification/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:notifly_flutter/notifly_flutter.dart';

@module
abstract class NotificationModule {
  @lazySingleton
  NotificationService get notificationService => const _NotificationService();
}

abstract class NotificationService {
  const NotificationService._();

  Future<void> initialize({
    required void Function(NotificationModel) onReceiveNotification,
    required void Function(NotificationModel) onTapNotification,
    required Future<void> Function(RemoteMessage) onReceiveBackgroundNotification,
  });

  Future<void> requestPermission();
}

class _NotificationService implements NotificationService {
  const _NotificationService();

  @override
  Future<void> initialize({
    required void Function(NotificationModel) onReceiveNotification,
    required void Function(NotificationModel) onTapNotification,
    required Future<void> Function(RemoteMessage) onReceiveBackgroundNotification,
  }) async {
    FirebaseMessaging.onMessage.listen(
      (message) => onReceiveNotification(NotificationModel.fromRemoteMessage(message)),
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) => onTapNotification(NotificationModel.fromRemoteMessage(message)),
    );

    FirebaseMessaging.onBackgroundMessage(onReceiveBackgroundNotification);

    return NotiflyPlugin.addNotificationClickListener(
      (notification) => onTapNotification(NotificationModel.fromOSNotification(notification.notification)),
    );
  }

  @override
  Future<void> requestPermission() {
    return FirebaseMessaging.instance.requestPermission();
  }
}
