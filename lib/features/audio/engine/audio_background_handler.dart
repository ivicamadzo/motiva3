import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

// Го импортираме синглтонот за да имаме пристап до контролерот
import '../core/audio_singleton.dart';

class AudioBackgroundHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player;

  AudioBackgroundHandler(this._player) {
    // Слушај промени во плеерот и известувај го оперативниот систем
    _player.playbackEventStream.listen(_broadcastState);
  }

  // Освежување на состојбата (Play, Pause, Buffering) кон системот
  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
          // Овие две беа клучни за системот да ги регистрира кликовите:
          MediaAction.skipToNext,
          MediaAction.skipToPrevious,
        },
        androidCompactActionIndices: const [
          0,
          1,
          3,
        ], // Кои копчиња да се гледаат во мал приказ
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,
      ),
    );
  }

  // Функција за ажурирање на метаподатоците на заклучен екран (наслов, слика)
  @override
  Future<void> updateMediaItem(MediaItem item) async {
    mediaItem.add(item);
  }

  // ==========================================
  // Поврзување на системските копчиња со плеерот
  // ==========================================

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  // ==========================================
  // ПОВРЗУВАЊЕ СО AUDIO CONTROLLER
  // ==========================================

  @override
  Future<void> skipToNext() async {
    // Кога корисникот ќе кликне Next на Lock Screen, повикај ја логиката од контролерот
    await AudioSingleton.controller.next();
  }

  @override
  Future<void> skipToPrevious() async {
    // Кога корисникот ќе кликне Previous на Lock Screen, повикај ја логиката од контролерот
    await AudioSingleton.controller.previous();
  }
}
