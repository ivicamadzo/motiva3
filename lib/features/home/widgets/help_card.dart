import 'package:flutter/material.dart';
import '../../../theme/theme_exports.dart';

class HelpCard extends StatelessWidget {
  final IconData icon;
  final String title;

  final Widget Function() screenBuilder;

  const HelpCard({
    super.key,
    required this.icon,
    required this.title,
    required this.screenBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.md),
      child: InkWell(
        borderRadius: AppRadius.mediumBorder,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screenBuilder()),
          );
        },
        child: Container(
          width: 140,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.mediumBorder,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: AppColors.primary),
              const SizedBox(height: AppSpacing.sm),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
