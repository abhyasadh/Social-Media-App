import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yaallo/config/navigation/navigation_service.dart';
import 'package:yaallo/core/common/messages/show_snackbar.dart';
import 'package:yaallo/core/network/http_service.dart';
import 'package:yaallo/features/bottom_navigation/nav_view_model.dart';
import 'package:yaallo/features/brand_profile_page/presentation/brand_profile_state.dart';
import 'package:yaallo/features/brand_profile_page/presentation/brand_profile_view.dart';
import 'package:yaallo/features/brand_profile_page/presentation/brand_profile_view_model.dart';
import 'package:yaallo/features/home/presentation/home_state.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../config/themes/app_theme.dart';
import '../home_view_model.dart';
import 'custom_video_player.dart';
import 'image_slider.dart';

enum PostPage { home, profile }

class Post extends ConsumerStatefulWidget {
  final PostPage page;
  final int index;
  final bool repost;
  final String? repostId;
  final String? repostName;
  final String profilePicture;
  final String brandName;
  final String fullName;
  final String timeLeft;
  final String? title;
  final String postId;
  final String brid;
  final bool saved;

  const Post({
    required this.page,
    required this.index,
    this.repost = false,
    this.repostId,
    this.repostName,
    required this.profilePicture,
    required this.brandName,
    this.fullName = '',
    required this.timeLeft,
    this.title = '',
    required this.postId,
    required this.brid,
    this.saved = false,
    super.key,
  });

  @override
  ConsumerState createState() => _PostState();
}

