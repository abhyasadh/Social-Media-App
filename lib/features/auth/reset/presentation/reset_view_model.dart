import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/routes/app_routes.dart';
import 'package:yaallo/core/common/messages/show_snackbar.dart';
import 'package:yaallo/features/auth/reset/domain/usecase/reset_usecase.dart';
import '../../../../config/navigation/navigation_service.dart';
import 'new_password.dart';
import 'reset_state.dart';

final resetViewModelProvider =
StateNotifierProvider.autoDispose<ResetViewModel, ResetState>(
      (ref) => ResetViewModel(),
);

class ResetViewModel extends StateNotifier<ResetState> {

  ResetViewModel() : super(ResetState.initialState());

  int otp = 0;

  Future<bool> sendOtp(String email, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(resetUseCaseProvider).sendOTP(email);
    result.fold(
          (l) {
            state = state.copyWith(isLoading: false);
            showSnackBar(ref: ref, message: 'Something went wrong!', error: true);
            return false;
          },
          (r) {
            state = state.copyWith(isLoading: false);
            otp = r;
            showSnackBar(ref: ref, message: 'OTP sent to your email!');
            ref.read(navigationServiceProvider).navigateTo(page: NewPassword(email: email,));
            return true;
          },
    );
    return false;
  }

  Future<bool> resetPassword(String otp, String email, String password, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    if (int.parse(otp)==this.otp) {
      final result =
          await ref.read(resetUseCaseProvider).resetPassword(email, password);

      result.fold(
            (l) {
          state = state.copyWith(isLoading: false);
          showSnackBar(ref: ref, message: 'Something went wrong!', error: true);
          return false;
        },
            (r) {
          state = state.copyWith(isLoading: false);
          showSnackBar(ref: ref, message: 'Password reset successfully!');
          ref.read(navigationServiceProvider).navigateTo(routeName: AppRoutes.loginRoute);
          return true;
        },
      );
      return false;
    }
    else{
      state = state.copyWith(isLoading: false);
      showSnackBar(ref: ref, message: 'Invalid Code!', error: true);
      return false;
    }
  }
}
