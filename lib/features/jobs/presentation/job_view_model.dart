import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/core/common/messages/show_snackbar.dart';
import 'package:yaallo/features/jobs/data/job_data_source.dart';
import 'package:yaallo/features/jobs/domain/job_entity.dart';

import '../domain/job_usecase.dart';
import 'job_state.dart';

final jobViewModelProvider =
    StateNotifierProvider.autoDispose<JobViewModel, JobState>((ref) => JobViewModel(
          ref.read(jobUseCaseProvider),
        ));

class JobViewModel extends StateNotifier<JobState> {
  final JobUseCase _jobUseCase;

  JobViewModel(
    this._jobUseCase,
  ) : super(
          JobState.initial(),
        ) {
    getJobs();
  }

  Future resetState() async {
    state = JobState.initial();
    getJobs();
  }

  Future getJobs() async {
    state = state.copyWith(isLoading: true);
    final result = await _jobUseCase.getJobs();
    result.fold((failure) => state = state.copyWith(isLoading: false), (data) {
      state = state.copyWith(
        jobs: data,
        isLoading: false,
      );
    });
  }

  void uploadFile(PlatformFile file) {
    state = state.copyWith(
      file: file,
    );
  }

  Future<void> applyJob(FormData data, WidgetRef ref) async {
    state = state.copyWith(applyLoading: true);
    final result = await _jobUseCase.applyJob(data);
    result.fold((failure) => state = state.copyWith(applyLoading: false),
        (data) {
      state = JobState.initial();
      getJobs();
      ref.read(navigationServiceProvider).goBack();
      showSnackBar(ref: ref, message: 'Application Submitted!');
    });
  }

  Future<void> job(JobEntity entity, Method method, WidgetRef ref) async {
    state = state.copyWith(createLoading: true);
    final result = await _jobUseCase.createJob(entity, method);
    result.fold(
      (failure) {
        state = state.copyWith(createLoading: false);
      },
      (data) {
       if (method != Method.deleteJob) ref.read(navigationServiceProvider).goBack();
        state = JobState.initial();
        getJobs();
        showSnackBar(ref: ref, message: method == Method.deleteJob ? 'Job Deleted!' : method == Method.editJob ? 'Job Updated!' : 'Job Created!');
      },
    );
  }
}
