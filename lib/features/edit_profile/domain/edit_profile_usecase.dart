import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/edit_profile/domain/brand_entity.dart';
import 'package:yaallo/features/edit_profile/domain/user_entity.dart';

import '../../../core/failure/failure.dart';
import 'edit_profile_repository.dart';

final editProfileUseCaseProvider = Provider((ref) {
  return EditProfileUseCase(ref.read(editProfileRepositoryProvider));
});

class EditProfileUseCase {
  final IEditProfileRepository _editProfileRepository;

  EditProfileUseCase(this._editProfileRepository);

  Future<Either<Failure, bool>> updateUser(UserEntity user) async {
    return await _editProfileRepository.updateUser(user);
  }

  Future<Either<Failure, bool>> updateBrand(BrandEntity brand) async {
    return await _editProfileRepository.updateBrand(brand);
  }
}
