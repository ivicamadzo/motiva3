import 'dart:math';
import 'package:flutter/material.dart';

import '../../../theme/theme_exports.dart';

import '../data/psychoeducation_cards.dart';
import '../data/quotes.dart';

import '../widgets/greeting_card.dart';
import '../widgets/help_card.dart';
import '../widgets/quote_card.dart';
import '../widgets/safe_card.dart';

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
      appBar: AppBar(title: const Text("Motiva"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.sm),

              const GreetingCard(),

              const SizedBox(height: AppSpacing.lg),

              Text(
                "Што ми се случува во моментов?",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: AppSpacing.md),

              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: psychoeducationCards.map((item) {
                    return HelpCard(
                      icon: item.icon,
                      title: item.title,
                      screen: item.screen,
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              QuoteCard(quote: quote["quote"]!, author: quote["author"]!),

              const SizedBox(height: AppSpacing.lg),

              const SafeCard(),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
