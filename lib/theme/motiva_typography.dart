import 'package:flutter/material.dart';

class MotivaTypography {
  MotivaTypography._();

  // ─────────────────────────────────────────────
  // FONT
  // ─────────────────────────────────────────────

  static const String fontFamily = 'NotoSans';

  // ─────────────────────────────────────────────
  // HEADINGS
  // ─────────────────────────────────────────────

  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    height: 1.2,
    fontFamily: fontFamily,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.3,
    fontFamily: fontFamily,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    fontFamily: fontFamily,
  );

  // ─────────────────────────────────────────────
  // BODY
  // ─────────────────────────────────────────────

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontFamily: fontFamily,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    fontFamily: fontFamily,
  );

  // ─────────────────────────────────────────────
  // BUTTONS / ACTIONS
  // ─────────────────────────────────────────────

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.2,
    fontFamily: fontFamily,
  );

  // ─────────────────────────────────────────────
  // CAPTION / HELPER TEXT
  // ─────────────────────────────────────────────

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.35,
    fontFamily: fontFamily,
  );
}
