import 'package:audio_session/audio_session.dart';

class AppAudioSession {
  static Future<void> init() async {
    final session = await AudioSession.instance;

    await session.configure(const AudioSessionConfiguration.music());
  }

  static Future<void> activate() async {
    final session = await AudioSession.instance;
    await session.setActive(true);
  }

  static Future<void> deactivate() async {
    final session = await AudioSession.instance;
    await session.setActive(false);
  }
}
