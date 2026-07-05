import '../engine/audio_engine.dart';
import 'audio_controller.dart';

class AudioSingleton {
  static final AudioEngine _engine = AudioEngine();
  static final AudioController controller = AudioController(_engine);

  AudioSingleton._();

  static Future<void> init() async {
    await _engine.init();
  }

  // ДОДАДЕНО: За чистење при гасење на апликацијата
  static void dispose() {
    controller.dispose();
  }
}
