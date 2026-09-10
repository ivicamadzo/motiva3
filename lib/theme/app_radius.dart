import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  // ─────────────────────────────────────────────
  // RADIUS
  // ─────────────────────────────────────────────

  static const Radius small = Radius.circular(10);
  static const Radius medium = Radius.circular(16);
  static const Radius large = Radius.circular(24);
  static const Radius pill = Radius.circular(999);

  // ─────────────────────────────────────────────
  // BORDER RADIUS
  // ─────────────────────────────────────────────

  static const BorderRadius smallBorder = BorderRadius.all(small);

  static const BorderRadius mediumBorder = BorderRadius.all(medium);

  static const BorderRadius largeBorder = BorderRadius.all(large);

  static const BorderRadius pillBorder = BorderRadius.all(pill);
}
