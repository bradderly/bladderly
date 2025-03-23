import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notifly_flutter/notifly_flutter.dart';

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.title,
    required this.body,
    required this.customData,
  });

  factory NotificationModel.fromRemoteMessage(RemoteMessage remoteMessage) {
    return NotificationModel(
      title: remoteMessage.notification?.title ?? '',
      body: remoteMessage.notification?.body ?? '',
      customData: remoteMessage.data,
    );
  }

  factory NotificationModel.fromOSNotification(OSNotification notification) {
    return NotificationModel(
      title: notification.title ?? '',
      body: notification.body ?? '',
      customData: notification.customData,
    );
  }

  final String title;
  final String body;
  final Map<String, dynamic>? customData;

  @override
  List<Object?> get props => [
        title,
        body,
        customData,
      ];
}
