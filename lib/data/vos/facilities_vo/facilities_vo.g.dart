// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facilities_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilitiesVO _$FacilitiesVOFromJson(Map<String, dynamic> json) => FacilitiesVO(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      pdfName: json['pdfName'] as String?,
      pdfURL: json['pdfURL'] as String?,
    );

Map<String, dynamic> _$FacilitiesVOToJson(FacilitiesVO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'pdfName': instance.pdfName,
      'pdfURL': instance.pdfURL,
    };
