import 'dart:convert';

import 'package:color_ado/service/fcm_service.dart';
import 'package:dio/dio.dart';

class NotificationAPI {
  static Future<void> sendFCMMessage(
    String title,
    String description,
    dynamic payload,
    List<String> tokens,
    Function callBackAfterNotification,
  ) async {
    final String serverKey = await FcmService.getAccessToken();
    const String fcmEndpoint = 'https://fcm.googleapis.com/v1/projects/color-ado-334c0/messages:send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    for (var token in tokens) {
      final Map<String, dynamic> message = {
        'message': {
          'token': token,
          'data': {
            "title": title,
            "description": description,
            "image": "https://cdn-icons-png.flaticon.com/512/3119/3119338.png",
            "payload": "$payload",
          },
        }
      };

      try {
        await Dio().post(
          fcmEndpoint,
          options: Options(headers: headers),
          data: jsonEncode(message),
        );
        callBackAfterNotification();
      } catch (error) {
        continue;
      }
    }

    return Future.value();
  }
}
