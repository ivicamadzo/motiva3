import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // 0.0 - 1.0

  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(value: progress),
        const SizedBox(height: 6),
        Text(
          "${(progress * 100).toInt()}%",
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
