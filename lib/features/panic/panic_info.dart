// lib/features/panic/panic_info.dart
import 'package:flutter/material.dart';

class PanicInfo extends StatelessWidget {
  final String title;

  const PanicInfo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
