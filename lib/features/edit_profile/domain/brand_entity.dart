import 'dart:io';

import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  final String? address;
  final String? brname;
  final String? cate;
  final String? fname;
  final String? info;
  final String? lname;
  final String? opening;
  final File? profileImg;
  final String? profilePoster;
  final String? tel;
  final String? web;

  @override
  List<Object?> get props =>
      [address, brname, cate, fname, info, lname, opening, profileImg, profilePoster, tel, web];

  const BrandEntity({
    this.address,
    this.brname,
    this.cate,
    this.fname,
    this.info,
    this.lname,
    this.opening,
    this.profileImg,
    this.profilePoster,
    this.tel,
    this.web,
  });

  Map<String, dynamic> toJson() => {
    "address": address ?? '',
    "brname": brname ?? '',
    "cate": cate ?? '',
    "fname": fname ?? '',
    "info": info ?? '',
    "lname": lname ?? '',
    "opening": opening ?? '',
    "profile_img": profileImg ?? '',
    "profile_poster": profilePoster ?? '',
    "tel": tel ?? '',
    "web": web ?? '',
  };
}
