import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/jobs/data/job_data_source.dart';

import '../../../../core/failure/failure.dart';
import '../data/job_remote_repo_impl.dart';
import 'job_entity.dart';

final jobRepositoryProvider = Provider<IJobRepository>(
      (ref) => ref.read(jobRemoteRepositoryProvider),
);

abstract class IJobRepository {
  Future<Either<Failure, List<JobEntity>>> getJobs();
  Future<Either<Failure, bool>> applyJob(FormData data);
  Future<Either<Failure, bool>> job(JobEntity entity, Method method);
}
