import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import 'notification_repository.dart';

final notificationUseCaseProvider = Provider<NotificationUseCase>(
      (ref) => NotificationUseCase(notificationRepository: ref.read(notificationRepositoryProvider)),
);

class NotificationUseCase {
  final INotificationRepository notificationRepository;

  NotificationUseCase({required this.notificationRepository});

  Future<Either<Failure, List<dynamic>>> getNotifications() async {
    return await notificationRepository.getNotifications();
  }
}