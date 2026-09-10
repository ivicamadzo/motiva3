import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../engine/audio_engine.dart';
import '../data/models/audio_item.dart';
import '../data/models/audio_category.dart';
import '../data/models/audio_state.dart';

import '../data/playlists/panic_playlist.dart';
import '../data/playlists/meditation_playlist.dart';
import '../data/playlists/pmr_playlist.dart';

class AudioController {
  final AudioEngine engine;

  final Map<AudioCategory, List<AudioItem>> _playlists = {
    AudioCategory.panic: panicPlaylist,
    AudioCategory.meditation: meditationPlaylist,
    AudioCategory.pmr: pmrPlaylist,
  };

  AudioController(this.engine) {
    _initAudioListener();
  }

  // =========================
  // INTERNAL STATE
  // =========================

  AudioCategory? _currentCategory;
  AudioItem? _currentTrack;
  List<AudioItem> _currentPlaylist = [];
  int _currentIndex = 0;

  AudioState? _lastState;

  final StreamController<AudioState> _stateStreamController =
      StreamController<AudioState>.broadcast();

  // =========================
  // GETTERS
  // =========================

  Stream<AudioState> get stateStream => _stateStreamController.stream;

  AudioState get currentState =>
      _lastState ??
      AudioState(currentTrack: null, currentCategory: null, isPlaying: false);

  Stream<Duration?> get durationStream => engine.durationStream;

  Stream<Duration> get positionStream => engine.positionStream;

  Duration get currentPosition => engine.currentPosition;

  Duration get currentDuration => engine.currentDuration;

  // =========================
  // SEEK
  // =========================

  Future<void> seek(Duration position) async {
    await engine.seek(position);
  }

  // =========================
  // STATE UPDATE
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
  // PLAY BY INDEX
  // =========================

  Future<void> _playAtIndex(int index) async {
    if (index < 0 || index >= _currentPlaylist.length) {
      return;
    }

    _currentIndex = index;
    _currentTrack = _currentPlaylist[_currentIndex];

    final track = _currentTrack!;

    await engine.loadAsset(track);

    _setState(
      (s) => s.copyWith(currentTrack: track, currentCategory: _currentCategory),
    );

    unawaited(engine.play());
  }

  // =========================
  // PLAY SINGLE TRACK
  // =========================

  Future<void> playTrack(AudioItem item, {AudioCategory? category}) async {
    debugPrint('🔥 PLAY TRACK CALLED: ${item.title}');

    // Ако е истата песна → продолжи
    if (_currentTrack?.assetPath == item.assetPath &&
        engine.currentPosition != Duration.zero) {
      debugPrint('▶️ SAME TRACK - RESUMING');
      unawaited(engine.play());
      return;
    }

    _currentTrack = item;

    if (category != null) {
      _currentCategory = category;
      _currentPlaylist = _playlists[category] ?? [];

      final index = _currentPlaylist.indexOf(item);

      if (index != -1) {
        _currentIndex = index;
      }
    }

    // 1. Стопирај што свири моментално
    await engine.stop();

    _setState(
      (s) => s.copyWith(
        currentTrack: item,
        currentCategory: _currentCategory,
        isPlaying: false,
      ),
    );

    // 2. Вчитај ја новата песна
    final duration = await engine.loadAsset(item);

    if (duration == null) {
      debugPrint('❌ AUDIO LOAD FAILED: ${item.title}');
      return;
    }

    // 3. Пушти ја новата песна
    unawaited(engine.play());

    debugPrint('▶️ PLAY STARTED: ${item.title}');
  }

  // =========================
  // PAUSE
  // =========================

  Future<void> pause() async {
    await engine.pause();

    _setState((s) => s.copyWith(isPlaying: false));
  }

  // =========================
  // RESUME
  // =========================

  Future<void> resume() async {
    await engine.play();
  }

  // =========================
  // STOP
  // =========================

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
  // NEXT
  // =========================

  Future<void> next() async {
    if (_currentPlaylist.isEmpty) {
      return;
    }

    final nextIndex = _currentIndex + 1;

    if (nextIndex >= _currentPlaylist.length) {
      await stop();
      return;
    }

    await _playAtIndex(nextIndex);
  }

  // =========================
  // PREVIOUS
  // =========================

  Future<void> previous() async {
    if (_currentPlaylist.isEmpty) {
      return;
    }

    final prevIndex = _currentIndex - 1;

    if (prevIndex < 0) {
      return;
    }

    await _playAtIndex(prevIndex);
  }

  // =========================
  // AUTO NEXT
  // =========================

  StreamSubscription? _sub;

  void _initAudioListener() {
    _sub = engine.playerStateStream.listen((state) async {
      debugPrint(
        '--- AUDIO ENGINE STATE: '
        'isPlaying=${state.playing}, '
        'processingState=${state.processingState} ---',
      );

      // Реалниот статус на плеерот
      _setState((s) => s.copyWith(isPlaying: state.playing));

      // Автоматски премини на следната песна
      if (state.processingState == ProcessingState.completed) {
        if (_currentPlaylist.isEmpty) {
          await engine.seek(Duration.zero);
          await engine.pause();
        } else {
          await next();
        }
      }
    });
  }

  // =========================
  // DISPOSE
  // =========================

  void dispose() {
    _sub?.cancel();
    _stateStreamController.close();
    engine.dispose();
  }
}
