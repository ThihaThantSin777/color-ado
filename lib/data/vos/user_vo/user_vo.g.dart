// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      (json['id'] as num).toInt(),
      json['fcmToken'] as String,
      (json['cuEventNotificationCount'] as num).toInt(),
      (json['newsNotificationCount'] as num).toInt(),
      json['timeStamp'] as String,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'fcmToken': instance.fcmToken,
      'cuEventNotificationCount': instance.cuEventNotificationCount,
      'newsNotificationCount': instance.newsNotificationCount,
      'timeStamp': instance.timeStamp,
    };
