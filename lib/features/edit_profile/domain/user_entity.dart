import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String fName;
  final String lName;
  final String info;
  final File? profilePic;

  @override
  List<Object?> get props =>
      [fName, lName, info, profilePic];

  const UserEntity({
    required this.fName,
    required this.lName,
    required this.info,
    this.profilePic,
  });

  Map<String, dynamic> toJson() => {
    "fname": fName,
    "lname": lName,
    "info": info,
    "profile_pic": profilePic,
  };
}
