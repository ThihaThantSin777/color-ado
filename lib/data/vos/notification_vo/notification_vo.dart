import 'package:json_annotation/json_annotation.dart';

part 'notification_vo.g.dart';

@JsonSerializable()
class NotificationVO {
  int notificationID;
  String notificationType;
  String notificationTitle;
  List<int> sendNotificationUserList;
  List<int>? readNotificationUserList;
  String createdAt;
  String payload;

  NotificationVO(this.notificationID, this.notificationType, this.notificationTitle, this.sendNotificationUserList,
      this.readNotificationUserList, this.createdAt, this.payload);

  factory NotificationVO.fromJson(Map<String, dynamic> json) => _$NotificationVOFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationVOToJson(this);

  bool isCurrentUserReadNotification(int userID) {
    return readNotificationUserList?.contains(userID) ?? false;
  }
}
