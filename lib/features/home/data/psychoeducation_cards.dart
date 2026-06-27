import 'package:flutter/material.dart';

import '../../psychoeducation/psychoeducation_exports.dart';

class HelpItem {
  final IconData icon;
  final String title;
  final Widget screen;

  const HelpItem({
    required this.icon,
    required this.title,
    required this.screen,
  });
}

const psychoeducationCards = [
  HelpItem(
    icon: Icons.people_outline,
    title: "Социјална\nанксиозност",
    screen: SocialAnxietyScreen(),
  ),

  HelpItem(
    icon: Icons.psychology_outlined,
    title: "Интрузивни\nмисли",
    screen: IntrusiveThoughtsScreen(),
  ),

  HelpItem(
    icon: Icons.schedule_outlined,
    title: "Антиципаторна\nанксиозност",
    screen: AnticipatoryAnxietyScreen(),
  ),

  HelpItem(
    icon: Icons.loop,
    title: "Overthinking",
    screen: OverthinkingScreen(),
  ),

  HelpItem(
    icon: Icons.visibility_outlined,
    title: "Страв од\nосуда",
    screen: FearOfJudgmentScreen(),
  ),

  HelpItem(
    icon: Icons.help_outline,
    title: "Потреба за\nуверување",
    screen: ReassuranceScreen(),
  ),
];
