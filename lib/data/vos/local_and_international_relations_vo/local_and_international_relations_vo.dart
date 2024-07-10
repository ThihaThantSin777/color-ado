import 'package:json_annotation/json_annotation.dart';

part 'local_and_international_relations_vo.g.dart';

@JsonSerializable()
class LocalAndInternationalRelationsVO {
  final int id;
  final String title;
  final String description;
  final String url;

  LocalAndInternationalRelationsVO({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
  });

  factory LocalAndInternationalRelationsVO.fromJson(Map<String, dynamic> json) => _$LocalAndInternationalRelationsVOFromJson(json);
  Map<String, dynamic> toJson() => _$LocalAndInternationalRelationsVOToJson(this);
}
