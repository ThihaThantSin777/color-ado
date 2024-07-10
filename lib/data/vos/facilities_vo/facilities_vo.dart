import 'package:json_annotation/json_annotation.dart';

part 'facilities_vo.g.dart';

@JsonSerializable()
class FacilitiesVO {
  final int id;
  final String title;
  final String description;
  final String url;

  FacilitiesVO({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
  });

  factory FacilitiesVO.fromJson(Map<String, dynamic> json) => _$FacilitiesVOFromJson(json);
  Map<String, dynamic> toJson() => _$FacilitiesVOToJson(this);
}
