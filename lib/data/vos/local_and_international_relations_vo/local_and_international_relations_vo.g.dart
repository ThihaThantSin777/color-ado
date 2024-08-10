// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_and_international_relations_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalAndInternationalRelationsVO _$LocalAndInternationalRelationsVOFromJson(
        Map<String, dynamic> json) =>
    LocalAndInternationalRelationsVO(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      pdfName: json['pdfName'] as String?,
      pdfURL: json['pdfURL'] as String?,
    );

Map<String, dynamic> _$LocalAndInternationalRelationsVOToJson(
        LocalAndInternationalRelationsVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'pdfName': instance.pdfName,
      'pdfURL': instance.pdfURL,
    };
