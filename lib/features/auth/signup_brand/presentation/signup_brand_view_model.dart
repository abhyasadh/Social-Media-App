import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/navigation/navigation_service.dart';
import '../../../../core/common/messages/show_snackbar.dart';
import '../domain/entity/signup_brand_entity.dart';
import '../domain/usecases/signup_brand_usecase.dart';
import 'signup_brand_state.dart';

final signupBrandViewModelProvider =
    StateNotifierProvider.autoDispose<SignupBrandViewModel, SignupBrandState>(
  (ref) => SignupBrandViewModel(ref, ref.read(signupBrandUseCaseProvider)),
);

class SignupBrandViewModel extends StateNotifier<SignupBrandState> {
  final AutoDisposeStateNotifierProviderRef<SignupBrandViewModel, SignupBrandState> ref;
  final SignupBrandUseCase _signupBrandUseCase;

  SignupBrandViewModel(this.ref, this._signupBrandUseCase) : super(SignupBrandState.initialState());

  void rememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  Future<void> signupBrand(SignupBrandEntity brand, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    final result = await _signupBrandUseCase.signupBrand(brand);

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
}
