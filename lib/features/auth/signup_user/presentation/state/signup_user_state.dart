class SignupUserState {
  final String email;
  final bool isLoading;
  final bool rememberMe;

  SignupUserState({required this.email, required this.isLoading, this.rememberMe = false});

  factory SignupUserState.initialState() =>
      SignupUserState(email: '', isLoading: false, rememberMe: false,);

  SignupUserState copyWith({
    String? email,
    bool? isLoading,
    bool? rememberMe,
  }) {
    return SignupUserState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}