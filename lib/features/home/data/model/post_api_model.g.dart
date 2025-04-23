// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAPIModel _$PostAPIModelFromJson(Map<String, dynamic> json) => PostAPIModel(
      id: json['_id'] as String?,
      country: json['country'] as String?,
      title: json['title'] as String?,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: json['time'] as String?,
      brid: json['brid'] as String?,
      userId:
          (json['userId'] as List<dynamic>?)?.map((e) => e as String).toList(),
      like: (json['like'] as num?)?.toInt(),
      hidden: json['hidden'] as bool?,
      saved:
          (json['saved'] as List<dynamic>?)?.map((e) => e as String).toList(),
      hide: (json['hide'] as List<dynamic>?)?.map((e) => e as String).toList(),
      report:
          (json['report'] as List<dynamic>?)?.map((e) => e as String).toList(),
      hasURL: json['hasURL'] as bool?,
      urlti: json['urlti'] as String?,
      urldes: json['urldes'] as String?,
      urlimg: json['urlimg'] as String?,
      urlsel: json['urlsel'] as String?,
      repost: json['repost'] as bool?,
      reposterId: json['reposterId'] as String?,
      data: json['data'] as List<dynamic>?,
      reposterData: json['reposterData'] as List<dynamic>?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PostAPIModelToJson(PostAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'country': instance.country,
      'title': instance.title,
      'media': instance.media,
      'time': instance.time,
      'brid': instance.brid,
      'userId': instance.userId,
      'like': instance.like,
      'hidden': instance.hidden,
      'saved': instance.saved,
      'hide': instance.hide,
      'report': instance.report,
      'hasURL': instance.hasURL,
      'urlti': instance.urlti,
      'urldes': instance.urldes,
      'urlimg': instance.urlimg,
      'urlsel': instance.urlsel,
      'repost': instance.repost,
      'reposterId': instance.reposterId,
      'data': instance.data,
      'reposterData': instance.reposterData,
      'count': instance.count,
    };
