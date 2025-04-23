import 'package:yaallo/features/home/domain/entity/post_entity.dart';

class HomeState {
  final List<PostEntity> posts;
  final List<Map> comments;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  HomeState({
    required this.posts,
    required this.comments,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });

  factory HomeState.initial() {
    return HomeState(
      posts: [],
      comments: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
    );
  }

  HomeState copyWith({
    List<PostEntity>? posts,
    List<Map>? comments,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return HomeState(
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
