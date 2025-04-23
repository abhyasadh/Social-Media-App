import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../domain/repository/reset_repository.dart';
import '../data_source/reset_remote_data_source.dart';

final resetRemoteRepoProvider = Provider.autoDispose<IResetRepository>(
  (ref) => ResetRemoteRepoImpl(
    resetRemoteDataSource: ref.read(resetRemoteDataSourceProvider),
  ),
);

class ResetRemoteRepoImpl implements IResetRepository {
  final ResetRemoteDataSource resetRemoteDataSource;

  ResetRemoteRepoImpl({required this.resetRemoteDataSource});

  @override
  Future<Either<Failure, int>> sendOTP(String email) {
    return resetRemoteDataSource.sendOTP(email);
  }

  @override
  Future<Either<Failure, bool>> resetPassword(String email, String password) {
    return resetRemoteDataSource.resetPassword(email, password);
  }
}
