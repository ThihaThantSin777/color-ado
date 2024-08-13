// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationVO _$NotificationVOFromJson(Map<String, dynamic> json) =>
    NotificationVO(
      (json['notificationID'] as num).toInt(),
      json['notificationType'] as String,
      json['notificationTitle'] as String,
      (json['sendNotificationUserList'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['readNotificationUserList'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      json['createdAt'] as String,
      json['payload'] as String,
    );

Map<String, dynamic> _$NotificationVOToJson(NotificationVO instance) =>
    <String, dynamic>{
      'notificationID': instance.notificationID,
      'notificationType': instance.notificationType,
      'notificationTitle': instance.notificationTitle,
      'sendNotificationUserList': instance.sendNotificationUserList,
      'readNotificationUserList': instance.readNotificationUserList,
      'createdAt': instance.createdAt,
      'payload': instance.payload,
    };
