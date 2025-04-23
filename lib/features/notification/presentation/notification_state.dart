class NotificationState {
  final List<dynamic> notifications;
  final bool isLoading;

  NotificationState({
    required this.notifications,
    required this.isLoading,
  });

  factory NotificationState.initial() {
    return NotificationState(
      notifications: [],
      isLoading: false,
    );
  }

  NotificationState copyWith({
    List<dynamic>? notifications,
    bool? isLoading,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
