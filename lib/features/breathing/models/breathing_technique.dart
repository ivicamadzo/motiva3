class BreathingTechnique {
  final String id;
  final String name;

  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;
  final bool holdAfterExhale;

  final int cycles;

  const BreathingTechnique({
    required this.id,
    required this.name,
    required this.inhaleSeconds,
    required this.holdSeconds,
    required this.exhaleSeconds,
    this.holdAfterExhale = false,
    required this.cycles,
  });
}
