// =======================================
// Future breathing techniques
// =======================================
//
// TODO: 6-2-8 Breathing
// TODO: Triangle Breathing
// TODO: Coherent Breathing (5-5)
// TODO: Pursed Lip Breathing
// TODO: Alternate Nostril Breathing
// TODO: Physiological Sigh
//

import 'package:flutter/material.dart';

import '../data/breathing_techniques.dart';
import 'breathing_player_screen.dart';
import '../models/breathing_technique.dart';

class BreathingHomeScreen extends StatelessWidget {
  const BreathingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Breathing Techniques")),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          _techniqueTile(
            context,
            technique: boxBreathing,
            icon: Icons.crop_square,
          ),

          const SizedBox(height: 12),

          _techniqueTile(
            context,
            technique: relaxingBreathing,
            icon: Icons.spa_outlined,
          ),

          const SizedBox(height: 12),

          _techniqueTile(
            context,
            technique: fourSevenEightBreathing,
            icon: Icons.nightlight_round,
          ),

          const SizedBox(height: 12),

          _techniqueTile(
            context,
            technique: resonanceBreathing,
            icon: Icons.favorite_outline,
          ),
        ],
      ),
    );
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
              ? "${technique.inhaleSeconds} • ${technique.exhaleSeconds}"
              : "${technique.inhaleSeconds} • "
                    "${technique.holdSeconds} • "
                    "${technique.exhaleSeconds}",
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
