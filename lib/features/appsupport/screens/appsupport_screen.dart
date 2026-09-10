import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/theme_exports.dart';

class AppsupportScreen extends StatelessWidget {
  const AppsupportScreen({super.key});

  static final Uri _supportUrl = Uri.parse('https://buymeacoffee.com/podrska');

  Future<void> _openSupportPage() async {
    if (await canLaunchUrl(_supportUrl)) {
      await launchUrl(_supportUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Поддржи')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.lg),

              Icon(Icons.favorite_rounded, size: 64, color: AppColors.primary),

              const SizedBox(height: AppSpacing.lg),

              Text(
                'Поддржи ја Motiva',
                textAlign: TextAlign.center,
                style: MotivaTypography.h2,
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Ако Motiva ти е корисна апликација, сакаш да им помага на другите, '
                'можеш да го поддржиш нејзиниот понатамошен развој.',
                textAlign: TextAlign.center,
                style: MotivaTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      const Icon(Icons.coffee_rounded, size: 42),

                      const SizedBox(height: AppSpacing.md),

                      Text(
                        'Поддржи со Buy Me a Coffee',
                        textAlign: TextAlign.center,
                        style: MotivaTypography.h3,
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      Text(
                        'Секоја поддршка помага Motiva да продолжи да се развива.',
                        textAlign: TextAlign.center,
                        style: MotivaTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _openSupportPage,
                          icon: const Icon(Icons.favorite),
                          label: const Text('Поддржи ја Motiva'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                'Плаќањето се врши преку Buy Me a Coffee. '
                'Апликацијата не ги обработува податоците за плаќање.',
                textAlign: TextAlign.center,
                style: MotivaTypography.caption.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
