import'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../data/repository/login_remote_repo_impl.dart';

final loginRepositoryProvider = Provider.autoDispose<ILoginRepository>((ref) => ref.read(loginRemoteRepoProvider));

abstract class ILoginRepository{
  Future<Either<Failure, Map<String, dynamic>>> login(String phone, String password);
}