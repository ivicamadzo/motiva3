import '../models/audio_item.dart';

final List<AudioItem> panicPlaylist = [
  // Fallback to the bundled welcome asset for environments
  // where dedicated panic audio files are not present.
  AudioItem(
    title: "Панични Напади Интродукција",
    assetPath: "assets/audio/panicninapadivideo1.mp3",
    artwork: "assets/images/panicninapadiimage1.jpg",
  ),
];
