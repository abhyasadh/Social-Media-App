import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/constants/api_endpoints.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/network/http_service.dart';

final resetRemoteDataSourceProvider =
    Provider.autoDispose<ResetRemoteDataSource>(
  (ref) => ResetRemoteDataSource(
    dio: ref.read(httpServiceProvider(ApiEndpoints.api1URL)),
  ),
);

class ResetRemoteDataSource {
  final Dio dio;

  ResetRemoteDataSource({
    required this.dio,
  });

  Future<Either<Failure, int>> sendOTP(
    String email,
  ) async {
    final otp = 1000 + Random().nextInt(9000);
    try {
      Response response = await dio.post(
        ApiEndpoints.sendOtp,
        data: {
          "email": email,
          "otp": otp
        },
      );
      if (response.statusCode == 201) {
          return Right(otp);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> resetPassword(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.resetPassword,
        data: {
          "email": email,
          "newPassword": password,
        },
      );
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
