import 'package:flutter/material.dart';

import '../../psychoeducation/psychoeducation_exports.dart';

class PsychoeducationNavItem {
  final IconData icon;
  final String title;
  final Widget Function() screenBuilder;

  PsychoeducationNavItem({
    required this.icon,
    required this.title,
    required this.screenBuilder,
  });
}

final psychoeducationCards = [
  PsychoeducationNavItem(
    icon: Icons.people_outline,
    title: "Социјална\nанксиозност",
    screenBuilder: () => SocialAnxietyScreen(),
  ),

  PsychoeducationNavItem(
    icon: Icons.psychology_outlined,
    title: "Интрузивни\nмисли",
    screenBuilder: () => IntrusiveThoughtsScreen(),
  ),

  PsychoeducationNavItem(
    icon: Icons.schedule_outlined,
    title: "Антиципаторна\nанксиозност",
    screenBuilder: () => AnticipatoryAnxietyScreen(),
  ),

  PsychoeducationNavItem(
    icon: Icons.loop,
    title: "Overthinking",
    screenBuilder: () => OverthinkingScreen(),
  ),

  PsychoeducationNavItem(
    icon: Icons.visibility_outlined,
    title: "Страв од\nосуда",
    screenBuilder: () => FearOfJudgmentScreen(),
  ),

  PsychoeducationNavItem(
    icon: Icons.help_outline,
    title: "Потреба за\nуверување",
    screenBuilder: () => ReassuranceScreen(),
  ),
];
