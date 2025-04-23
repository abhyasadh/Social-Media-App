import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../domain/entity/signup_user_entity.dart';
import '../../domain/repository/signup_user_repository.dart';
import '../data_source/signup_user_remote_data_source.dart';

final signupUserRemoteRepoProvider = Provider.autoDispose<ISignupUserRepository>(
  (ref) => SignupUserRemoteRepoImpl(
    signupUserRemoteDataSource: ref.read(signupUserRemoteDataSourceProvider),
  ),
);

class SignupUserRemoteRepoImpl implements ISignupUserRepository {
  final SignupUserRemoteDataSource signupUserRemoteDataSource;

  SignupUserRemoteRepoImpl({required this.signupUserRemoteDataSource});

  @override
  Future<Either<Failure, bool>> signupUser(SignupUserEntity user) {
    return signupUserRemoteDataSource.signupUser(user);
  }
}
