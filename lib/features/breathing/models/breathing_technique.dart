class BreathingTechnique {
  final String id;
  final String name;

  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;

  final int cycles;

  const BreathingTechnique({
    required this.id,
    required this.name,
    required this.inhaleSeconds,
    required this.holdSeconds,
    required this.exhaleSeconds,
    required this.cycles,
  });
}
