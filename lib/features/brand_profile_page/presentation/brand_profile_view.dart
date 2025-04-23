import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yaallo/core/common/widgets/custom_button.dart';

import '../../../config/shimmers/post_shimmer.dart';
import '../../../config/themes/app_theme.dart';
import '../../home/presentation/widgets/post.dart';
import 'brand_profile_view_model.dart';

class BrandProfileView extends ConsumerStatefulWidget {
  final String hash;

  const BrandProfileView({super.key, required this.hash});

  @override
  ConsumerState createState() => _BrandProfileViewState();
}

class _BrandProfileViewState extends ConsumerState<BrandProfileView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(brandProfileViewModelProvider(widget.hash));
    return SafeArea(
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
            ref.read(brandProfileViewModelProvider(widget.hash).notifier).getPosts();
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 40,
          ),
          body: RefreshIndicator(
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
              ref.read(brandProfileViewModelProvider(widget.hash).notifier).resetState();
            },
            child: state.isLoading && state.posts.isEmpty
                ? const PostShimmer(count: 3)
                : ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length + 2,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildProfileHeader(state);
                }
                if (index <= state.posts.length) {
                  final postIndex = index - 1;
                  final post = state.posts[postIndex];
                  return Post(
                    page: PostPage.profile,
                    index: postIndex,
                    profilePicture: 'https://media.yaallo.com/upload/img/${post.data?[0]['pp']}',
                    brandName: post.data?[0]['brname'],
                    fullName: '${post.data?[0]['fname'] ?? ''} ${post.data?[0]['lname'] ?? ''}',
                    timeLeft: formattedDate(post.time),
                    title: post.title!,
                    postId: post.id!,
                    brid: post.brid!,
                  );
                }
                return const PostShimmer(count: 1);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(state) {
    return Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://media.yaallo.com/upload/img/${state.brand?.profilePoster}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const SizedBox(width: 14),
            CircleAvatar(
              backgroundImage: NetworkImage('https://media.yaallo.com/upload/img/${state.brand?.profileImg}'),
              radius: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.brand?.brname ?? '',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: CustomButton(
            onPressed: () {},
            child: Text(
              'Message',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        const Divider(
          color: AppTheme.primaryColor,
          endIndent: 14,
          indent: 14,
          height: 36,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            state.brand?.info ?? '',
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 14),
        _buildProfileDetailRow(Iconsax.global, state.brand?.web),
        _buildProfileDetailRow(Iconsax.location, state.brand?.address),
        _buildProfileDetailRow(Iconsax.sms, state.brand?.email),
        const SizedBox(height: 14),
      ],
    );
  }

  Widget _buildProfileDetailRow(IconData icon, String? text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 10),
          Flexible(child: Text(text ?? '', style: const TextStyle(fontSize: 12))),
        ],
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
