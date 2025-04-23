import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';

import '../../../../../core/common/messages/show_snackbar.dart';
import '../../domain/usecases/signup_user_usecase.dart';
import '../../domain/entity/signup_user_entity.dart';
import '../state/signup_user_state.dart';

final signupUserViewModelProvider =
    StateNotifierProvider.autoDispose<SignupUserViewModel, SignupUserState>(
  (ref) => SignupUserViewModel(
    ref.read(signupUserUseCaseProvider),
  ),
);

class SignupUserViewModel extends StateNotifier<SignupUserState> {
  final SignupUserUseCase _signupUserUseCase;

  SignupUserViewModel(
    this._signupUserUseCase,
  ) : super(SignupUserState.initialState());

  Future<void> signupUser(SignupUserEntity user, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    final result = await _signupUserUseCase.signupUser(user);

    result.fold(
      (failure) {
        showSnackBar(message: failure.error, ref: ref);
        state = state.copyWith(isLoading: false);
      },
      (success) {
        state = state.copyWith(isLoading: false);
        showSnackBar(message: 'Registration Successful!', ref: ref);
        ref.read(navigationServiceProvider).goBack();
      },
    );
  }

  void rememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }
}
