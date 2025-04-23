import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/brand_profile_page/domain/user_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../home/domain/entity/post_entity.dart';
import 'brand_profile_repository.dart';

final brandProfileUseCaseProvider = Provider<BrandProfileUseCase>(
      (ref) => BrandProfileUseCase(brandProfileRepository: ref.read(brandProfileRepositoryProvider)),
);

class BrandProfileUseCase {
  final IBrandProfileRepository brandProfileRepository;

  BrandProfileUseCase({required this.brandProfileRepository});

  Future<Either<Failure, UserEntity>> getBrandProfile(String hash) async {
    return await brandProfileRepository.getBrandProfile(hash);
  }

  Future<Either<Failure, List<PostEntity>>> getPosts(int page, String hash) async {
    return await brandProfileRepository.getPosts(page, hash);
  }
}