import 'package:flutter/material.dart';

import '../models/breathing_technique.dart';
import '../services/breathing_engine.dart';
import '../widgets/breathing_circle.dart';
import '../widgets/breathing_cycle_counter.dart';
import '../widgets/breathing_phase_text.dart';

class BreathingPlayerScreen extends StatefulWidget {
  final BreathingTechnique technique;

  const BreathingPlayerScreen({super.key, required this.technique});

  @override
  State<BreathingPlayerScreen> createState() => _BreathingPlayerScreenState();
}

class _BreathingPlayerScreenState extends State<BreathingPlayerScreen> {
  late final BreathingEngine _engine;

  @override
  void initState() {
    super.initState();

    _engine = BreathingEngine.fromTechnique(
      technique: widget.technique,
      onUpdate: () => setState(() {}),
      onComplete: () {
        if (mounted) {
          Navigator.pop(context);
        }
      },
    );

    _engine.start();
  }

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }

  String get pattern {
    final t = widget.technique;

    if (t.holdSeconds == 0) {
      return "${t.inhaleSeconds}s inhale • "
          "${t.exhaleSeconds}s exhale";
    }

    return "${t.inhaleSeconds}s inhale • "
        "${t.holdSeconds}s hold • "
        "${t.exhaleSeconds}s exhale";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.technique.name),

        leading: IconButton(
          icon: const Icon(Icons.close),

          onPressed: () {
            _engine.stop();
            Navigator.pop(context);
          },
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BreathingCircle(phase: _engine.phase),

            const SizedBox(height: 30),

            BreathingPhaseText(phase: _engine.phase),

            const SizedBox(height: 16),

            BreathingCycleCounter(
              current: _engine.currentCycle,
              total: _engine.totalCycles,
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),

              child: Text(
                pattern,
                textAlign: TextAlign.center,

                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
