import 'dart:math';

import 'package:flutter/material.dart';

import '../home_exports.dart';
import '../../../theme/theme_exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Map<String, String> quote;

  @override
  void initState() {
    super.initState();
    quote = quotes[Random().nextInt(quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Motiva'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.sm),

              // ─────────────────────────────────
              // GREETING
              // ─────────────────────────────────
              const GreetingCard(),

              const SizedBox(height: AppSpacing.xl),

              // ─────────────────────────────────
              // TOOLS
              // ─────────────────────────────────
              Text(
                'Алатки',
                style: MotivaTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: toolCards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  mainAxisExtent: 130,
                ),
                itemBuilder: (context, index) {
                  final item = toolCards[index];

                  return HelpCard(
                    icon: item.icon,
                    title: item.title,
                    screenBuilder: item.screenBuilder,
                  );
                },
              ),

              const SizedBox(height: AppSpacing.xl),

              // ─────────────────────────────────
              // EDUCATION
              // ─────────────────────────────────
              Text(
                'Едукација',
                style: MotivaTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: psychoeducationCards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  mainAxisExtent: 130,
                ),
                itemBuilder: (context, index) {
                  final item = psychoeducationCards[index];

                  return HelpCard(
                    icon: item.icon,
                    title: item.title,
                    screenBuilder: item.screenBuilder,
                  );
                },
              ),

              const SizedBox(height: AppSpacing.xl),

              // ─────────────────────────────────
              // QUOTE
              // ─────────────────────────────────
              QuoteCard(quote: quote['quote']!, author: quote['author']!),

              const SizedBox(height: AppSpacing.xl),

              // ─────────────────────────────────
              // SAFE MESSAGE
              // ─────────────────────────────────
              const SafeCard(),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
