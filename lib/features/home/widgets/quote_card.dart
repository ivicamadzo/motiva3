import 'package:flutter/material.dart';

import '../../../theme/theme_exports.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;

  const QuoteCard({super.key, required this.quote, required this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.largeBorder,
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.subtleList,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.format_quote_rounded,
            size: 28,
            color: AppColors.primaryLight,
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            '"$quote"',
            style: MotivaTypography.body.copyWith(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              height: 1.55,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            '— $author',
            style: MotivaTypography.caption.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
