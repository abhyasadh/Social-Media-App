import 'package:yaallo/features/brand_profile_page/domain/user_entity.dart';
import 'package:yaallo/features/home/domain/entity/post_entity.dart';

class BrandProfileState {
  final UserEntity? brand;
  final List<PostEntity> posts;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  BrandProfileState({
    required this.brand,
    required this.posts,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });

  factory BrandProfileState.initial() {
    return BrandProfileState(
      brand: null,
      posts: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
    );
  }

  BrandProfileState copyWith({
    UserEntity? brand,
    List<PostEntity>? posts,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return BrandProfileState(
      brand: brand ?? this.brand,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
