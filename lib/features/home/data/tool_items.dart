import 'package:flutter/material.dart';

import '../../breathing/screens/breathing_home_screen.dart';

class ToolNavItem {
  final IconData icon;
  final String title;
  final Widget screen;

  const ToolNavItem({
    required this.icon,
    required this.title,
    required this.screen,
  });
}

const toolCards = [
  ToolNavItem(icon: Icons.air, title: "Дишење", screen: BreathingHomeScreen()),
];
