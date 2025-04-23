import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/features/jobs/data/job_data_source.dart';

import '../../../../core/failure/failure.dart';
import 'job_entity.dart';
import 'job_repository.dart';

final jobUseCaseProvider = Provider<JobUseCase>(
      (ref) => JobUseCase(jobRepository: ref.read(jobRepositoryProvider)),
);

class JobUseCase {
  final IJobRepository jobRepository;

  JobUseCase({required this.jobRepository});

  Future<Either<Failure, List<JobEntity>>> getJobs() async {
    return await jobRepository.getJobs();
  }

  Future<Either<Failure, bool>> applyJob(FormData data) async {
    return await jobRepository.applyJob(data);
  }

  Future<Either<Failure, bool>> createJob(JobEntity entity, Method method) async {
    return await jobRepository.job(entity, method);
  }
}