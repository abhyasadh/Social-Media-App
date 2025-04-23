import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/brand_profile_page/domain/user_entity.dart';
import 'package:yaallo/features/home/domain/entity/post_entity.dart';

import '../../../../core/failure/failure.dart';
import '../domain/brand_profile_repository.dart';
import 'brand_profile_data_source.dart';


final brandProfileRemoteRepositoryProvider = Provider<IBrandProfileRepository>(
      (ref) => BrandProfileRepositoryImpl(
    brandProfileDataSource: ref.read(brandProfileDataSourceProvider),
  ),
);

class BrandProfileRepositoryImpl implements IBrandProfileRepository {
  final BrandProfileDataSource brandProfileDataSource;

  BrandProfileRepositoryImpl({required this.brandProfileDataSource});

  @override
  Future<Either<Failure, UserEntity>> getBrandProfile(String hash) {
    return brandProfileDataSource.getUser(hash);
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts(int page, String hash) {
    return brandProfileDataSource.getPosts(page, hash);
  }
}
