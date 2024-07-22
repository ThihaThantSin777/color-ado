// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cu_events_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CUEventsVO _$CUEventsVOFromJson(Map<String, dynamic> json) => CUEventsVO(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['description'] as String,
      json['create_at'] as String,
    );

Map<String, dynamic> _$CUEventsVOToJson(CUEventsVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'create_at': instance.createdAt,
    };
