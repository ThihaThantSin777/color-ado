import 'package:json_annotation/json_annotation.dart';

part 'setting_vo.g.dart';

@JsonSerializable()
class SettingVO {
  final int id;
  final String title;
  final String description;

  SettingVO(this.id, this.title, this.description);

  factory SettingVO.fromJson(Map<String, dynamic> json) => _$SettingVOFromJson(json);

  Map<String, dynamic> toJson() => _$SettingVOToJson(this);
}