class _PostState extends ConsumerState<Post> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _menuKey = GlobalKey();

  late bool _saved;
  late bool _isOwn;
  List<dynamic> _comments = [];
  bool _showComments = false;

  @override
  void initState() {
    super.initState();
    _saved = widget.saved;
    _isOwn = _checkIfOwnPost();
    _fetchComments();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool _checkIfOwnPost() {
    final userHash = ref.read(navViewModelProvider).userData!['hash'];
    return userHash == widget.brid || userHash == widget.repostId;
  }

  Future<void> _fetchComments() async {
    final httpService = ref.read(httpServiceProvider(ApiEndpoints.sharkURL));
    try {
      final response = await httpService.get('/post/cmnt_post_fetch/${widget.postId}/0');
      if (!mounted) return;
      setState(() {
        _comments = response.data[0]['data'][0]['comnt'];
      });
    } on DioException catch (e) {
      showSnackBar(ref: ref, message: e.toString(), error: true);
    }
  }

  Future<void> _postComment(String comment) async {
    if (comment.isEmpty) return;
    final httpService = ref.read(httpServiceProvider(ApiEndpoints.sharkURL));
    final user = ref.read(navViewModelProvider).userData!;
    final commentUrl =
        '/post/cmnt_post/${widget.postId}/${user['id']}/${user['profile_pic'] ?? user['profile_img']}.png/$comment/${user['fname'] ?? user['brname']}${user['lname'] != null ? '%20${user['lname']}' : ''}/3/0/0/0';
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
      _fetchComments();
      _controller.clear();
      await httpService.post('notifi/send', data: {
        'id': user['hash'],
        'uid': widget.brid,
        'pstId': widget.postId,
        'type': 1,
      });
    } on DioException catch (e) {
      showSnackBar(ref: ref, message: e.toString(), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.page == PostPage.home
        ? ref.watch(homeViewModelProvider)
        : ref.watch(brandProfileViewModelProvider(widget.brid));

    final posts = widget.page == PostPage.home
        ? (state as HomeState).posts
        : (state as BrandProfileState).posts;

    final post = posts[widget.index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        if (widget.repost) ...[
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text('${widget.repostName ?? 'Someone'} reposted this.'),
          ),
          Divider(color: Colors.grey.withOpacity(0.5)),
        ],
        _buildHeader(context),
        if (widget.title != null && widget.title!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 14, bottom: 14),
            child: Text(
              widget.title!,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        _buildMedia(post),
        _buildPostActions(post),
        if (_showComments) _buildCommentsSection(),
        _buildCommentInput(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              ref.read(navigationServiceProvider).navigateTo(page: BrandProfileView(hash: widget.brid));
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.profilePicture),
                  radius: 26,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        widget.brandName,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        widget.fullName,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.timeLeft}, ',
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        SvgPicture.asset(
                          'assets/images/public.svg',
                          width: 10,
                          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Fan',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedia(dynamic post) {
    if (post.media != null &&
        post.media!.isNotEmpty &&
        ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(
            post.media!.first.filename!.split('.').last.toLowerCase())) {
      return ImageSlider(post: post);
    } else if (post.urlimg != null &&
        ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(
            post.urlimg!.split('.').last.toLowerCase())) {
      return ImageSlider(post: post);
    } else {
      return CustomVideoPlayer(videoURL: post.media!.first.filename!);
    }
  }

  Widget _buildPostActions(dynamic post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 12),
            _buildIconWithCounter(
              icon: post.userId!.contains(ref.read(navViewModelProvider).userData?['id'].toString())
                  ? const Icon(Iconsax.heart5, color: AppTheme.primaryColor)
                  : const Icon(Iconsax.heart),
              count: post.userId?.length ?? 0,
              onTap: () {
                if (widget.page == PostPage.home) {
                  ref.read(homeViewModelProvider.notifier).likePost(widget.index, ref);
                } else {
                  ref.read(brandProfileViewModelProvider(widget.brid).notifier).likePost(widget.index, ref);
                }
              },
            ),
            _buildIconWithCounter(
              icon: const Icon(Iconsax.message_2),
              count: _comments.length,
              onTap: () {
                setState(() {
                  _showComments = !_showComments;
                });
              },
            ),
            _buildIcon(
              icon: const Icon(Iconsax.repeat),
              onTap: () async {
                await _repost(post);
              },
            ),
            _buildIcon(
              icon: const Icon(Iconsax.send_2),
              onTap: () async {
                await Share.share('https://yaallo.com/discover/${post.id}');
              },
            ),
          ],
        ),
        IconButton(
          key: _menuKey,
          onPressed: () {
            _showPopupMenu(context);
          },
          icon: const Icon(Iconsax.more),
        ),
      ],
    );
  }

  Future<void> _repost(dynamic post) async {
    final httpService = ref.read(httpServiceProvider(ApiEndpoints.sharkURL));
    final user = ref.read(navViewModelProvider).userData!;
    try {
      await httpService.post('repost/${post.id}/${user['hash']}');
      showSnackBar(ref: ref, message: 'You reposted a post!');
    } on DioException catch (e) {
      showSnackBar(ref: ref, message: e.toString(), error: true);
    }
  }

  Widget _buildIconWithCounter({required Widget icon, required int count, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          InkWell(
            onTap: onTap,
            child: icon,
          ),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon({required Widget icon, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
        child: icon,
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: _comments.isNotEmpty
          ? Column(
        children: _comments.map((comment) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              comment['name'],
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            subtitle: Text(comment['cmt']),
            trailing: Text(_formatTimeDifference(comment['date'])),
          );
        }).toList(),
      )
          : const Text('No comments yet.'),
    );
  }

  Widget _buildCommentInput() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14, bottom: 22, top: 14),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 62,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                cursorColor: AppTheme.primaryColor,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  hintText: 'Add a comment...',
                  contentPadding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppTheme.primaryColor),
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppTheme.errorColor),
                      borderRadius: BorderRadius.circular(10)),
                ),
                style: const TextStyle(fontSize: 10),
                controller: _controller,
                focusNode: _focusNode,
                onTapOutside: (e) {
                  _focusNode.unfocus();
                },
                validator: (value) {
                  return null;
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
            onPressed: () {
              _postComment(_controller.text);
            },
            icon: const Icon(
              Iconsax.arrow_right_1,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  void _showPopupMenu(BuildContext context) async {
    final RenderBox renderBox = _menuKey.currentContext?.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + size.height,
        position.dx + size.width,
        position.dy,
      ),
      items: [
        if (!_saved && !_isOwn) const PopupMenuItem<int>(value: 0, child: Text('Save Post')),
        const PopupMenuItem<int>(value: 1, child: Text('Hide Post')),
        if (!_isOwn) const PopupMenuItem<int>(value: 2, child: Text('Report Post')),
        if (_isOwn) const PopupMenuItem<int>(value: 3, child: Text('Delete Post')),
      ],
      elevation: 8.0,
    ).then((value) async {
      final dio = ref.read(httpServiceProvider(ApiEndpoints.sharkURL));
      final user = ref.read(navViewModelProvider).userData!;
      if (value == 0) {
        setState(() {
          _saved = true;
        });
        await dio.get('/post/save/${widget.postId}/${user['id']}/0');
        showSnackBar(ref: ref, message: 'Post saved!');
      } else if (value == 1) {
        ref.read(homeViewModelProvider.notifier).hidePost(widget.postId);
        await dio.get('/post/hide/${widget.postId}/${user['hash']}/0');
        showSnackBar(ref: ref, message: 'Post hidden!');
      } else if (value == 2) {
        await dio.get('/post/report/${widget.postId}/${user['id']}/0');
        showSnackBar(ref: ref, message: 'Reported the post!');
      } else if (value == 3) {
        ref.read(homeViewModelProvider.notifier).hidePost(widget.postId);
        await dio.get('/post/delete/${widget.postId}/0');
        showSnackBar(ref: ref, message: 'Deleted post!');
      }
    });
  }

  String _formatTimeDifference(int timestamp) {
    final now = DateTime.now();
    final messageTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = now.difference(messageTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }
}
