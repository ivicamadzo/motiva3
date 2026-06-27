import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const Radius small = Radius.circular(12);
  static const Radius medium = Radius.circular(16);
  static const Radius large = Radius.circular(24);

  static const BorderRadius smallBorder = BorderRadius.all(small);
  static const BorderRadius mediumBorder = BorderRadius.all(medium);
  static const BorderRadius largeBorder = BorderRadius.all(large);
}
