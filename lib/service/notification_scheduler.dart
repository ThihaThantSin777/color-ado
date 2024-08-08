import 'package:color_ado/main.dart';
import 'package:color_ado/pages/users/cu_events_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScheduler {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const String kChannelID = "NotificationID";
  static const String kChannelName = "NotificationName";
  static const String kChannelDescription = "ChannelDescription";

  static final NotificationScheduler _scheduler = NotificationScheduler.internal();

  NotificationScheduler.internal() {
    init();
  }

  factory NotificationScheduler() => _scheduler;

  void init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSetting = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosInitializationSetting,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) async {
        final payload = notificationResponse.payload ?? '';
        if (payload.isNotEmpty) {
          final dataSplit = payload.split("|");
          MyApp.navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => CUEventsDetailsPage(description: dataSplit.lastOrNull ?? '', title: dataSplit.firstOrNull ?? ''),
            ),
          );
        }
      },
    );
  }

  Future displayNotification(String title, String body, String payload, String? imgUrl) async {
    const iosNotificationDetail = DarwinNotificationDetails();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      kChannelID,
      kChannelName,
      channelDescription: kChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: (imgUrl != null && (imgUrl.isNotEmpty) ? null : const BigTextStyleInformation('')),
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iosNotificationDetail);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
