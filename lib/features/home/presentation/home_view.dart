import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/config/shimmers/post_shimmer.dart';
import 'package:yaallo/config/themes/app_theme.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import 'package:yaallo/features/home/presentation/widgets/post.dart';
import 'package:yaallo/features/new_post/presentation/new_post_view.dart';

import 'home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.extentAfter < 500) {
          ref.read(homeViewModelProvider.notifier).getPosts();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset('assets/images/logo-black.png'),
          ),
          elevation: 5,
          shadowColor: AppTheme.primaryColor.withOpacity(0.2),
          leadingWidth: 160,
        ),
        body: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            _scrollController.dispose();
            _scrollController = ScrollController();
            ref.read(homeViewModelProvider.notifier).resetState();
          },
          child: homeState.isLoading && homeState.posts.isEmpty
              ? const PostShimmer(count: 3)
              : ListView.separated(
            controller: _scrollController,
            itemCount: homeState.posts.length + 1,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index < homeState.posts.length) {
                final post = homeState.posts[index];
                final userHash = ref.read(navViewModelProvider).userData!['hash'].toString();
                final isHidden = post.hide!.contains(userHash);
                if (!isHidden) {
                  return Post(
                    page: PostPage.home,
                    repost: post.repost ?? false,
                    repostId: post.reposterId,
                    repostName: '${post.reposterData?[0]['fname'] ?? ''} ${post.reposterData?[0]['lname'] ?? ''}',
                    index: index,
                    profilePicture: 'https://media.yaallo.com/upload/img/${post.data?[0]['pp']}',
                    brandName: post.data?[0]['brname'],
                    fullName: '${post.data?[0]['fname'] ?? ''} ${post.data?[0]['lname'] ?? ''}',
                    timeLeft: formattedDate(post.time),
                    title: post.title!,
                    postId: post.id!,
                    brid: post.brid!,
                    saved: post.saved!.contains(ref.read(navViewModelProvider).userData!['id'].toString()),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              } else {
                return const PostShimmer(count: 1);
              }
            },
            separatorBuilder: (context, index) {
              final post = homeState.posts[index];
              final userHash = ref.read(navViewModelProvider).userData!['hash'].toString();
              final isHidden = post.hide!.contains(userHash);
              return isHidden ? const SizedBox.shrink() : Container(
                height: 6,
                width: MediaQuery.of(context).size.width,
                color: AppTheme.primaryColor.withOpacity(0.2),
              );
            },
          ),
        ),
        floatingActionButton: ref.read(navViewModelProvider).userData!['type'] == 'brand' ? FloatingActionButton(
          onPressed: () {
            ref.read(navigationServiceProvider).navigateTo(page: const NewPostView());
          },
          backgroundColor: AppTheme.primaryColor,
          child: const Icon(Iconsax.add, color: Colors.white),
        ) : null,
      ),
    );
  }

  String formattedDate(DateTime? time) {
    if (time == null) return '';
    DateTime now = DateTime.now();
    Duration difference = now.difference(time);
    return formatDuration(difference);
  }

  String formatDuration(Duration duration) {
    if (duration.inSeconds < 60) {
      return '${duration.inSeconds}s';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes}m';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}h';
    } else if (duration.inDays < 30) {
      return '${duration.inDays}d';
    } else if (duration.inDays < 365) {
      return '${duration.inDays ~/ 30}m';
    } else {
      return '${duration.inDays ~/ 365}y';
    }
  }
}
