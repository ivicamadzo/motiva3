import '../models/audio_item.dart';

final List<AudioItem> panicPlaylist = [
  // Fallback to the bundled welcome asset for environments
  // where dedicated panic audio files are not present.
  AudioItem(
    title: "Panic (demo)",
    assetPath: "assets/audio/welcome.mp3",
    artwork: "assets/images/welcome.jpg",
  ),
];
