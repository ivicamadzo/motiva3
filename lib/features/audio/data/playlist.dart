import 'models/audio_category.dart';
import 'models/audio_item.dart';

// Type alias
typedef Playlist = List<AudioItem>;

// All application playlists
final Map<AudioCategory, Playlist> appPlaylists = {
  AudioCategory.panic: [
    AudioItem(
      title: "1. Welcome",
      assetPath: "assets/audio/panic/welcome.mp3",
      artwork: "assets/images/panic/welcome.jpg",
    ),
    AudioItem(
      title: "2. What is panic attack",
      assetPath: "assets/audio/panic/02.mp3",
      artwork: "assets/images/panic/02.jpg",
    ),
    // ...останатите panic траки
  ],

  AudioCategory.overthinking: [
    // ...
  ],

  AudioCategory.rumination: [
    // ...
  ],

  AudioCategory.test: [
    // ...
  ],
};
