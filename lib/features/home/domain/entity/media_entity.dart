import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MediaEntity extends Equatable {
  final String? med;
  final bool? status;
  final String? filename;
  final String? ori;

  const MediaEntity({
    required this.med,
    required this.status,
    required this.filename,
    required this.ori,
  });

  @override
  List<Object?> get props => [med, status, filename, ori];
}
