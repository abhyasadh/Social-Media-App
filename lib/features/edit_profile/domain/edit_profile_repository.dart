import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/edit_profile/data/edit_profile_repo_impl.dart';
import 'package:yaallo/features/edit_profile/domain/brand_entity.dart';
import 'package:yaallo/features/edit_profile/domain/user_entity.dart';

import '../../../core/failure/failure.dart';

final editProfileRepositoryProvider = Provider<IEditProfileRepository>((ref) {
  return ref.read(editProfileRemoteRepositoryProvider);
});

abstract class IEditProfileRepository {
  Future<Either<Failure, bool>> updateUser(UserEntity user);
  Future<Either<Failure, bool>> updateBrand(BrandEntity brand);
}
