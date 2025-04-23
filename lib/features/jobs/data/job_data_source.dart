import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/jobs/data/job_api_model.dart';
import 'package:yaallo/features/jobs/domain/job_entity.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../core/network/http_service.dart';

final jobDataSourceProvider = Provider<JobDataSource>(
  (ref) =>
      JobDataSource(ref.read(httpServiceProvider(ApiEndpoints.api1URL)), ref),
);

enum Method { newJob, editJob, deleteJob }

class JobDataSource {
  final Dio _dio;
  final ProviderRef ref;

  JobDataSource(this._dio, this.ref);

  Future<Either<Failure, List<JobEntity>>> getJobs() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getJobs,
      );
      if (response.statusCode == 200) {
        List<JobEntity> jobList = [];
        for (var item in response.data) {
          jobList.add(JobAPIModel.toEntity(JobAPIModel.fromJson(item)));
        }
        return Right(jobList);
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

  Future<Either<Failure, bool>> applyJob(FormData data) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.applyJob,
        data: data,
      );
      if (response.statusCode == 200) {
        return const Right(true);
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

  Future<Either<Failure, bool>> job(
      {required JobEntity entity, required Method method}) async {
    final data = {
      'des': entity.des,
      'dur': entity.dur,
      'ind': entity.ind,
      'loc': entity.loc,
      'sMax': entity.sMax,
      'sMin': entity.sMin,
      'ti': entity.ti,
      'type': entity.type,
      'brid': entity.brid,
    };
    try {
      Response response;
      method == Method.editJob
          ? response = await _dio.patch(
              '${ApiEndpoints.getJobs}/${entity.id}',
              data: data,
            )
          : method == Method.newJob
              ? response = await _dio.post(
                  ApiEndpoints.getJobs,
                  data: data,
                )
              : response = await _dio.delete(
                  '${ApiEndpoints.getJobs}/${entity.id}',
                );
      if (response.statusCode == (method == Method.newJob ? 201 : 200)) {
        return const Right(true);
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
