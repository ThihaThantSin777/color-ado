import 'package:json_annotation/json_annotation.dart';

part 'banner_vo.g.dart';

@JsonSerializable()
class BannerVO {
  final int id;
  final String url;

  BannerVO({
    required this.id,
    required this.url,
  });

  factory BannerVO.fromJson(Map<String, dynamic> json) => _$BannerVOFromJson(json);
  Map<String, dynamic> toJson() => _$BannerVOToJson(this);
}
