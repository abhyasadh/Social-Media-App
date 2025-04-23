import'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../data/repository/reset_remote_repo_impl.dart';

final resetRepositoryProvider = Provider.autoDispose<IResetRepository>((ref) => ref.read(resetRemoteRepoProvider));

abstract class IResetRepository{
  Future<Either<Failure, int>> sendOTP(String email);
  Future<Either<Failure, bool>> resetPassword(String email, String password);
}