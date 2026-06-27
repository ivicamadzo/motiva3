import 'package:flutter/material.dart';

class MotivaTypography {
  MotivaTypography._();

  // 🧘 Base font family (safe + readable for anxiety apps)
  static const String fontFamily = 'NotoSans';

  // 🔵 HEADINGS (calm, not aggressive)
  static const TextStyle h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    fontFamily: fontFamily,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    height: 1.3,
    fontFamily: fontFamily,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    fontFamily: fontFamily,
  );

  // 🟢 BODY TEXT (VERY IMPORTANT for anxiety apps)
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontFamily: fontFamily,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: Colors.black54,
    fontFamily: fontFamily,
  );

  // 🔴 CALM ACTION TEXT (buttons / highlights)
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    fontFamily: fontFamily,
  );

  // 🧘 MICRO TEXT (disclaimer, helper text)
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black45,
    height: 1.3,
    fontFamily: fontFamily,
  );
}
