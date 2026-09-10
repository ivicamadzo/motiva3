import 'package:flutter/material.dart';
import '../services/breathing_engine.dart';

class BreathingPhaseText extends StatelessWidget {
  final BreathingPhase phase;
  final bool isPreparing;

  const BreathingPhaseText({
    super.key,
    required this.phase,
    this.isPreparing = false,
  });

  String get text {
    if (isPreparing) return "ПОДГОТВИ СЕ";

    switch (phase) {
      case BreathingPhase.inhale:
        return "ВДИШИ";
      case BreathingPhase.hold:
        return "ЗАДРЖИ";
      case BreathingPhase.exhale:
        return "ИЗДИШИ";
    }
  }

  String get subtitle {
    if (isPreparing) return "Вежбата започнува за момент";

    switch (phase) {
      case BreathingPhase.inhale:
        return "Вдиши полека";
      case BreathingPhase.hold:
        return "Задржи го воздухот";
      case BreathingPhase.exhale:
        return "Издиши полека";
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
