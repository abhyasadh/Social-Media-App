import 'package:file_picker/file_picker.dart';
import 'package:yaallo/features/jobs/domain/job_entity.dart';

class JobState {
  final List<JobEntity> jobs;
  final bool isLoading;
  final bool applyLoading;
  final bool createLoading;
  final PlatformFile? file;

  JobState({
    this.file,
    required this.jobs,
    required this.isLoading,
    this.createLoading = false,
    this.applyLoading = false,
  });

  factory JobState.initial() {
    return JobState(
      file: null,
      jobs: [],
      isLoading: false,
    );
  }

  JobState copyWith({
    PlatformFile? file,
    List<JobEntity>? jobs,
    bool? isLoading,
    bool? applyLoading,
    bool? createLoading,
  }) {
    return JobState(
      file: file ?? this.file,
      jobs: jobs ?? this.jobs,
      isLoading: isLoading ?? this.isLoading,
      applyLoading: applyLoading ?? this.applyLoading,
      createLoading: createLoading ?? this.createLoading,
    );
  }
}
