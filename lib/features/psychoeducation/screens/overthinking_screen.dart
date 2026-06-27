import 'package:flutter/material.dart';
import '../core/psychoeducation_template.dart';
import '../data/overthinking_data.dart';

class OverthinkingScreen extends StatelessWidget {
  const OverthinkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PsychoeducationScreen(
      title: "Overthinking",
      pages: overthinkingPages,
    );
  }
}
