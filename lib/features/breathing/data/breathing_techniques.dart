// =======================================
// Future breathing techniques
// =======================================
//
// TODO: 6-2-8 Breathing
// TODO: Triangle Breathing
// TODO: Coherent Breathing (5-5)
// TODO: Pursed Lip Breathing
// TODO: Alternate Nostril Breathing
// TODO: Physiological Sigh
//

import '../models/breathing_technique.dart';

const boxBreathing = BreathingTechnique(
  id: 'box',
  name: 'Box Breathing',
  inhaleSeconds: 4,
  holdSeconds: 4,
  exhaleSeconds: 4,
  cycles: 10,
);

const relaxingBreathing = BreathingTechnique(
  id: 'relax',
  name: 'Relaxing Breathing',
  inhaleSeconds: 4,
  holdSeconds: 0,
  exhaleSeconds: 6,
  cycles: 10,
);

const fourSevenEightBreathing = BreathingTechnique(
  id: '478',
  name: '4-7-8 Breathing',
  inhaleSeconds: 4,
  holdSeconds: 7,
  exhaleSeconds: 8,
  cycles: 6,
);

const resonanceBreathing = BreathingTechnique(
  id: 'resonance',
  name: 'Resonance Breathing',
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
