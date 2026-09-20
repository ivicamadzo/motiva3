import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/theme_exports.dart';

class AppsupportScreen extends StatelessWidget {
  const AppsupportScreen({super.key});

  static final Uri _supportUrl = Uri.parse('https://buymeacoffee.com/podrska');
  static final Uri _privacyPolicyUrl = Uri.parse(
    'https://ivicamadzo.github.io/motiva3/privacy_policy.html',
  );

  Future<void> _openSupportPage() async {
    await launchUrl(_supportUrl, mode: LaunchMode.externalApplication);
  }

  Future<void> _openPrivacyPolicy() async {
    await launchUrl(_privacyPolicyUrl, mode: LaunchMode.externalApplication);
  }

  Future<void> _callNumber(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    await launchUrl(uri);
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
                      const Icon(Icons.info_outline_rounded, size: 32),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Важно известување',
                        textAlign: TextAlign.center,
                        style: MotivaTypography.h3,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Motiva е едукативна и wellness апликација. Содржината не е медицински совет, дијагноза или замена за професионална медицинска или психолошка помош. Ако си во итна опасност или имаш сериозна криза, контактирај локална итна служба или квалификуван здравствен професионалец.',
                        textAlign: TextAlign.center,
                        style: MotivaTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
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

              const SizedBox(height: AppSpacing.xl),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      const Icon(Icons.emergency_outlined, size: 42),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Помош во криза',
                        textAlign: TextAlign.center,
                        style: MotivaTypography.h3,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Оваа апликација не обезбедува кризна интервенција. Ако си во непосредна опасност, јави се на локалната итна служба или оди во најблиската итна медицинска установа.',
                        textAlign: TextAlign.center,
                        style: MotivaTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => _callNumber('112'),
                          icon: const Icon(Icons.phone_outlined),
                          label: const Text('Итни случаи: 112'),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _callNumber('194'),
                          icon: const Icon(Icons.phone_outlined),
                          label: const Text('Итна медицинска помош: 194'),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Ако не можеш да се јавиш, побарај доверлива личност да остане со тебе и контактирај квалификуван здравствен професионалец.',
                        textAlign: TextAlign.center,
                        style: MotivaTypography.caption.copyWith(
                          color: AppColors.textMuted,
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

              const SizedBox(height: AppSpacing.md),

              TextButton.icon(
                onPressed: _openPrivacyPolicy,
                icon: const Icon(Icons.privacy_tip_outlined),
                label: const Text('Политика за приватност'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
