import 'audio_singleton.dart'; //zasega prazen

class AudioController {
  final _audio = AudioSingleton.instance;

  void playTest() {
    _audio.playAsset("assets/panic/1.mp3");
  }

  void stop() {
    _audio.stop();
  }
}
