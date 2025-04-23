import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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
  final DateTime? lastUpdate;
  final DateTime? lastLogin;
  final DateTime? regDate;
  final String? profileImg;
  final String? profilePoster;
  final String? pass;
  final String? email;
  final String? hash;
  final String? deleteds;
  final String? type;

  const UserEntity({
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

  @override
  List<Object?> get props => [
    id,
    fname,
    lname,
    brname,
    cate,
    fans,
    web,
    info,
    tel,
    opening,
    address,
    lastUpdate,
    lastLogin,
    regDate,
    profileImg,
    profilePoster,
    pass,
    email,
    hash,
    deleteds,
    type,
  ];
}
