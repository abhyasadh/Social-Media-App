import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/brand_profile_page/domain/user_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../home/domain/entity/post_entity.dart';
import '../data/brand_profile_remote_repo_impl.dart';

final brandProfileRepositoryProvider = Provider<IBrandProfileRepository>(
      (ref) => ref.read(brandProfileRemoteRepositoryProvider),
);

abstract class IBrandProfileRepository {
  Future<Either<Failure, UserEntity>> getBrandProfile(String hash);
  Future<Either<Failure, List<PostEntity>>> getPosts(int page, String hash);
}
