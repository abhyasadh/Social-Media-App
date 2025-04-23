class SignupUserEntity {
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  late String? profilePic;
  late String? poster;

  SignupUserEntity({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.profilePic,
    this.poster,
  });
}
