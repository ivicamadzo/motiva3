import 'package:flutter/material.dart';

import '../../breathing/screens/breathing_home_screen.dart';
import '../../sessions/panic/panic_list_screen.dart';
import 'package:motiva3/features/sessions/meditation/screens/meditation_list_screen.dart';

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
    screenBuilder: () => const PanicListScreen(),
  ),

  ToolNavItem(
    icon: Icons.self_improvement,
    title: "Медитација",
    screenBuilder: () => const MeditationListScreen(),
  ),
];
