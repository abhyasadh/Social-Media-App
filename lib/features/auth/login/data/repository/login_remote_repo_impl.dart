import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../domain/repository/login_repository.dart';
import '../data_source/login_remote_data_source.dart';

final loginRemoteRepoProvider = Provider.autoDispose<ILoginRepository>(
  (ref) => LoginRemoteRepoImpl(
    loginRemoteDataSource: ref.read(loginRemoteDataSourceProvider),
  ),
);

class LoginRemoteRepoImpl implements ILoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRemoteRepoImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(String phone, String password) {
    return loginRemoteDataSource.login(phone, password);
  }
}
