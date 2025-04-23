import 'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../data/repository/signup_brand_remote_repo_impl.dart';
import '../entity/signup_brand_entity.dart';

final signupBrandRepositoryProvider = Provider.autoDispose<ISignupBrandRepository>(
    (ref) => ref.read(signupBrandRemoteRepoProvider));

abstract class ISignupBrandRepository {
  Future<Either<Failure, bool>> signupBrand(SignupBrandEntity brand);
}