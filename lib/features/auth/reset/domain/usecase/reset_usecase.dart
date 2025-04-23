import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../repository/reset_repository.dart';

final resetUseCaseProvider = Provider.autoDispose<ResetUseCase>(
  (ref) => ResetUseCase(
    resetRepository: ref.read(resetRepositoryProvider),
  ),
);

class ResetUseCase {
  final IResetRepository resetRepository;

  ResetUseCase({
    required this.resetRepository,
  });

  Future<Either<Failure, int>> sendOTP(String email) async {
    return resetRepository.sendOTP(email);
  }

  Future<Either<Failure, bool>> resetPassword(String email, String password) async {
    return resetRepository.resetPassword(email, password);
  }
}
