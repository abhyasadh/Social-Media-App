import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../core/network/http_service.dart';

final messageDataSourceProvider = Provider<MessageDataSource>(
  (ref) => MessageDataSource(
      ref.read(httpServiceProvider(ApiEndpoints.oysterURL)), ref),
);

class MessageDataSource {
  final Dio _dio;
  final ProviderRef ref;

  MessageDataSource(this._dio, this.ref);

  Future<Either<Failure, List<dynamic>>> getMessages() async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.getPosts}/',
        data: {'id': ref.read(navViewModelProvider).userData?['hash']},
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': '*/*',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Right(response.data);
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
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
