import 'package:flutter/material.dart';

class BreathingCycleCounter extends StatelessWidget {
  final int current;
  final int total;

  const BreathingCycleCounter({
    super.key,
    required this.current,
    required this.total,
  });

  double get progress {
    if (total == 0) return 0;
    return current / total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Cycle ${current.clamp(0, total)} / $total",
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade300,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
