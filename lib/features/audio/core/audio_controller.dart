import 'dart:async';

import '../data/models/audio_item.dart';
import '../data/models/audio_category.dart';
import '../data/models/audio_state.dart';

import '../data/playlists/panic_playlist.dart';
import '../data/playlists/overthinking_playlist.dart';
import '../data/playlists/rumination_playlist.dart';

import 'audio_singleton.dart';
import 'package:just_audio/just_audio.dart';

class AudioController {
  final _audioService = AudioSingleton.service;

  AudioController() {
    _initAutoNext();
  }

  AudioCategory? _currentCategory;
  AudioItem? _currentTrack;
  List<AudioItem> _currentPlaylist = [];
  int _currentIndex = 0;

  final StreamController<AudioState> _stateController =
      StreamController<AudioState>.broadcast();

  AudioState _state = AudioState(
    currentTrack: null,
    currentCategory: null,
    isPlaying: false,
  );

  Stream<AudioState> get stateStream => _stateController.stream;
  AudioState get state => _state;

  AudioCategory? get currentCategory => _currentCategory;
  AudioItem? get currentTrack => _currentTrack;
  List<AudioItem> get currentPlaylist => _currentPlaylist;

  void _updateState(AudioState newState) {
    _state = newState;
    _stateController.add(newState);
  }

  // 🎯 PLAY CATEGORY
  Future<void> playCategory(AudioCategory category) async {
    _currentCategory = category;

    switch (category) {
      case AudioCategory.panic:
        _currentPlaylist = panicPlaylist;
        break;
      case AudioCategory.overthinking:
        _currentPlaylist = overthinkingPlaylist;
        break;
      case AudioCategory.rumination:
        _currentPlaylist = ruminationPlaylist;
        break;
    }

    if (_currentPlaylist.isEmpty) return;

    _currentIndex = 0;
    await _playAtIndex(_currentIndex);
  }

  // ▶️ INTERNAL PLAY
  Future<void> _playAtIndex(int index) async {
    if (index < 0 || index >= _currentPlaylist.length) return;

    _currentIndex = index;
    _currentTrack = _currentPlaylist[_currentIndex];

    await _audioService.play(_currentTrack!.assetPath);

    _updateState(
      _state.copyWith(
        currentTrack: _currentTrack,
        currentCategory: _currentCategory,
        isPlaying: true,
      ),
    );
  }

  Future<void> playTrack(AudioItem item) async {
    _currentTrack = item;

    await _audioService.play(item.assetPath);

    _updateState(_state.copyWith(currentTrack: _currentTrack, isPlaying: true));
  }

  Future<void> pause() async {
    await _audioService.pause();
    _updateState(_state.copyWith(isPlaying: false));
  }

  Future<void> resume() async {
    await _audioService.resume();
    _updateState(_state.copyWith(isPlaying: true));
  }

  Future<void> stop() async {
    await _audioService.stop();

    _currentTrack = null;
    _currentPlaylist = [];
    _currentCategory = null;
    _currentIndex = 0;

    _updateState(
      AudioState(currentTrack: null, currentCategory: null, isPlaying: false),
    );
  }

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

  Future<void> seek(Duration position) async {
    await _audioService.player.seek(position);
  }

  void _initAutoNext() {
    _audioService.player.playerStateStream.listen((state) {
      final isCompleted = state.processingState == ProcessingState.completed;

      if (isCompleted) {
        next();
      }
    });
  }

  Stream<Duration> get positionStream => _audioService.positionStream;
  Stream<Duration?> get durationStream => _audioService.durationStream;

  void dispose() {
    _stateController.close();
  }
}
