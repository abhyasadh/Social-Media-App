import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/signup_user_entity.dart';

@JsonSerializable()
class SignupUserAPIModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? profilePic;
  final String? poster;

  SignupUserAPIModel({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.profilePic,
    this.poster,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'profilePic': profilePic,
      'poster': poster,
    };
  }

  factory SignupUserAPIModel.fromEntity(SignupUserEntity entity) {
    return SignupUserAPIModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      profilePic: entity.profilePic,
      poster: entity.poster,
    );
  }
}
