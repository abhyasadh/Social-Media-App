import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/constants/api_endpoints.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/core/common/messages/show_snackbar.dart';
import 'package:yaallo/core/network/http_service.dart';
import 'package:yaallo/features/edit_profile/domain/brand_entity.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/storage/hive_service.dart';
import '../../bottom_navigation/nav_view_model.dart';
import '../domain/edit_profile_usecase.dart';
import '../domain/user_entity.dart';
import 'edit_profile_state.dart';

final editProfileViewModelProvider =
    StateNotifierProvider.autoDispose<EditProfileViewModel, EditProfileState>((ref) {
  return EditProfileViewModel(ref, ref.read(editProfileUseCaseProvider));
});

class EditProfileViewModel extends StateNotifier<EditProfileState> {
  final StateNotifierProviderRef ref;
  final EditProfileUseCase editProfileUseCase;

  EditProfileViewModel(this.ref, this.editProfileUseCase)
      : super(EditProfileState.initialState());

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(
      imageName: 'Image',
    );
  }

  Future<void> updateUser({
    required Either<File?, String?>? image,
    required String firstName,
    required String lastName,
    required String info,
    required WidgetRef ref,
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await editProfileUseCase.updateUser(
      UserEntity(
        fName: firstName,
        lName: lastName,
        info: info,
        profilePic: image?.fold(
          (l) {
            return l;
          },
          (r) {
            return null;
          },
        ),
      ),
    );
    result.fold(
      (failure) {
        showSnackBar(ref: ref, message: failure.error);
        return state = state.copyWith(isLoading: false);
      },
      (data) {
        showSnackBar(ref: ref, message: 'Profile Updated Successfully!');
        ref.read(navigationServiceProvider).goBack();
      },
    );

    state = state.copyWith(isLoading: false);
  }

  Future<void> updateBrand({
    required Either<File?, String?>? image,
    required String brandName,
    required String firstName,
    required String title,
    required String info,
    required String website,
    required String telephone,
    required String address,
    required WidgetRef ref,
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await editProfileUseCase.updateBrand(
      BrandEntity(
        brname: brandName,
        fname: firstName,
        cate: title,
        info: info,
        web: website,
        tel: telephone,
        address: address,
        opening: '',
        profileImg: image?.fold(
              (l) => l,
              (r) => null,
        ),
        profilePoster: '',
      ),
    );

    result.fold(
          (failure) {
        showSnackBar(ref: ref, message: failure.error);
        return state = state.copyWith(isLoading: false);
      },
          (data) {
        showSnackBar(ref: ref, message: 'Profile Updated Successfully!');
        ref.read(navigationServiceProvider).goBack();
      },
    );

    state = state.copyWith(isLoading: false);
  }

  Future<void> deleteAccount(WidgetRef ref) async {
    final user = ref.read(navViewModelProvider).userData!;
    Dio dio = ref.read(httpServiceProvider(ApiEndpoints.api1URL));

    try {
      ref.read(hiveServiceProvider).removeData();
      Navigator.of(
              ref.read(navigationServiceProvider).navigatorKey.currentContext!)
          .pushNamedAndRemoveUntil(AppRoutes.loginRoute, (_) {
        return false;
      });
      showSnackBar(ref: ref, message: 'Account deleted!');
      await dio.post(
        'https://api1.yaallo.com/user/delete-account/${user['id']}',
        data: {'type': user['type']},
      );
    } on DioException catch (e) {
      showSnackBar(ref: ref, message: e.toString(), error: true);
    }
  }
}
