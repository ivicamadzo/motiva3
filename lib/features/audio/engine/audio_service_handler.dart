import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'audio_background_handler.dart';

class AudioServiceHandler {
  static late AudioBackgroundHandler _handler;

  static Future<AudioBackgroundHandler> init(AudioPlayer player) async {
    _handler = await AudioService.init(
      builder: () => AudioBackgroundHandler(player),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.motiva3.channel.audio',
        androidNotificationChannelName: 'Motiva Audio Therapy',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause:
            true, // Ја трга нотификацијата ако корисникот паузира и ја тргне апликацијата
        androidShowNotificationBadge: true,
      ),
    );
    return _handler;
  }

  static AudioBackgroundHandler get handler => _handler;
}
