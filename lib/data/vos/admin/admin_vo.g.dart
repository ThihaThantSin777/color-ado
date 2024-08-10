// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminVO _$AdminVOFromJson(Map<String, dynamic> json) => AdminVO(
      (json['id'] as num).toInt(),
      json['user_name'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$AdminVOToJson(AdminVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'email': instance.email,
    };
