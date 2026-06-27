import 'package:flutter/material.dart';
import '../services/breathing_engine.dart';

class BreathingPhaseText extends StatelessWidget {
  final BreathingPhase phase;

  const BreathingPhaseText({super.key, required this.phase});

  String get text {
    switch (phase) {
      case BreathingPhase.inhale:
        return "INHALE";
      case BreathingPhase.hold:
        return "HOLD";
      case BreathingPhase.exhale:
        return "EXHALE";
    }
  }

  String get subtitle {
    switch (phase) {
      case BreathingPhase.inhale:
        return "Breathe in slowly";
      case BreathingPhase.hold:
        return "Keep the air";
      case BreathingPhase.exhale:
        return "Release slowly";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            text,
            key: ValueKey(text),
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            subtitle,
            key: ValueKey(subtitle),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
