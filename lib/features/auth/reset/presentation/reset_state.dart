class ResetState {
  final bool isLoading;

  ResetState({required this.isLoading,});

  factory ResetState.initialState() =>
      ResetState(isLoading: false,);

  ResetState copyWith({
    bool? isLoading,
  }) {
    return ResetState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
