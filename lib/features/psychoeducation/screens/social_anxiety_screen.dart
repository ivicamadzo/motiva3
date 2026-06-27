import 'package:flutter/material.dart';
import '../core/psychoeducation_template.dart';
import '../data/social_anxiety_data.dart';

class SocialAnxietyScreen extends StatelessWidget {
  const SocialAnxietyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PsychoeducationScreen(
      title: "Социјална анксиозност",
      pages: socialAnxietyPages,
    );
  }
}
