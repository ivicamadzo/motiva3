import 'package:flutter/material.dart';
import '../core/psychoeducation_template.dart';
import '../data/intrusive_thoughts_data.dart';

class IntrusiveThoughtsScreen extends StatelessWidget {
  const IntrusiveThoughtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PsychoeducationScreen(
      title: "Интрузивни мисли",
      pages: intrusiveThoughtsPages,
    );
  }
}
