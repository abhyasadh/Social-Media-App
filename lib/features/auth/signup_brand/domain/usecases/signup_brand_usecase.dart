import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../entity/signup_brand_entity.dart';
import '../repository/signup_brand_repository.dart';

final signupBrandUseCaseProvider = Provider.autoDispose<SignupBrandUseCase>((ref) => SignupBrandUseCase(repository: ref.read(signupBrandRepositoryProvider)));

class SignupBrandUseCase{
  final ISignupBrandRepository repository;

  SignupBrandUseCase({required this.repository});

  Future<Either<Failure, bool>> signupBrand(SignupBrandEntity brand) async {
    return await repository.signupBrand(brand);
  }
}