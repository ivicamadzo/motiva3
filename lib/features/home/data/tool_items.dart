import 'package:flutter/material.dart';

import '../../breathing/screens/breathing_home_screen.dart';
import '../../panic/panic_screen.dart';

class ToolNavItem {
  final IconData icon;
  final String title;
  final Widget Function() screenBuilder;

  ToolNavItem({
    required this.icon,
    required this.title,
    required this.screenBuilder,
  });
}

final toolCards = [
  ToolNavItem(
    icon: Icons.air,
    title: "Дишење",
    screenBuilder: () => BreathingHomeScreen(),
  ),
  ToolNavItem(
    icon: Icons.warning,
    title: "Паника",
    screenBuilder: () => PanicScreen(),
  ),
];
