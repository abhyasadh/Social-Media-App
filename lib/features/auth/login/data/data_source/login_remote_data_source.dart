import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/constants/api_endpoints.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/network/http_service.dart';

final loginRemoteDataSourceProvider =
    Provider.autoDispose<LoginRemoteDataSource>(
  (ref) => LoginRemoteDataSource(
    dio: ref.read(httpServiceProvider(ApiEndpoints.api1URL)),
  ),
);

class LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSource({
    required this.dio,
  });

  Future<Either<Failure, Map<String, dynamic>>> login(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 201) {
        try {
          final clonedDio = Dio(dio.options.copyWith(
            baseUrl: 'https://yaallo.com/__data.json?x-sveltekit-trailing-slash=1&x-sveltekit-invalidated=101',
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Cookie': 'accessToken=${response.data['accessToken']}',
            },
          ));
          Response userData = await clonedDio.get('');
          var requiredData = parseResponse(userData.data)['users'][0];
          requiredData['accessToken'] = response.data['accessToken'];

          return Right(requiredData);
        } on DioException catch (e) {
          return Left(
            Failure(
              error: e.error.toString(),
              statusCode: e.response?.statusCode.toString() ?? '0',
            ),
          );
        }
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

  Map<String, dynamic> parseResponse(Map<String, dynamic> response) {
    final parsed = response;
    final List<dynamic> nodes = parsed['nodes'];
    final List<Map<String, dynamic>> users = [];

    for (var node in nodes) {
      if (node['type'] == 'data') {
        final List<dynamic> data = node['data'];
        final Map<String, dynamic> userMap = {};

        Map<String, dynamic> keys = data[1];
        List<dynamic> values = data.sublist(2);

        keys.forEach((key, value) {
          userMap[key] = values[value - 2];
        });

        users.add(userMap);
      }
    }

    return {'users': users};
  }
}
