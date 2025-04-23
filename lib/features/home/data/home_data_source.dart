import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/home/data/model/post_api_model.dart';
import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../core/network/http_service.dart';
import '../domain/entity/post_entity.dart';
import 'home_dto.dart';

final homeDataSourceProvider = Provider<HomeDataSource>(
      (ref) => HomeDataSource(
        ref.read(httpServiceProvider(ApiEndpoints.sharkURL)),
  ),
);

class HomeDataSource {
  final Dio _dio;
  HomeDataSource(this._dio);

  Future<Either<Failure, List<PostEntity>>> getPosts(int page) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.getPosts, data: {'page': page, 'limit': 6}
      );
      if (response.statusCode == 200 && response.data[1]['status']=='true') {
        HomeDTO homeDTO = HomeDTO.fromJson(response.data[0]);
        List<PostEntity> homeList =
        homeDTO.data.map((post) => PostAPIModel.toEntity(post)).toList();
        return Right(homeList);
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
