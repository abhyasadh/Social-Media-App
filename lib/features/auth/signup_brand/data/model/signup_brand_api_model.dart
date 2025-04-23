import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/signup_brand_entity.dart';

@JsonSerializable()
class SignupBrandAPIModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String brandName;
  final String email;
  final String password;
  final String? profilePic;
  final String? poster;

  SignupBrandAPIModel({
    this.userId,
    required this.brandName,
    required this.email,
    required this.password,
    this.profilePic,
    this.poster,
  });

  Map<String, dynamic> toJson() {
    return {
      'brandName': brandName,
      'email': email,
      'password': password,
      'profilePic': profilePic,
      'poster': poster,
    };
  }

  factory SignupBrandAPIModel.fromEntity(SignupBrandEntity entity) {
    return SignupBrandAPIModel(
      brandName: entity.brandName,
      email: entity.email,
      password: entity.password,
      profilePic: entity.profilePic,
      poster: entity.poster,
    );
  }
}
