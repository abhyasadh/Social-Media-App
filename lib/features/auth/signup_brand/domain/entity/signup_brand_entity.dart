class SignupBrandEntity {
  final String? userId;
  final String brandName;
  final String email;
  final String password;
  late String? profilePic;
  late String? poster;

  SignupBrandEntity({
    this.userId,
    required this.brandName,
    required this.email,
    required this.password,
    this.profilePic,
    this.poster,
  });
}
