import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants/api_endpoints.dart';
import '../../../core/network/http_service.dart';
import '../../bottom_navigation/nav_view_model.dart';
import '../../home/domain/entity/post_entity.dart';
import '../domain/brand_profile_usecase.dart';
import 'brand_profile_state.dart';

final brandProfileViewModelProvider =
StateNotifierProvider.family.autoDispose<BrandProfileViewModel, BrandProfileState, String>((ref, hash) =>
    BrandProfileViewModel(
      ref.read(brandProfileUseCaseProvider),
      hash
    ));

class BrandProfileViewModel extends StateNotifier<BrandProfileState> {
  final BrandProfileUseCase _brandProfileUseCase;
  final String hash;

  BrandProfileViewModel(this._brandProfileUseCase, this.hash) : super(BrandProfileState.initial()){
    getBrandProfile(hash);
    getPosts();
  }

  Future getBrandProfile(String hash) async {
    state = state.copyWith(isLoading: true);
    final result = await _brandProfileUseCase.getBrandProfile(hash);
    result.fold((failure) => state = state.copyWith(isLoading: false), (data) {
      state = state.copyWith(
        brand: data,
        isLoading: false,
      );
    });
  }

  Future<void> getPosts() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final posts = currentState.posts;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      final result = await _brandProfileUseCase.getPosts(page, hash);
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
    final httpService = ref.read(httpServiceProvider(ApiEndpoints.sharkURL));

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

  Future<void> resetState() async {
    state = BrandProfileState.initial();
    getBrandProfile(hash);
    getPosts();
  }
}
