// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaAPIModel _$MediaAPIModelFromJson(Map<String, dynamic> json) =>
    MediaAPIModel(
      med: json['med'] as String?,
      status: json['status'] as bool?,
      filename: json['filename'] as String?,
      ori: json['ori'] as String?,
    );

Map<String, dynamic> _$MediaAPIModelToJson(MediaAPIModel instance) =>
    <String, dynamic>{
      'med': instance.med,
      'status': instance.status,
      'filename': instance.filename,
      'ori': instance.ori,
    };
