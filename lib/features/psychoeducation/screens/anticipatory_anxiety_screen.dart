import 'package:flutter/material.dart';
import '../core/psychoeducation_template.dart';
import '../data/anticipatory_anxiety_data.dart';

class AnticipatoryAnxietyScreen extends StatelessWidget {
  const AnticipatoryAnxietyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PsychoeducationScreen(
      title: "Антиципаторна анксиозност",
      pages: anticipatoryAnxietyPages,
    );
  }
}
