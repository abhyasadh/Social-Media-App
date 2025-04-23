import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerNotifier extends StateNotifier<Map<String, VideoPlayerController>> {
  VideoPlayerNotifier() : super({});

  void setController(String key, VideoPlayerController controller) {
    state[key] = controller;
    controller.play();
    state = {...state}; // Trigger state update
  }

  void disposeController(String key) {
    if (state.containsKey(key)) {
      state[key]!.dispose();
      state.remove(key);
      state = {...state}; // Trigger state update
    }
  }

  void pauseAllExcept(String key) {
    for (var entry in state.entries) {
      if (entry.key != key) {
        entry.value.pause();
      }
    }
  }
}

final videoPlayerNotifierProvider =
StateNotifierProvider<VideoPlayerNotifier, Map<String, VideoPlayerController>>(
        (ref) => VideoPlayerNotifier());
