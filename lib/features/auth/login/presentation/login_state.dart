class LoginState {
  final bool isLoading;
  final bool rememberMe;

  LoginState({required this.isLoading, this.rememberMe = false});

  factory LoginState.initialState() =>
      LoginState(isLoading: false, rememberMe: false,);

  LoginState copyWith({
    String? email,
    bool? isLoading,
    bool? rememberMe,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
