import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/home/domain/entity/post_entity.dart';

import '../../../../core/failure/failure.dart';
import '../data/home_remote_repo_impl.dart';

final homeRepositoryProvider = Provider<IHomeRepository>(
      (ref) => ref.read(homeRemoteRepositoryProvider),
);

abstract class IHomeRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts(int page);
}
