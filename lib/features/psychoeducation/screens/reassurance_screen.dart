import 'package:flutter/material.dart';
import '../core/psychoeducation_template.dart';
import '../data/reassurance_data.dart';

class ReassuranceScreen extends StatelessWidget {
  const ReassuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PsychoeducationScreen(
      title: "Потреба за уверување",
      pages: reassurancePages,
    );
  }
}
