import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/brand_profile_page/data/user_api_model.dart';
import 'package:yaallo/features/brand_profile_page/domain/user_entity.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../core/network/http_service.dart';
import '../../home/data/home_dto.dart';
import '../../home/data/model/post_api_model.dart';
import '../../home/domain/entity/post_entity.dart';

final brandProfileDataSourceProvider = Provider<BrandProfileDataSource>(
      (ref) => BrandProfileDataSource(
        ref.read(httpServiceProvider(ApiEndpoints.api1URL)), ref.read(httpServiceProvider(ApiEndpoints.sharkURL))
  ),
);

class BrandProfileDataSource {
  final Dio _dio1;
  final Dio _dio2;
  BrandProfileDataSource(this._dio1, this._dio2);

  Future<Either<Failure, UserEntity>> getUser(String hash) async {
    try {
      final response = await _dio1.get(
        '${ApiEndpoints.getUserByHash}/$hash',
      );
      if (response.statusCode == 200) {
        final model = UserAPIModel.fromJson(response.data['user']);
        final entity = UserAPIModel.toEntity(model);
        return Right(entity);
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

  Future<Either<Failure, List<PostEntity>>> getPosts(int page, String hash) async {
    try {
      final response = await _dio2.post(
          ApiEndpoints.getPosts, data: {'page': page, 'limit': 10, 'brid': hash}
      );
      if (response.statusCode == 200 && response.data[1]['status']=='true') {
        HomeDTO dto = HomeDTO.fromJson(response.data[0]);
        List<PostEntity> postList =
        dto.data.map((post) => PostAPIModel.toEntity(post)).toList();
        return Right(postList);
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
