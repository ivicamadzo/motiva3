import 'dart:async';
import '../models/breathing_technique.dart';

import 'package:flutter/foundation.dart';

enum BreathingPhase { inhale, hold, exhale }

class BreathingEngine {
  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;
  final int totalCycles;

  final VoidCallback onUpdate;
  final VoidCallback onComplete;

  BreathingPhase phase = BreathingPhase.inhale;
  int currentCycle = 0;

  Timer? _timer;
  bool _running = false;

  BreathingEngine({
    required this.inhaleSeconds,
    required this.holdSeconds,
    required this.exhaleSeconds,
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
  }

  void _runCycle() async {
    while (_running && currentCycle < totalCycles) {
      // INHALE
      phase = BreathingPhase.inhale;
      onUpdate();
      await _wait(inhaleSeconds);

      if (!_running) return;

      // HOLD
      phase = BreathingPhase.hold;
      onUpdate();
      await _wait(holdSeconds);

      if (!_running) return;

      // EXHALE
      phase = BreathingPhase.exhale;
      onUpdate();
      await _wait(exhaleSeconds);

      if (!_running) return;

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
