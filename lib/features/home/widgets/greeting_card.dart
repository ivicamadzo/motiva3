import 'package:flutter/material.dart';

import '../../../theme/theme_exports.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Добро утро 👋";
    }

    if (hour < 18) {
      return "Добар ден 👋";
    }

    return "Добра вечер 👋";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
        ),

        borderRadius: AppRadius.mediumBorder,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            getGreeting(),

            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(
            "Како се чувствуваш денес?",

            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            "Тука сум за да ти помогнам да се смириш и да ја вратиш контролата.",

            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
