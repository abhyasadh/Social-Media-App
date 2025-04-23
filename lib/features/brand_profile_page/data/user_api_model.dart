import 'package:json_annotation/json_annotation.dart';
import '../domain/user_entity.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserAPIModel {
  @JsonKey(name: 'id')
  final int? id;
  final String? fname;
  final String? lname;
  final String? brname;
  final String? cate;
  final int? fans;
  final String? web;
  final String? info;
  final String? tel;
  final String? opening;
  final String? address;
  @JsonKey(name: 'last_update')
  final int? lastUpdate;
  @JsonKey(name: 'last_login')
  final int? lastLogin;
  @JsonKey(name: 'reg_date')
  final int? regDate;
  @JsonKey(name: 'profile_img')
  final String? profileImg;
  @JsonKey(name: 'profile_poster')
  final String? profilePoster;
  final String? pass;
  final String? email;
  final String? hash;
  final String? deleteds;
  final String? type;

  UserAPIModel({
    this.id,
    this.fname,
    this.lname,
    this.brname,
    this.cate,
    this.fans,
    this.web,
    this.info,
    this.tel,
    this.opening,
    this.address,
    this.lastUpdate,
    this.lastLogin,
    this.regDate,
    this.profileImg,
    this.profilePoster,
    this.pass,
    this.email,
    this.hash,
    this.deleteds,
    this.type,
  });

  factory UserAPIModel.fromJson(Map<String, dynamic> json) =>
      _$UserAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAPIModelToJson(this);

  static UserEntity toEntity(UserAPIModel model) {
    return UserEntity(
      id: model.id,
      fname: model.fname,
      lname: model.lname,
      brname: model.brname,
      cate: model.cate,
      fans: model.fans,
      web: model.web,
      info: model.info,
      tel: model.tel,
      opening: model.opening,
      address: model.address,
      lastUpdate: model.lastUpdate != null
          ? DateTime.fromMillisecondsSinceEpoch(model.lastUpdate! * 1000)
          : null,
      lastLogin: model.lastLogin != null
          ? DateTime.fromMillisecondsSinceEpoch(model.lastLogin! * 1000)
          : null,
      regDate: model.regDate != null
          ? DateTime.fromMillisecondsSinceEpoch(model.regDate! * 1000)
          : null,
      profileImg: model.profileImg,
      profilePoster: model.profilePoster,
      pass: model.pass,
      email: model.email,
      hash: model.hash,
      deleteds: model.deleteds,
      type: model.type,
    );
  }
}
