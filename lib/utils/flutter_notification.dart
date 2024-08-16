import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HelperNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static ValueNotifier<String> payload = ValueNotifier('');

  void setPayload(String newPayload) {
    payload.value = newPayload;
  }

  static AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(
    "Local Notif",
    "Sanber Local Notif",
    channelDescription: "coba",
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
    playSound: true,
    enableVibration: true,
    importance: Importance.max,
  );
  static DarwinNotificationDetails iosNotificationDetails =
      const DarwinNotificationDetails(
    threadIdentifier: 'Local Notif',
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );
  static NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails, iOS: iosNotificationDetails);

  Future<void> initLocalNotification() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIos = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIos,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint(details.payload);
        setPayload(details.payload ?? '');
      },
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
