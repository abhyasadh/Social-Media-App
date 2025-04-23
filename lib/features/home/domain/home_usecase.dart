import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/home/domain/entity/post_entity.dart';
import 'package:yaallo/features/home/domain/home_repository.dart';

import '../../../../core/failure/failure.dart';

final homeUseCaseProvider = Provider<HomeUseCase>(
      (ref) => HomeUseCase(homeRepository: ref.read(homeRepositoryProvider)),
);

class HomeUseCase {
  final IHomeRepository homeRepository;

  HomeUseCase({required this.homeRepository});

  Future<Either<Failure, List<PostEntity>>> getPosts(int page) async {
    return await homeRepository.getPosts(page);
  }
}