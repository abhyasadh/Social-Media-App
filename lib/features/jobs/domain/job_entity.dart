import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class JobEntity extends Equatable {
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

  const JobEntity({
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

  factory JobEntity.empty() {
    return JobEntity(
      id: null,
      ti: null,
      loc: null,
      sMax: 0,
      sMin: 0,
      dur: null,
      type: null,
      ind: null,
      des: null,
      brid: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      applicant: [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        ti,
        loc,
        sMax,
        sMin,
        dur,
        type,
        ind,
        des,
        brid,
        createdAt,
        updatedAt,
        applicant,
      ];
}
