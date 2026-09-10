import 'dart:async';
import 'package:just_audio/just_audio.dart';

import '../models/breathing_technique.dart';
import '../data/breathing_assets.dart';

import 'package:flutter/foundation.dart';

enum BreathingPhase { inhale, hold, exhale }

class BreathingEngine {
  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;
  final bool holdAfterExhale;
  final int totalCycles;

  final VoidCallback onUpdate;
  final VoidCallback onComplete;
  final AudioPlayer _cuePlayer = AudioPlayer();

  BreathingPhase phase = BreathingPhase.inhale;
  int currentCycle = 0;
  bool isAfterExhale = false;

  Timer? _timer;
  bool _running = false;

  BreathingEngine({
    required this.inhaleSeconds,
    required this.holdSeconds,
    required this.exhaleSeconds,
    required this.holdAfterExhale,
    required this.totalCycles,
    required this.onUpdate,
    required this.onComplete,
  });

  /// TECHNIQUE FACTORY
  factory BreathingEngine.fromTechnique({
    required BreathingTechnique technique,
    required VoidCallback onUpdate,
    required VoidCallback onComplete,
  }) {
    return BreathingEngine(
      inhaleSeconds: technique.inhaleSeconds,
      holdSeconds: technique.holdSeconds,
      exhaleSeconds: technique.exhaleSeconds,
      holdAfterExhale: technique.holdAfterExhale,
      totalCycles: technique.cycles,
      onUpdate: onUpdate,
      onComplete: onComplete,
    );
  }

  void start() {
    if (_running) return;

    _running = true;
    _runCycle();
  }

  void stop() {
    _running = false;
    _timer?.cancel();
  }

  void dispose() {
    stop();
    _cuePlayer.dispose();
  }

  Future<void> _playCue(String assetPath) async {
    try {
      await _cuePlayer.setAsset(assetPath);
      await _cuePlayer.play();
    } catch (error) {
      debugPrint('Breathing cue failed: $assetPath ($error)');
    }
  }

  void _runCycle() async {
    while (_running && currentCycle < totalCycles) {
      // INHALE
      phase = BreathingPhase.inhale;
      isAfterExhale = false;
      onUpdate();
      unawaited(_playCue(BreathingAssets.inhale));
      await _wait(inhaleSeconds);

      if (!_running) return;

      // HOLD
      phase = BreathingPhase.hold;
      isAfterExhale = false;
      onUpdate();
      await _wait(holdSeconds);

      if (!_running) return;

      // EXHALE
      phase = BreathingPhase.exhale;
      isAfterExhale = false;
      onUpdate();
      unawaited(_playCue(BreathingAssets.exhale));
      await _wait(exhaleSeconds);

      if (!_running) return;

      if (holdAfterExhale) {
        // Box breathing uses the same hold after exhaling.
        phase = BreathingPhase.hold;
        isAfterExhale = true;
        onUpdate();
        await _wait(holdSeconds);

        if (!_running) return;
      }

      isAfterExhale = false;

      currentCycle++;
      onUpdate();
    }

    _running = false;
    onComplete();
  }

  Future<void> _wait(int seconds) async {
    for (int i = 0; i < seconds; i++) {
      if (!_running) return;
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
