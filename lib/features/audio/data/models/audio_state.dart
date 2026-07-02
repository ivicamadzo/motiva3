import 'audio_item.dart';
import 'audio_category.dart';

class AudioState {
  final AudioItem? currentTrack;
  final AudioCategory? currentCategory;
  final bool isPlaying;

  AudioState({
    required this.currentTrack,
    required this.currentCategory,
    required this.isPlaying,
  });

  AudioState copyWith({
    AudioItem? currentTrack,
    AudioCategory? currentCategory,
    bool? isPlaying,
  }) {
    return AudioState(
      currentTrack: currentTrack ?? this.currentTrack,
      currentCategory: currentCategory ?? this.currentCategory,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
