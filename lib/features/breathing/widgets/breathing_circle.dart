import 'package:flutter/material.dart';
import '../services/breathing_engine.dart';

class BreathingCircle extends StatelessWidget {
  final BreathingPhase phase;
  final bool isAfterExhale;
  final int phaseSeconds;
  final bool isPreparing;

  const BreathingCircle({
    super.key,
    required this.phase,
    required this.isAfterExhale,
    required this.phaseSeconds,
    required this.isPreparing,
  });

  double _targetSize() {
    switch (phase) {
      case BreathingPhase.inhale:
        return 240;
      case BreathingPhase.exhale:
        return 140;
      case BreathingPhase.hold:
        return isAfterExhale ? 140 : 240;
    }
  }

  double _startSize() {
    if (isPreparing) return 140;

    switch (phase) {
      case BreathingPhase.inhale:
        return 140;
      case BreathingPhase.exhale:
        return 240;
      case BreathingPhase.hold:
        return _targetSize();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double targetSize = isPreparing ? 140.0 : _targetSize();
    final duration = isPreparing
        ? Duration.zero
        : Duration(seconds: phaseSeconds);

    return TweenAnimationBuilder<double>(
      key: ValueKey('$phase-$isAfterExhale-$isPreparing'),
      tween: Tween(begin: _startSize(), end: targetSize),
      duration: duration,
      curve: Curves.easeInOut,
      builder: (context, size, child) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.self_improvement,
              size: size / 3,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
