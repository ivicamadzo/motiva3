import 'package:just_audio/just_audio.dart';

import 'audio_controller.dart';
import '../services/audio_service.dart';

class AudioSingleton {
  static final AudioPlayer _player = AudioPlayer();

  static final AudioService service = AudioService(_player);

  static final AudioController controller = AudioController();
}
