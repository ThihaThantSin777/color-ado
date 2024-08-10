import 'package:json_annotation/json_annotation.dart';

part 'admin_vo.g.dart';

@JsonSerializable()
class AdminVO {
  int id;
  @JsonKey(name: 'user_name')
  String userName;
  String email;

  AdminVO(
    this.id,
    this.userName,
    this.email,
  );

  factory AdminVO.fromJson(Map<String, dynamic> json) => _$AdminVOFromJson(json);

  Map<String, dynamic> toJson() => _$AdminVOToJson(this);
}
