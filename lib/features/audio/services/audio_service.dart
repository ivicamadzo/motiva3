import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _player;

  AudioService(this._player);

  AudioPlayer get player => _player;

  Future<void> play(String assetPath) async {
    await _player.setAsset(assetPath);
    await _player.play();
  }

  Future<void> pause() async => _player.pause();

  Future<void> resume() async => _player.play();

  Future<void> stop() async => _player.stop();

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  void dispose() {
    _player.dispose();
  }
}
