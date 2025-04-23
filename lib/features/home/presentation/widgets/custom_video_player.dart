import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaallo/config/themes/app_theme.dart';

class CustomVideoPlayer extends ConsumerStatefulWidget {
  final String videoURL;

  const CustomVideoPlayer({super.key, required this.videoURL});

  @override
  ConsumerState<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends ConsumerState<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isBuffering = true;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse('https://media.yaallo.com/upload/vid/${widget.videoURL}'));
    _controller.addListener(() {
      setState(() {
        _isBuffering = _controller.value.isBuffering;
      });
    });
    try {
      await _controller.initialize();
      _controller.play();
    } catch (e) {
      // Handle the error appropriately here, such as logging or showing a message
      // print('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('video-player-${widget.videoURL}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction <= 10 && mounted) {
          _controller.pause();
        } else {
          _controller.play();
        }
      },
      child: _controller.value.isInitialized
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_controller),
            if (_isBuffering)
              const CircularProgressIndicator(),
          ],
        ),
      )
          : const SizedBox(height: 200, child: Center(child: CircularProgressIndicator(color: AppTheme.primaryColor,))),
    );
  }
}
