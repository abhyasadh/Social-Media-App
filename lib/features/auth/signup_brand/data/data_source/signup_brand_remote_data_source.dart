import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/constants/api_endpoints.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/network/http_service.dart';
import '../../domain/entity/signup_brand_entity.dart';
import '../model/signup_brand_api_model.dart';

final signupBrandRemoteDataSourceProvider =
    Provider.autoDispose<SignupBrandRemoteDataSource>(
  (ref) => SignupBrandRemoteDataSource(
    dio: ref.read(httpServiceProvider(ApiEndpoints.api1URL)),
  ),
);

class SignupBrandRemoteDataSource {
  final Dio dio;

  SignupBrandRemoteDataSource({required this.dio});

  Future<Either<Failure, bool>> signupBrand(SignupBrandEntity signupBrand) async {
    try {
      var avatars = await dio.post(ApiEndpoints.generateAvatars, data: {
        'brandName': signupBrand.brandName,
      });
      if (avatars.statusCode == 201) {
        signupBrand.profilePic = avatars.data['files'][0]['filename'];
        signupBrand.poster = avatars.data['files'][1]['filename'];
      } else {
        return Left(
          Failure(
            error: avatars.data["message"],
            statusCode: avatars.statusCode.toString(),
          ),
        );
      }

      SignupBrandAPIModel signupBrandAPIModel = SignupBrandAPIModel.fromEntity(signupBrand);
      var response = await dio.post(ApiEndpoints.register, data: signupBrandAPIModel.toJson());
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
