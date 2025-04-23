import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/media_entity.dart';

part 'media_api_model.g.dart';

@JsonSerializable()
class MediaAPIModel {
  final String? med;
  final bool? status;
  final String? filename;
  final String? ori;

  MediaAPIModel({
    required this.med,
    required this.status,
    required this.filename,
    required this.ori,
  });

  factory MediaAPIModel.fromJson(Map<String, dynamic> json) =>
      _$MediaAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaAPIModelToJson(this);

  static MediaEntity toEntity(MediaAPIModel model) {
    return MediaEntity(
      med: model.med,
      status: model.status,
      filename: model.filename,
      ori: model.ori
    );
  }
}
