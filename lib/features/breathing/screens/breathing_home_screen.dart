import 'package:flutter/material.dart';

import '../data/breathing_techniques.dart';
import '../models/breathing_technique.dart';
import 'breathing_player_screen.dart';
import '../../../theme/theme_exports.dart';

class BreathingHomeScreen extends StatelessWidget {
  const BreathingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Техники на Дишење')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: breathingTechniques.length,
        separatorBuilder: (_, index) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final technique = breathingTechniques[index];

          return _techniqueTile(
            context,
            technique: technique,
            icon: _iconForTechnique(technique),
          );
        },
      ),
    );
  }

  IconData _iconForTechnique(BreathingTechnique technique) {
    switch (technique.id) {
      case 'box':
        return Icons.crop_square;
      case 'relax':
        return Icons.spa_outlined;
      case '478':
        return Icons.nightlight_round;
      case 'resonance':
        return Icons.favorite_outline;
      default:
        return Icons.air;
    }
  }

  Widget _techniqueTile(
    BuildContext context, {
    required BreathingTechnique technique,
    required IconData icon,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(technique.name),
        subtitle: Text(
          technique.holdSeconds == 0
              ? '${technique.inhaleSeconds} • ${technique.exhaleSeconds}'
              : '${technique.inhaleSeconds} • '
                    '${technique.holdSeconds} • '
                    '${technique.exhaleSeconds}'
                    '${technique.holdAfterExhale ? ' • ${technique.holdSeconds}' : ''}',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BreathingPlayerScreen(technique: technique),
            ),
          );
        },
      ),
    );
  }
}
