import 'package:just_audio/just_audio.dart';
import '../data/audio_item.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(AudioItem item) async {
    try {
      await _player.setAsset(item.asset);
      await _player.play();
    } catch (e) {
      print("Audio error: $e");
    }
  }

  Future<void> stop() async {
    await _player.stop();
  }

  void dispose() {
    _player.dispose();
  }
}
