import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../repository/login_repository.dart';

final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(
    loginRepository: ref.read(loginRepositoryProvider),
  ),
);

class LoginUseCase {
  final ILoginRepository loginRepository;

  LoginUseCase({
    required this.loginRepository,
  });

  Future<Either<Failure, Map<String, dynamic>>> login(String phone, String password) async {
    final result = await loginRepository.login(phone, password);
    return result;
  }
}
