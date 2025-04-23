import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/constants/api_endpoints.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/network/http_service.dart';
import '../../domain/entity/signup_user_entity.dart';
import '../model/signup_user_api_model.dart';

final signupUserRemoteDataSourceProvider =
    Provider.autoDispose<SignupUserRemoteDataSource>(
  (ref) => SignupUserRemoteDataSource(
    dio: ref.read(httpServiceProvider(ApiEndpoints.api1URL)),
  ),
);

class SignupUserRemoteDataSource {
  final Dio dio;

  SignupUserRemoteDataSource({required this.dio});

  Future<Either<Failure, bool>> signupUser(SignupUserEntity signupUser) async {
    try {
      var avatars = await dio.post(ApiEndpoints.generateAvatars, data: {
        'firstName': signupUser.firstName,
        'lastName': signupUser.lastName,
      });
      if (avatars.statusCode == 201) {
        signupUser.profilePic = avatars.data['files'][0]['filename'];
        signupUser.poster = avatars.data['files'][1]['filename'];
      } else {
        return Left(
          Failure(
            error: avatars.data["message"],
            statusCode: avatars.statusCode.toString(),
          ),
        );
      }

      SignupUserAPIModel signupUserAPIModel = SignupUserAPIModel.fromEntity(signupUser);
      var response = await dio.post(ApiEndpoints.register, data: signupUserAPIModel.toJson());
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
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
