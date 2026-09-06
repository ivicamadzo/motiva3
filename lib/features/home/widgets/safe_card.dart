import 'package:flutter/material.dart';
import '../../../theme/theme_exports.dart';

class SafeCard extends StatelessWidget {
  const SafeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mediumBorder,
      ),
      child: Column(
        children: [
          Text(
            "💙 Безбедни сте",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(
            "Ќе помине. Фокусирајте се на дишењето",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
