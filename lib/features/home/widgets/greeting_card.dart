import 'package:flutter/material.dart';

import '../../../theme/theme_exports.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Добро утро 👋';
    }

    if (hour < 18) {
      return 'Добар ден 👋';
    }

    return 'Добра вечер 👋';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: AppRadius.largeBorder,
        boxShadow: AppShadows.softList,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getGreeting(),
                style: MotivaTypography.h2.copyWith(color: Colors.white),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Како се чувствуваш денес?',
                style: MotivaTypography.h1.copyWith(
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Тука сум за тебе. Земете момент за себе.',
                style: MotivaTypography.body.copyWith(
                  color: Colors.white.withValues(alpha: 0.82),
                ),
              ),
            ],
          ),

          Positioned(
            right: -20,
            bottom: -30,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),

          Positioned(
            right: 25,
            bottom: 20,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.10),
              ),
              child: const Icon(
                Icons.spa_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
