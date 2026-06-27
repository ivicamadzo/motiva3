import 'package:flutter/material.dart';
import '../services/breathing_engine.dart';

class BreathingCircle extends StatelessWidget {
  final BreathingPhase phase;

  const BreathingCircle({super.key, required this.phase});

  double getSize() {
    switch (phase) {
      case BreathingPhase.inhale:
        return 240;
      case BreathingPhase.exhale:
        return 140;
      case BreathingPhase.hold:
        return 180;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize();

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
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
  }
}
