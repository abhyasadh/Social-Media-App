import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/constants/api_endpoints.dart';
import 'package:yaallo/core/storage/hive_service.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import 'package:yaallo/features/edit_profile/domain/brand_entity.dart';
import 'package:yaallo/features/edit_profile/domain/user_entity.dart';

import '../../../core/failure/failure.dart';
import '../../../core/network/http_service.dart';

final editProfileRemoteDataSourceProvider = Provider(
      (ref) => EditProfileDataSource(
    dio: ref.read(httpServiceProvider(ApiEndpoints.api1URL)),
        ref: ref,
  ),
);

class EditProfileDataSource {
  final Dio dio;
  final ProviderRef ref;

  EditProfileDataSource({required this.dio, required this.ref});

  Future<Either<Failure, bool>> updateUser(UserEntity user) async {
    try {
      String? imagePath;
      if (user.profilePic!=null) {
        Response imageUploadResponse = await dio.post(
        'https://media.yaallo.com/bkend/upload_media.php',
        data: FormData()..files.add(MapEntry('file', MultipartFile.fromFileSync(user.profilePic!.path))),
      );
        imagePath = jsonDecode(imageUploadResponse.data.toString())["filename"];
      }
      final clonedDio = Dio(dio.options.copyWith(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.read(navViewModelProvider).userData!['accessToken']}',
        },
      ));
      Response response = await clonedDio.post(
        ApiEndpoints.updateUser,
        data: {
          "fname": user.fName,
          "lname": user.lName,
          "info": user.info,
          "profile_pic": imagePath ?? ref.read(navViewModelProvider).userData!['profile_pic'],
        },
      );

      if (response.statusCode == 201) {
        var newData = response.data['user'];
        newData['type'] = ref.read(navViewModelProvider).userData!['type'];
        newData['accessToken'] = ref.read(navViewModelProvider).userData!['accessToken'];

        await ref.read(hiveServiceProvider).setData(userData: newData);
        ref.read(navViewModelProvider.notifier).updateUser(data: newData);

        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> updateBrand(BrandEntity brand) async {
    try {
      String? imagePath;
      if (brand.profileImg!=null) {
        Response imageUploadResponse = await dio.post(
        'https://media.yaallo.com/bkend/upload_media.php',
        data: FormData()..files.add(MapEntry('file', MultipartFile.fromFileSync(brand.profileImg!.path))),
      );
        imagePath = jsonDecode(imageUploadResponse.data.toString())["filename"];
      }
      final clonedDio = Dio(dio.options.copyWith(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.read(navViewModelProvider).userData!['accessToken']}',
        },
      ));
      Response response = await clonedDio.post(
        ApiEndpoints.updateUser,
        data: {
          'address': brand.address ?? '',
          'brname': brand.brname ?? '',
          'cate': brand.cate ?? '',
          'fname': brand.fname ?? '',
          'info': brand.info ?? '',
          'lname': null,
          'opening': "----",
          'profile_img': imagePath ?? ref.read(navViewModelProvider).userData!['profile_img'],
          'profile_poster': ref.read(navViewModelProvider).userData!['profile_poster'],
          'tel': brand.tel ?? '',
          'web': brand.web ?? '',
        },
      );

      if (response.statusCode == 201) {
        var newData = response.data[ref.read(navViewModelProvider).userData!['type']];
        newData['type'] = ref.read(navViewModelProvider).userData!['type'];
        newData['accessToken'] = ref.read(navViewModelProvider).userData!['accessToken'];

        await ref.read(hiveServiceProvider).setData(userData: newData);
        ref.read(navViewModelProvider.notifier).updateUser(data: newData);

        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    } catch (e){
      return Left(
        Failure(
          error: e.toString(),
          statusCode: '0',
        ),
      );
    }
  }
}
