import 'package:flutter/material.dart';
import '../core/psychoeducation_template.dart';
import '../data/fear_of_judgment_data.dart';

class FearOfJudgmentScreen extends StatelessWidget {
  const FearOfJudgmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PsychoeducationScreen(
      title: "Страв од осуда",
      pages: fearOfJudgmentPages,
    );
  }
}
