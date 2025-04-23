import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../domain/notification_repository.dart';
import 'notification_data_source.dart';


final notificationRemoteRepositoryProvider = Provider<INotificationRepository>(
      (ref) => NotificationRepositoryImpl(
    notificationDataSource: ref.read(notificationDataSourceProvider),
  ),
);

class NotificationRepositoryImpl implements INotificationRepository {
  final NotificationDataSource notificationDataSource;

  NotificationRepositoryImpl({required this.notificationDataSource});

  @override
  Future<Either<Failure, List<dynamic>>> getNotifications() {
    return notificationDataSource.getNotifications();
  }
}
