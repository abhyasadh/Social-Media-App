import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/edit_profile/domain/brand_entity.dart';
import 'package:yaallo/features/edit_profile/domain/user_entity.dart';

import '../../../core/failure/failure.dart';
import '../domain/edit_profile_repository.dart';
import 'edit_profile_data_source.dart';

final editProfileRemoteRepositoryProvider = Provider<IEditProfileRepository>((ref) {
  return EditProfileRemoteRepoImpl(
    ref.read(editProfileRemoteDataSourceProvider),
  );
});

class EditProfileRemoteRepoImpl implements IEditProfileRepository {
  final EditProfileDataSource _authRemoteDataSource;
  EditProfileRemoteRepoImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> updateUser(UserEntity user) {
    return _authRemoteDataSource.updateUser(user);
  }

  @override
  Future<Either<Failure, bool>> updateBrand(BrandEntity brand) {
    return _authRemoteDataSource.updateBrand(brand);
  }
}
