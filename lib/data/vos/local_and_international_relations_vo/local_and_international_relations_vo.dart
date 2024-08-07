import 'package:json_annotation/json_annotation.dart';

part 'local_and_international_relations_vo.g.dart';

@JsonSerializable()
class LocalAndInternationalRelationsVO {
  final int id;
  final String title;
  final String description;
  final String url;
  final String pdfName;
  final String pdfURL;

  LocalAndInternationalRelationsVO({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.pdfName,
    required this.pdfURL,
  });

  factory LocalAndInternationalRelationsVO.fromJson(Map<String, dynamic> json) => _$LocalAndInternationalRelationsVOFromJson(json);
  Map<String, dynamic> toJson() => _$LocalAndInternationalRelationsVOToJson(this);
}
