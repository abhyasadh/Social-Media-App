import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/notification_usecase.dart';
import 'notification_state.dart';

final notificationViewModelProvider =
StateNotifierProvider.autoDispose<NotificationViewModel, NotificationState>((ref) => NotificationViewModel(
  ref.read(notificationUseCaseProvider),
));

class NotificationViewModel extends StateNotifier<NotificationState> {
  final NotificationUseCase _notificationUseCase;

  NotificationViewModel(
      this._notificationUseCase,
      ) : super(
    NotificationState.initial(),
  ) {
    getNotifications();
  }

  Future resetState() async {
    state = NotificationState.initial();
    getNotifications();
  }

  Future getNotifications() async {
    // state = state.copyWith(isLoading: true);
    // final result = await _notificationUseCase.getNotifications();
    // result.fold((failure) => state = state.copyWith(isLoading: false), (data) {
    //   state = state.copyWith(
    //     notifications: data,
    //     isLoading: false,
    //   );
    // });
    return [];
  }
}
