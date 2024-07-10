// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'centers_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CentersVO _$CentersVOFromJson(Map<String, dynamic> json) => CentersVO(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$CentersVOToJson(CentersVO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
    };
