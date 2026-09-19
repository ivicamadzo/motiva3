import '../models/breathing_technique.dart';

const boxBreathing = BreathingTechnique(
  id: 'box',
  name: 'Дишење во квадрат',
  inhaleSeconds: 4,
  holdSeconds: 4,
  exhaleSeconds: 4,
  holdAfterExhale: true,
  cycles: 10,
);

const relaxingBreathing = BreathingTechnique(
  id: 'relax',
  name: 'Дишење за релаксација',
  inhaleSeconds: 4,
  holdSeconds: 0,
  exhaleSeconds: 6,
  cycles: 10,
);

const fourSevenEightBreathing = BreathingTechnique(
  id: '478',
  name: '4-7-8 Дишење',
  inhaleSeconds: 4,
  holdSeconds: 7,
  exhaleSeconds: 8,
  cycles: 6,
);

const resonanceBreathing = BreathingTechnique(
  id: 'resonance',
  name: 'Резонантно дишење',
  inhaleSeconds: 5,
  holdSeconds: 0,
  exhaleSeconds: 5,
  cycles: 10,
);

const breathingTechniques = [
  boxBreathing,
  relaxingBreathing,
  fourSevenEightBreathing,
  resonanceBreathing,
];
