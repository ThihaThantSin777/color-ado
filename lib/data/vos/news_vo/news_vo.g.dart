// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsVO _$NewsVOFromJson(Map<String, dynamic> json) => NewsVO(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['description'] as String,
      json['create_at'] as String,
      json['image'] as String,
    );

Map<String, dynamic> _$NewsVOToJson(NewsVO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'create_at': instance.createdAt,
      'image': instance.image,
    };
