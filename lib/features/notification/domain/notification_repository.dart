import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../data/notification_remote_repo_impl.dart';

final notificationRepositoryProvider = Provider<INotificationRepository>(
      (ref) => ref.read(notificationRemoteRepositoryProvider),
);

abstract class INotificationRepository {
  Future<Either<Failure, List<dynamic>>> getNotifications();
}
