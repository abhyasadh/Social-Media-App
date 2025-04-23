import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../data/message_remote_repo_impl.dart';

final messageRepositoryProvider = Provider<IMessageRepository>(
      (ref) => ref.read(messageRemoteRepositoryProvider),
);

abstract class IMessageRepository {
  Future<Either<Failure, List<dynamic>>> getMessages();
}
