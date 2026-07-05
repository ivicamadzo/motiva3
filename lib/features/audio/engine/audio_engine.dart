import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import '../data/models/audio_item.dart';
import 'audio_service_handler.dart';
import 'audio_background_handler.dart';
import 'audio_session.dart'; // Го додаваме овој импорт

class AudioEngine {
  final AudioPlayer _player = AudioPlayer();
  late final AudioBackgroundHandler _backgroundHandler;

  Future<void> init() async {
    _backgroundHandler = await AudioServiceHandler.init(_player);

    // Повикуваме иницијализација на сесијата од посебниот фајл
    await AppAudioSession.init();
  }

  Future<Duration?> loadAsset(AudioItem item) async {
    try {
      await _backgroundHandler.updateMediaItem(
        MediaItem(
          id: item.assetPath,
          title: item.title,
          artist: 'Motiva',
          // artUri: Uri.parse('asset:///${item.artwork}'), // Избриши ја оваа линија
        ),
      );

      return await _player.setAsset(item.assetPath);
    } catch (e) {
      print("Грешка при вчитување на аудио: $e");
      return null;
    }
  }

  // Овие методи ти недостигаа во класата за да комуницира контролерот
  Future<void> play() async => await _player.play();
  Future<void> pause() async => await _player.pause();
  Future<void> stop() async => await _player.stop();
  Future<void> seek(Duration position) async => await _player.seek(position);

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  void dispose() {
    _player.dispose();
  }
}
