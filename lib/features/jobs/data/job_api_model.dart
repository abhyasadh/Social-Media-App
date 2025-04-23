import 'package:json_annotation/json_annotation.dart';

import '../domain/job_entity.dart';

part 'job_api_model.g.dart';

@JsonSerializable()
class JobAPIModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? ti;
  final String? loc;
  final int? sMax;
  final int? sMin;
  final String? dur;
  final String? type;
  final String? ind;
  final String? des;
  final String? brid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Map<String, String>>? applicant;

  JobAPIModel({
    this.id,
    required this.ti,
    required this.loc,
    required this.sMax,
    required this.sMin,
    required this.dur,
    required this.type,
    required this.ind,
    required this.des,
    required this.brid,
    required this.createdAt,
    required this.updatedAt,
    required this.applicant,
  });

  factory JobAPIModel.fromJson(Map<String, dynamic> json) =>
      _$JobAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobAPIModelToJson(this);

  factory JobAPIModel.fromEntity(JobEntity entity){
    return JobAPIModel(
      id: entity.id,
      ti: entity.ti,
      loc: entity.loc,
      sMax: entity.sMax,
      sMin: entity.sMin,
      dur: entity.dur,
      type: entity.type,
      ind: entity.ind,
      des: entity.des,
      brid: entity.brid,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      applicant: entity.applicant,
    );
  }

  static JobEntity toEntity(JobAPIModel model) {
    return JobEntity(
      id: model.id,
      ti: model.ti,
      loc: model.loc,
      sMax: model.sMax,
      sMin: model.sMin,
      dur: model.dur,
      type: model.type,
      ind: model.ind,
      des: model.des,
      brid: model.brid,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      applicant: model.applicant,
    );
  }
}
