import 'dart:async';

import 'package:color_ado/main.dart';
import 'package:color_ado/pages/users/cu_events_details_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

import 'notification_scheduler.dart';

class FcmService {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static String fcmToken = "";

  Future init() async {
    await firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);

    final tempToken = await firebaseMessaging.getToken();
    fcmToken = tempToken ?? '';

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    final String? payload = initialMessage?.data['payload'];
    if (payload != null) {
      final dataSplit = payload.split("|");
      MyApp.navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => CUEventsDetailsPage(description: dataSplit.lastOrNull ?? '', title: dataSplit.firstOrNull ?? ''),
        ),
      );
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await showNotification(message.data);
    });

    //Handle Background and Terminate
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await showNotification(message.data);
  }

  static Future<void> showNotification(Map<String, dynamic> data) async {
    NotificationScheduler().displayNotification(
      data['title'],
      data['description'],
      data['payload'],
      data['image'],
    );
  }

  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "color-ado-334c0",
      "private_key_id": "46f15bf464770ace436b35be9a9729da89126e35",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCpi8OVUupMAP9/\n8WkL8jSgMYnHgOVq1GWFNZyWUKPEhKcn4sQn7AE2J5fee5pLlSu0Bt51Zc6ucicK\nJZeKuFmIqLcYSTKShzifbxF7jj4JEKwbI/jHchZ8pAAkCDSWbFYaP7rAXQgFr033\nDuLppqVzYVoiPYFSIuaODNuB0l/5vDk+nlKgBwJo6BBDdkDvbYc2qU3gmIuXN0fE\nPo7ukmBcwHt6KKdFa19d+X3VA2my4acjrw0rAjL1PYUUXXG0Pmo0mWhT1oR8z84p\nqn4aWoCly3WkdJ2zDWWPnSygicUc+NzGRDa/6WgRy5XBy3xOlSFMQmeG09XOdPM0\nRsw5l0X5AgMBAAECggEADuadiAxTUt5hljKMNhm8M09h7w/uhHmUpI+mKqB9YYJR\nGJR5refe4WNlxGQeQZdOJyfVZFb6wmJ+TjTTQUSw0G3COGxdI/tQvX5q+G4eGKOH\npL5Vboih3k7MQ7PEP2uCaRMsdsdBCGg0VMrQ+ZJaXIN0Av9fKW4Ez6Y599/FQfL6\nosPj6WKOewjVNcK3zXMqYWWXRb6xamAVDVC5N3TayawrjHGQwQEPsMldqOO63AXX\nqRJlLeMbmPnrhhaTsaHsZChSCrTr7qYLSMevK8BAOmmlInr7hW9sfBR6g/X12KnC\n/EWl2NPBTIVrxA4CMv4NM3slLFOUL8HZpgP0ct1PgwKBgQDnejMt08rk43cPH6XM\n3ipm+BOLNnd7OTX+VtLyy/5plOCYDjvx7JdbykOj2RVYXjoItkJLw/fiAj13tnsX\nrLeqfww3XuZNmLIL4BM0TnHwpiyNzNXJUVlNpT4Pg22BenqU3aDVJVO9OSbL4/Tv\nUiZUCiKZUvlOeIwlbWIgGWc65wKBgQC7gfLjUSa0swlFphpMEtlO5v270d9hfhC4\nWoxdb7XbmdpWb0Z1L70pA7QkibHLri6EsJRxF2F7fMnhWawUDDXOAnwukBt/lhuN\n8C6v+unM7STzrI/nNyn5dm3X3rWtXZrh7TAe6+pxJp0s8c/In/Hmk3tIYpeIllyJ\nizwuIU88HwKBgClPdbLICX2v2p+oVj6pp4eY3mQJ5GjpXOl3NU5/eXf+SdbZM3mJ\nb7nB7zBenaCXsGO9ozdCUgrTu4SR3IXtHRogcl2vYgqXJa9Y3hSHq233OhxUYhL7\noaRpyRmbqv9gjF/k7b8cWkV63aGlnSDY2F5HMMWMOVH30YscalawMewhAoGAD/wl\nC7H4XcFBkhl19nRI6EwS53cd1v7bSAwYGUMTutPj5Ch6VjUqqBtzuQWwDZAc0R0I\nmpeGrPNXdomhfNgJojVeBs4sOfU/Bhuqrz/xvJGe69MTNX/jaSvqc1O+IzhuosII\nryong1vqXFGFCDJyediq0uHszy0aWHNxPvGCArsCgYEAsSMXE6PXUMpff9UFffcw\n4TI4loBRCuT+STMsqzw5I4mmVzYZFNSpZNcM6zHkQ4VNm5YYTzti/P0hv+Z6IiK3\nPmGVnn1+ATcFo548DSWtZG1LsFiLOq9UOO7cY/M3238bLh2Vf4KXBAhhb4b1p4yY\nTUwi8mNHEiTCSYkL6ia4ZBo=\n-----END PRIVATE KEY-----\n",
      "client_email": "color-ado-334c0@appspot.gserviceaccount.com",
      "client_id": "105751832970464087548",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/color-ado-334c0%40appspot.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes, client);

    client.close();

    return credentials.accessToken.data;
  }
}
