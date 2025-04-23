import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'media_entity.dart';

@JsonSerializable()
class PostEntity extends Equatable {
  final String? id;
  final String? country;
  final String? title;
  final List<MediaEntity>? media;
  final DateTime? time;
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

  const PostEntity({
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

  @override
  List<Object?> get props => [
    id, country, title, media, time, brid, userId, like, hidden, saved, hide,
    report, hasURL, urlti, urldes, urlimg, urlsel, repost, reposterId,
    data, reposterData, count
  ];
}
