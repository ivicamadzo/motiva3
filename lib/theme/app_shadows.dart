import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  // ─────────────────────────────────────────────
  // SOFT CARD
  // ─────────────────────────────────────────────

  static const BoxShadow soft = BoxShadow(
    color: Color(0x24000000),
    blurRadius: 20,
    spreadRadius: 0,
    offset: Offset(0, 8),
  );

  // ─────────────────────────────────────────────
  // ELEVATED CARD
  // ─────────────────────────────────────────────

  static const BoxShadow elevated = BoxShadow(
    color: Color(0x30000000),
    blurRadius: 28,
    spreadRadius: 0,
    offset: Offset(0, 12),
  );

  // ─────────────────────────────────────────────
  // SUBTLE
  // ─────────────────────────────────────────────

  static const BoxShadow subtle = BoxShadow(
    color: Color(0x18000000),
    blurRadius: 10,
    spreadRadius: 0,
    offset: Offset(0, 4),
  );

  // ─────────────────────────────────────────────
  // PRIMARY GLOW
  // ─────────────────────────────────────────────

  static const BoxShadow primaryGlow = BoxShadow(
    color: Color(0x407C70E5),
    blurRadius: 24,
    spreadRadius: 0,
    offset: Offset(0, 4),
  );

  // ─────────────────────────────────────────────
  // STRONG PRIMARY GLOW
  // ─────────────────────────────────────────────

  static const BoxShadow primaryGlowStrong = BoxShadow(
    color: Color(0x557C70E5),
    blurRadius: 32,
    spreadRadius: 2,
    offset: Offset(0, 6),
  );

  // ─────────────────────────────────────────────
  // DANGER / PANIC GLOW
  // ─────────────────────────────────────────────

  static const BoxShadow dangerGlow = BoxShadow(
    color: Color(0x35E9788C),
    blurRadius: 24,
    spreadRadius: 0,
    offset: Offset(0, 4),
  );

  // ─────────────────────────────────────────────
  // SHADOW LISTS
  // ─────────────────────────────────────────────

  static const List<BoxShadow> softList = [soft];

  static const List<BoxShadow> elevatedList = [elevated];

  static const List<BoxShadow> subtleList = [subtle];

  static const List<BoxShadow> primaryGlowList = [primaryGlow];

  static const List<BoxShadow> primaryGlowStrongList = [primaryGlowStrong];

  static const List<BoxShadow> dangerGlowList = [dangerGlow];
}
