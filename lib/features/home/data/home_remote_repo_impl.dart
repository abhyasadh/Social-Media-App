import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/home/domain/entity/post_entity.dart';

import '../../../../core/failure/failure.dart';
import '../domain/home_repository.dart';
import 'home_data_source.dart';


final homeRemoteRepositoryProvider = Provider<IHomeRepository>(
      (ref) => HomeRepositoryImpl(
    homeDataSource: ref.read(homeDataSourceProvider),
  ),
);

class HomeRepositoryImpl implements IHomeRepository {
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl({required this.homeDataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts(int page) {
    return homeDataSource.getPosts(page);
  }
}
