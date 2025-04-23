// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAPIModel _$UserAPIModelFromJson(Map<String, dynamic> json) => UserAPIModel(
      id: (json['id'] as num?)?.toInt(),
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      brname: json['brname'] as String?,
      cate: json['cate'] as String?,
      fans: (json['fans'] as num?)?.toInt(),
      web: json['web'] as String?,
      info: json['info'] as String?,
      tel: json['tel'] as String?,
      opening: json['opening'] as String?,
      address: json['address'] as String?,
      lastUpdate: (json['last_update'] as num?)?.toInt(),
      lastLogin: (json['last_login'] as num?)?.toInt(),
      regDate: (json['reg_date'] as num?)?.toInt(),
      profileImg: json['profile_img'] as String?,
      profilePoster: json['profile_poster'] as String?,
      pass: json['pass'] as String?,
      email: json['email'] as String?,
      hash: json['hash'] as String?,
      deleteds: json['deleteds'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$UserAPIModelToJson(UserAPIModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'brname': instance.brname,
      'cate': instance.cate,
      'fans': instance.fans,
      'web': instance.web,
      'info': instance.info,
      'tel': instance.tel,
      'opening': instance.opening,
      'address': instance.address,
      'last_update': instance.lastUpdate,
      'last_login': instance.lastLogin,
      'reg_date': instance.regDate,
      'profile_img': instance.profileImg,
      'profile_poster': instance.profilePoster,
      'pass': instance.pass,
      'email': instance.email,
      'hash': instance.hash,
      'deleteds': instance.deleteds,
      'type': instance.type,
    };
