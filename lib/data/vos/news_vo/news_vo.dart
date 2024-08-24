import 'package:json_annotation/json_annotation.dart';

part 'news_vo.g.dart';

@JsonSerializable()
class NewsVO {
  int id;
  String title;
  String description;
  @JsonKey(name: 'create_at')
  String createdAt;
  String? image;

  NewsVO(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.image,
  );

  factory NewsVO.fromJson(Map<String, dynamic> json) => _$NewsVOFromJson(json);

  Map<String, dynamic> toJson() => _$NewsVOToJson(this);
}
