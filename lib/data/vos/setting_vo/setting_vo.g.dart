// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingVO _$SettingVOFromJson(Map<String, dynamic> json) => SettingVO(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$SettingVOToJson(SettingVO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
