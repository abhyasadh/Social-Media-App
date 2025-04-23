import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../domain/entity/signup_brand_entity.dart';
import '../../domain/repository/signup_brand_repository.dart';
import '../data_source/signup_brand_remote_data_source.dart';

final signupBrandRemoteRepoProvider = Provider.autoDispose<ISignupBrandRepository>(
  (ref) => SignupBrandRemoteRepoImpl(
    signupBrandRemoteDataSource: ref.read(signupBrandRemoteDataSourceProvider),
  ),
);

class SignupBrandRemoteRepoImpl implements ISignupBrandRepository {
  final SignupBrandRemoteDataSource signupBrandRemoteDataSource;

  SignupBrandRemoteRepoImpl({required this.signupBrandRemoteDataSource});

  @override
  Future<Either<Failure, bool>> signupBrand(SignupBrandEntity brand) {
    return signupBrandRemoteDataSource.signupBrand(brand);
  }
}
