import 'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../data/repository/signup_user_remote_repo_impl.dart';
import '../entity/signup_user_entity.dart';

final signupUserRepositoryProvider = Provider.autoDispose<ISignupUserRepository>(
    (ref) => ref.read(signupUserRemoteRepoProvider));

abstract class ISignupUserRepository {
  Future<Either<Failure, bool>> signupUser(SignupUserEntity user);
}