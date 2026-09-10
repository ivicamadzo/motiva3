import 'package:flutter/material.dart';

import '../../../theme/theme_exports.dart';

class SafeCard extends StatelessWidget {
  const SafeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.largeBorder,
        border: Border.all(
          color: AppColors.successSoft.withValues(alpha: 0.45),
        ),
        boxShadow: AppShadows.subtleList,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.12),
              borderRadius: AppRadius.mediumBorder,
            ),
            child: const Icon(
              Icons.favorite_outline_rounded,
              color: AppColors.success,
              size: 23,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Безбедно е да забавиш.',
                  style: MotivaTypography.h3.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: AppSpacing.xs),

                Text(
                  'Земи здив. Овој момент ќе помине.',
                  style: MotivaTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
