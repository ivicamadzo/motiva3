import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

import '../data/models/audio_item.dart';
import 'audio_service_handler.dart';
import 'audio_background_handler.dart';
import 'audio_session.dart';

class AudioEngine {
  final AudioPlayer _player = AudioPlayer();
  late final AudioBackgroundHandler _backgroundHandler;

  Future<void> init() async {
    _backgroundHandler = await AudioServiceHandler.init(_player);

    await AppAudioSession.init();
  }

  Future<Duration?> loadAsset(AudioItem item) async {
    try {
      final start = DateTime.now();

      print('🔵 LOAD START: ${item.title}');
      print('🔵 ASSET: ${item.assetPath}');

      await _backgroundHandler.updateMediaItem(
        MediaItem(id: item.assetPath, title: item.title, artist: 'Motiva'),
      );

      print(
        '🟡 MEDIA ITEM DONE: '
        '${DateTime.now().difference(start).inMilliseconds} ms',
      );

      final result = await _player.setAsset(item.assetPath);

      print(
        '🟢 SET ASSET DONE: '
        '${DateTime.now().difference(start).inMilliseconds} ms',
      );

      return result;
    } catch (e) {
      print("Грешка при вчитување на аудио: $e");
      return null;
    }
  }

  // ─────────────────────────────────────────
  // PLAYER CONTROLS
  // ─────────────────────────────────────────

  Future<void> play() async => await _player.play();

  Future<void> pause() async => await _player.pause();

  Future<void> stop() async => await _player.stop();

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  // ─────────────────────────────────────────
  // STREAMS
  // ─────────────────────────────────────────

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<Duration?> get durationStream => _player.durationStream;

  // ─────────────────────────────────────────
  // CURRENT POSITION / DURATION
  // ─────────────────────────────────────────

  Duration get currentPosition => _player.position;

  Duration get currentDuration => _player.duration ?? Duration.zero;

  // ─────────────────────────────────────────
  // DISPOSE
  // ─────────────────────────────────────────

  void dispose() {
    _player.dispose();
  }
}
