import 'dart:io';

import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/main.dart';
import 'package:color_ado/pages/users/cu_events_details_page.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
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
          if (Platform.isIOS) {
            Future.wait([ColorAdoModel().getCUEventsNotificationCountByUserID(), ColorAdoModel().getNewsNotificationCountByUserID()])
                .then((countsList) {
              int cuEventsNotificationCountList = countsList.firstOrNull ?? 0;
              int newsEventsNotificationCountList = countsList.lastOrNull ?? 0;
              FlutterDynamicIcon.setApplicationIconBadgeNumber(cuEventsNotificationCountList + newsEventsNotificationCountList);
            });
          }

          String path = dataSplit.firstOrNull ?? "";
          if (path == kNewsPath) {
            int currentNotificationCount = await ColorAdoModel().getNewsNotificationCountByUserID();
            ColorAdoModel().setNewsNotificationCount(--currentNotificationCount);
          }

          if (path == kCUEventsPath) {
            int currentNotificationCount = await ColorAdoModel().getCUEventsNotificationCountByUserID();
            ColorAdoModel().setNewsNotificationCount(--currentNotificationCount);
          }

          MyApp.navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => CUEventsDetailsPage(
                title: dataSplit[1],
                description: dataSplit.lastOrNull ?? '',
              ),
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
