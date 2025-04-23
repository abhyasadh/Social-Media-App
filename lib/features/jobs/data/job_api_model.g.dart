// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobAPIModel _$JobAPIModelFromJson(Map<String, dynamic> json) => JobAPIModel(
      id: json['_id'] as String?,
      ti: json['ti'] as String?,
      loc: json['loc'] as String?,
      sMax: (json['sMax'] as num?)?.toInt(),
      sMin: (json['sMin'] as num?)?.toInt(),
      dur: json['dur'] as String?,
      type: json['type'] as String?,
      ind: json['ind'] as String?,
      des: json['des'] as String?,
      brid: json['brid'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      applicant: (json['applicant'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$JobAPIModelToJson(JobAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ti': instance.ti,
      'loc': instance.loc,
      'sMax': instance.sMax,
      'sMin': instance.sMin,
      'dur': instance.dur,
      'type': instance.type,
      'ind': instance.ind,
      'des': instance.des,
      'brid': instance.brid,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'applicant': instance.applicant,
    };
