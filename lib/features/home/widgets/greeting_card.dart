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
      child: Column(
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
            'Твој ден. Твои моменти.',
            style: MotivaTypography.body.copyWith(
              color: Colors.white.withValues(alpha: 0.82),
            ),
          ),
        ],
      ),
    );
  }
}
