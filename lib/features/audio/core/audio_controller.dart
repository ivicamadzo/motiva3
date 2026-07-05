import 'dart:async';
import 'package:just_audio/just_audio.dart'; // За ProcessingState

import '../engine/audio_engine.dart';
import '../data/models/audio_item.dart';
import '../data/models/audio_category.dart';
import '../data/models/audio_state.dart';

import '../data/playlists/panic_playlist.dart';
import '../data/playlists/overthinking_playlist.dart';
import '../data/playlists/rumination_playlist.dart';
import '../data/playlists/test_playlist.dart';

class AudioController {
  final AudioEngine engine;

  // Оптимизирана мапа на плејлисти со што се елиминира потребата од гломазен switch
  final Map<AudioCategory, List<AudioItem>> _playlists = {
    AudioCategory.panic: panicPlaylist,
    AudioCategory.overthinking: overthinkingPlaylist,
    AudioCategory.rumination: ruminationPlaylist,
    AudioCategory.test: testPlaylist,
  };

  AudioController(this.engine) {
    _initAutoNext();
  }

  // =========================
  // INTERNAL STATE & STREAMS
  // =========================

  AudioCategory? _currentCategory;
  AudioItem? _currentTrack;
  List<AudioItem> _currentPlaylist = [];
  int _currentIndex = 0;

  // Чуваме само една последна состојба (nullable) - Единствен извор на вистина
  AudioState? _lastState;

  // Стрим контролер за емитување на состојбата во реално време
  final StreamController<AudioState> _stateStreamController =
      StreamController<AudioState>.broadcast();

  // Getter за UI компонентите кои ќе го слушаат стримот
  Stream<AudioState> get stateStream => _stateStreamController.stream;

  // Getter за моментална состојба (корисно за initialData во StreamBuilder)
  AudioState get currentState =>
      _lastState ??
      AudioState(currentTrack: null, currentCategory: null, isPlaying: false);

  // Стримови за аудио прогрес кои се пренасочуваат од AudioEngine
  Stream<Duration?> get durationStream => engine.durationStream;
  Stream<Duration> get positionStream => engine.positionStream;

  Future<void> seek(Duration position) async {
    await engine.seek(position);
  }

  // =========================
  // STATE UPDATE (SAFE)
  // =========================

  void _setState(AudioState Function(AudioState s) update) {
    final oldState =
        _lastState ??
        AudioState(currentTrack: null, currentCategory: null, isPlaying: false);
    final newState = update(oldState);

    _lastState = newState;
    _stateStreamController.add(newState);
  }

  // =========================
  // PLAY CATEGORY
  // =========================

  Future<void> playCategory(AudioCategory category) async {
    _currentCategory = category;
    _currentPlaylist = _playlists[category] ?? [];

    if (_currentPlaylist.isEmpty) return;

    _currentIndex = 0;
    await _playAtIndex(_currentIndex);
  }

  // =========================
  // CORE PLAY (IMPORTANT)
  // =========================

  Future<void> _playAtIndex(int index) async {
    if (index < 0 || index >= _currentPlaylist.length) return;

    _currentIndex = index;
    _currentTrack = _currentPlaylist[_currentIndex];

    final track = _currentTrack!;

    await engine.loadAsset(track);

    _setState(
      (s) => s.copyWith(
        currentTrack: track,
        currentCategory: _currentCategory,
        isPlaying: true,
      ),
    );

    await engine.play();
  }

  // =========================
  // SINGLE TRACK
  // =========================

  Future<void> playTrack(AudioItem item) async {
    _currentTrack = item;

    await engine.loadAsset(item);

    _setState((s) => s.copyWith(currentTrack: item, isPlaying: true));

    await engine.play();
  }

  // =========================
  // CONTROL
  // =========================

  Future<void> pause() async {
    await engine.pause();
    _setState((s) => s.copyWith(isPlaying: false));
  }

  Future<void> resume() async {
    await engine.play();
    _setState((s) => s.copyWith(isPlaying: true));
  }

  Future<void> stop() async {
    await engine.stop();

    _currentTrack = null;
    _currentPlaylist = [];
    _currentCategory = null;
    _currentIndex = 0;

    _setState(
      (s) => AudioState(
        currentTrack: null,
        currentCategory: null,
        isPlaying: false,
      ),
    );
  }

  // =========================
  // NEXT / PREVIOUS
  // =========================

  Future<void> next() async {
    if (_currentPlaylist.isEmpty) return;

    final nextIndex = _currentIndex + 1;

    if (nextIndex >= _currentPlaylist.length) {
      await stop();
      return;
    }

    await _playAtIndex(nextIndex);
  }

  Future<void> previous() async {
    if (_currentPlaylist.isEmpty) return;

    final prevIndex = _currentIndex - 1;

    if (prevIndex < 0) return;

    await _playAtIndex(prevIndex);
  }

  // =========================
  // AUTO NEXT
  // =========================

  StreamSubscription? _sub;

  void _initAutoNext() {
    _sub = engine.playerStateStream.listen((state) async {
      if (state.processingState == ProcessingState.completed) {
        if (_currentPlaylist.isEmpty) {
          // РАЧНО ИЗБРАНО АУДИО: Се ресетира на почеток без да се брише трекот
          await engine.seek(Duration.zero);
          await engine.pause();

          _setState((s) => s.copyWith(isPlaying: false));
        } else {
          // Ако е пуштена цела категорија, продолжува на следна песна
          next();
        }
      }
    });
  }

  void dispose() {
    _sub?.cancel();
    _stateStreamController.close();
    engine.dispose(); // Се повикува со цел спречување на memory leaks
  }
}
