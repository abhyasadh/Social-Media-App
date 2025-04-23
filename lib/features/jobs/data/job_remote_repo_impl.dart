import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/jobs/domain/job_entity.dart';

import '../../../../core/failure/failure.dart';
import '../domain/job_repository.dart';
import 'job_data_source.dart';


final jobRemoteRepositoryProvider = Provider<IJobRepository>(
      (ref) => JobRepositoryImpl(
    jobDataSource: ref.read(jobDataSourceProvider),
  ),
);

class JobRepositoryImpl implements IJobRepository {
  final JobDataSource jobDataSource;

  JobRepositoryImpl({required this.jobDataSource});

  @override
  Future<Either<Failure, List<JobEntity>>> getJobs() {
    return jobDataSource.getJobs();
  }

  @override
  Future<Either<Failure, bool>> applyJob(FormData data) {
    return jobDataSource.applyJob(data);
  }

  @override
  Future<Either<Failure, bool>> job(JobEntity entity, Method method) {
    return jobDataSource.job(entity: entity, method: method);
  }
}
