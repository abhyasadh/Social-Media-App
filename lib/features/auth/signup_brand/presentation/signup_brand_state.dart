class SignupBrandState {
  final String email;
  final bool isLoading;
  final bool rememberMe;

  SignupBrandState({required this.email, required this.isLoading, this.rememberMe = false});

  factory SignupBrandState.initialState() =>
      SignupBrandState(email: '', isLoading: false, rememberMe: false,);

  SignupBrandState copyWith({
    String? email,
    bool? isLoading,
    bool? rememberMe,
  }) {
    return SignupBrandState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
