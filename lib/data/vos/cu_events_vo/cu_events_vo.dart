import 'package:json_annotation/json_annotation.dart';

part 'cu_events_vo.g.dart';

@JsonSerializable()
class CUEventsVO {
  int id;
  String title;
  String description;
  @JsonKey(name: 'create_at')
  String createdAt;

  CUEventsVO(
    this.id,
    this.title,
    this.description,
    this.createdAt,
  );

  factory CUEventsVO.fromJson(Map<String, dynamic> json) => _$CUEventsVOFromJson(json);

  Map<String, dynamic> toJson() => _$CUEventsVOToJson(this);
}
