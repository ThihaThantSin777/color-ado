import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  int id;
  String fcmToken;
  int cuEventNotificationCount;
  int newsNotificationCount;
  String timeStamp;

  UserVO(this.id, this.fcmToken, this.cuEventNotificationCount, this.newsNotificationCount, this.timeStamp);

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);

  @override
  String toString() {
    return 'UserVO{id: $id, cuEventNotificationCount: $cuEventNotificationCount, newsNotificationCount: $newsNotificationCount, timeStamp: $timeStamp}';
  }
}
