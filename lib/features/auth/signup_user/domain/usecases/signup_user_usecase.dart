import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../entity/signup_user_entity.dart';
import '../repository/signup_user_repository.dart';

final signupUserUseCaseProvider = Provider.autoDispose<SignupUserUseCase>((ref) => SignupUserUseCase(repository: ref.read(signupUserRepositoryProvider)));

class SignupUserUseCase{
  final ISignupUserRepository repository;

  SignupUserUseCase({required this.repository});

  Future<Either<Failure, bool>> signupUser(SignupUserEntity user) async {
    return await repository.signupUser(user);
  }
}