import 'package:json_annotation/json_annotation.dart';
import 'package:yaallo/features/home/data/model/media_api_model.dart';

import '../../domain/entity/post_entity.dart';

part 'post_api_model.g.dart';

@JsonSerializable()
class PostAPIModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? country;
  final String? title;
  final List<MediaAPIModel>? media;
  final String? time;
  final String? brid;
  final List<String>? userId;
  final int? like;
  final bool? hidden;
  final List<String>? saved;
  final List<String>? hide;
  final List<String>? report;
  final bool? hasURL;
  final String? urlti;
  final String? urldes;
  final String? urlimg;
  final String? urlsel;
  final bool? repost;
  final String? reposterId;
  final List<dynamic>? data;
  final List<dynamic>? reposterData;
  final int? count;

  PostAPIModel({
    required this.id,
    required this.country,
    required this.title,
    required this.media,
    required this.time,
    required this.brid,
    required this.userId,
    required this.like,
    required this.hidden,
    required this.saved,
    required this.hide,
    required this.report,
    required this.hasURL,
    required this.urlti,
    required this.urldes,
    required this.urlimg,
    required this.urlsel,
    required this.repost,
    required this.reposterId,
    required this.data,
    required this.reposterData,
    required this.count,
  });

  factory PostAPIModel.fromJson(Map<String, dynamic> json) =>
      _$PostAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostAPIModelToJson(this);

  static PostEntity toEntity(PostAPIModel model) {
    return PostEntity(
      id: model.id,
      country: model.country,
      title: model.title,
      media: model.media?.map((element) => MediaAPIModel.toEntity(element)).toList(),
      time: DateTime.fromMillisecondsSinceEpoch(int.parse(model.time!)),
      brid: model.brid,
      userId: model.userId,
      like: model.like,
      hidden: model.hidden,
      saved: model.saved,
      hide: model.hide,
      report: model.report,
      hasURL: model.hasURL,
      urlti: model.urlti,
      urldes: model.urldes,
      urlimg: model.urlimg,
      urlsel: model.urlsel,
      repost: model.repost,
      reposterId: model.reposterId,
      data: model.data,
      reposterData: model.reposterData,
      count: model.count,
    );
  }
}
