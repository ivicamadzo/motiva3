import 'package:flutter/material.dart';

import '../../psychoeducation/psychoeducation_exports.dart';

class PsychoeducationNavItem {
  final IconData icon;
  final String title;
  final Widget screen;

  const PsychoeducationNavItem({
    required this.icon,
    required this.title,
    required this.screen,
  });
}

const psychoeducationCards = [
  PsychoeducationNavItem(
    icon: Icons.people_outline,
    title: "Социјална\nанксиозност",
    screen: SocialAnxietyScreen(),
  ),

  PsychoeducationNavItem(
    icon: Icons.psychology_outlined,
    title: "Интрузивни\nмисли",
    screen: IntrusiveThoughtsScreen(),
  ),

  PsychoeducationNavItem(
    icon: Icons.schedule_outlined,
    title: "Антиципаторна\nанксиозност",
    screen: AnticipatoryAnxietyScreen(),
  ),

  PsychoeducationNavItem(
    icon: Icons.loop,
    title: "Overthinking",
    screen: OverthinkingScreen(),
  ),

  PsychoeducationNavItem(
    icon: Icons.visibility_outlined,
    title: "Страв од\nосуда",
    screen: FearOfJudgmentScreen(),
  ),

  PsychoeducationNavItem(
    icon: Icons.help_outline,
    title: "Потреба за\nуверување",
    screen: ReassuranceScreen(),
  ),
];
