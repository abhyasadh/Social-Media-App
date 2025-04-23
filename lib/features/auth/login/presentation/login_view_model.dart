import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/config/routes/app_routes.dart';
import 'package:yaallo/core/common/messages/show_snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/core/storage/hive_service.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import '../domain/usecase/login_usecase.dart';
import 'login_state.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>(
  (ref) => LoginViewModel(ref.read(loginUseCaseProvider), ref),
);

class LoginViewModel extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;
  final AutoDisposeStateNotifierProviderRef<LoginViewModel, LoginState> ref;

  LoginViewModel(this._loginUseCase, this.ref)
      : super(LoginState.initialState());

  void rememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  Future<void> login(String phone, String password, WidgetRef ref) async {
    state = state.copyWith(isLoading: true);
    final result = await _loginUseCase.login(phone, password);
    result.fold(
      (failure) {
        showSnackBar(message: failure.error, error: true, ref: ref);
      },
      (data) async {
        final hive = ref.read(hiveServiceProvider);
        try {
          await hive.setData(userData: data);
          ref.read(navViewModelProvider.notifier).updateUser(data: data);
          ref.read(navigationServiceProvider).replaceWith(routeName: AppRoutes.homeRoute);
        } catch (e) {
          //
        }
      },
    );
    ref.read(navViewModelProvider.notifier).changeIndex(0);
    state = state.copyWith(isLoading: false);
  }
}
