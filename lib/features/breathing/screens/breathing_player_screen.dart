import 'dart:async';
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
  Timer? _startTimer;
  bool _isPreparing = true;

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

    _startTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() => _isPreparing = false);
      _engine.start();
    });
  }

  @override
  void dispose() {
    _engine.dispose();
    _startTimer?.cancel();
    super.dispose();
  }

  String get pattern {
    final t = widget.technique;

    if (t.holdSeconds == 0) {
      return "${t.inhaleSeconds}с вдишување • "
          "${t.exhaleSeconds}с издишување";
    }

    return "${t.inhaleSeconds}с вдишување • "
        "${t.holdSeconds}с задржување • "
        "${t.exhaleSeconds}с издишување"
        "${t.holdAfterExhale ? ' • ${t.holdSeconds}с задржување' : ''}";
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
            BreathingCircle(
              phase: _engine.phase,
              isAfterExhale: _engine.isAfterExhale,
              phaseSeconds: _phaseSeconds,
              isPreparing: _isPreparing,
            ),

            const SizedBox(height: 30),

            BreathingPhaseText(phase: _engine.phase, isPreparing: _isPreparing),

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

  int get _phaseSeconds {
    if (_isPreparing) return 0;

    switch (_engine.phase) {
      case BreathingPhase.inhale:
        return widget.technique.inhaleSeconds;
      case BreathingPhase.hold:
        return widget.technique.holdSeconds;
      case BreathingPhase.exhale:
        return widget.technique.exhaleSeconds;
    }
  }
}
