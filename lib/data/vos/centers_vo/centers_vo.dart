import 'package:json_annotation/json_annotation.dart';

part 'centers_vo.g.dart';

@JsonSerializable()
class CentersVO {
  final int id;
  final String title;
  final String description;
  final String url;
  final String? pdfName;
  final String? pdfURL;

  CentersVO({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    this.pdfURL,
    this.pdfName,
  });

  factory CentersVO.fromJson(Map<String, dynamic> json) => _$CentersVOFromJson(json);
  Map<String, dynamic> toJson() => _$CentersVOToJson(this);
}
