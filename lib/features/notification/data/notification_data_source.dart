import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../core/network/http_service.dart';

final notificationDataSourceProvider = Provider<NotificationDataSource>(
      (ref) => NotificationDataSource(
        ref.read(httpServiceProvider(ApiEndpoints.sharkURL)), ref
  ),
);

class NotificationDataSource {
  final Dio _dio;
  final ProviderRef ref;
  NotificationDataSource(this._dio, this.ref);

  Future<Either<Failure, List<dynamic>>> getNotifications() async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.getNotifications}/${ref.read(navViewModelProvider).userData?['hash']}',
      );
      if (response.statusCode == 200) {
        List<dynamic> notificationList = [];
        for (var item in response.data) {
          notificationList.add(item);
        }
        return Right(notificationList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}
