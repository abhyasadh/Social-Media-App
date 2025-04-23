import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/constants/api_endpoints.dart';
import 'package:yaallo/core/network/http_service.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import 'package:yaallo/features/home/domain/home_usecase.dart';

import '../domain/entity/post_entity.dart';
import 'home_state.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) => HomeViewModel(
          ref.read(homeUseCaseProvider),
        ));

class HomeViewModel extends StateNotifier<HomeState> {
  final HomeUseCase _homeUseCase;

  HomeViewModel(
    this._homeUseCase,
  ) : super(
          HomeState.initial(),
        ) {
    getPosts();
  }

  void scrollToTop(ScrollController controller) {
    controller.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  Future<void> resetState() async {
    state = HomeState.initial();
    getPosts();
  }

  Future<void> getPosts() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final posts = currentState.posts;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      final result = await _homeUseCase.getPosts(page);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true, isLoading: false);
          } else {
            state = state.copyWith(
              posts: [...posts, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }

  void likePost(int index, WidgetRef ref) {
    final posts = List<PostEntity>.from(state.posts);
    final post = posts[index];
    final user = ref.read(navViewModelProvider).userData!;
    final httpService =
        ref.read(httpServiceProvider(ApiEndpoints.sharkURL));

    if (post.userId!.contains(user['id'].toString())) {
      post.userId!.remove(user['id'].toString());
      try {
        httpService.get(
            'post/dislike/${post.id}/${user['id']}/${user['hash']}/${post.brid}/0');
        httpService.post('notifi/del', data: {
          'id': user['hash'],
          'uid': post.brid,
          'pstId': post.id,
          'type': 1
        });
      } catch (e) {
        post.userId!.add(user['id'].toString());
      }
    } else {
      post.userId!.add(user['id'].toString());
      try {
        httpService.get(
            'post/like/${post.id}/${user['id']}/${user['hash']}/${post.brid}/0');
        httpService.post('notifi/send', data: {
          'id': user['hash'],
          'uid': post.brid,
          'pstId': post.id,
          'type': 1
        });
      } catch (e) {
        post.userId!.remove(user['id'].toString());
      }
    }
    posts[index] = post;
    state = state.copyWith(posts: posts);
  }

  void hidePost(String postId){
    final posts = List<PostEntity>.from(state.posts);
    posts.remove(posts.firstWhere((element) => element.id == postId));
    state = state.copyWith(posts: posts);
  }

  Future<void> fetchComments(String postId) async {
    final httpService = Dio();
    try {
      final response = await httpService.get('${ApiEndpoints.sharkURL}/post/cmnt_post_fetch/$postId/0');
      final comments = response.data[0]['data'][0]['comnt'];
      state = state.copyWith(comments: comments);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> postComment(String postId, String comment, Map<String, dynamic> user) async {
    if (comment.isEmpty) return;
    final httpService = Dio();
    final commentUrl =
        '${ApiEndpoints.sharkURL}/post/cmnt_post/$postId/${user['id']}/${user['profile_pic'] ?? user['profile_img']}.png/$comment/${user['fname'] ?? user['brname']}${user['lname'] != null ? '%20${user['lname']}' : ''}/3/0/0/0';
    final token = user['accessToken'];

    try {
      await httpService.get(
        commentUrl,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          contentType: 'application/x-www-form-urlencoded',
        ),
      );
      await fetchComments(postId);
    } catch (e) {
      // Handle error
    }
  }
}
