import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import 'package:yaallo/features/home/presentation/home_view_model.dart';
import '../../../config/constants/api_endpoints.dart';
import '../../../core/common/messages/show_snackbar.dart';
import '../../../core/network/http_service.dart';
import 'new_post_state.dart';

final newPostViewModelProvider =
    StateNotifierProvider.autoDispose<NewPostViewModel, NewPostState>(
  (ref) => NewPostViewModel(),
);

class NewPostViewModel extends StateNotifier<NewPostState> {
  NewPostViewModel() : super(NewPostState.initialState());

  void addImage(File image, WidgetRef ref) async {
    final updatedImages = List<File>.from(state.images)..add(image);

    final dio = ref.read(httpServiceProvider(ApiEndpoints.api1URL));
    Response imageUploadResponse = await dio.post(
      'https://media.yaallo.com/bkend/upload_media.php',
      data: FormData()..files.add(MapEntry('file', MultipartFile.fromFileSync(image.path))),
    );
    final imagePath = imageUploadResponse.data.toString();
    final updatedImageUrls = List<String>.from(state.imageUploads)..add(imagePath);

    state = state.copyWith(images: updatedImages, imageUploads: updatedImageUrls);
  }

  void removeImage(File image) {
    final updatedImages = List<File>.from(state.images)..remove(image);
    state = state.copyWith(images: updatedImages);
  }

  Future<void> postNewPost({
    required String title,
    required String content,
    required WidgetRef ref,
  }) async {
    if (state.images.isEmpty) {
      throw Exception('At least one image is required');
    }

    final dio = ref.read(httpServiceProvider(ApiEndpoints.sharkURL));

    try {
      final data = {
        'title': title,
        'content': content,
        'type': 'posts',
        'hasurl': false,
        'media': state.imageUploads,
        'id': ref.read(navViewModelProvider).userData!['hash'],
      };

      final token = ref.read(navViewModelProvider).userData!['accessToken'];

      final response = await dio.post(
        'post/insert',
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          contentType: 'application/x-www-form-urlencoded',
        ),
      );

      // Handle the response
      if (response.statusCode == 200) {
        showSnackBar(ref: ref, message: 'Post created successfully!');
        ref.read(homeViewModelProvider.notifier).getPosts();
        ref.read(navigationServiceProvider).goBack();
      } else {
        showSnackBar(ref: ref, message: 'Failed to create post');
      }
    } catch (e) {
      showSnackBar(ref: ref, message: 'An error occurred');
    }
  }
}
