import 'package:flutter/material.dart';

import 'package:motiva3/features/breathing/screens/breathing_home_screen.dart';
import 'package:motiva3/features/panic/screens/panic_list_screen.dart';
import 'package:motiva3/features/pmr/screens/pmr_home_screen.dart';

class PanicHomeScreen extends StatelessWidget {
  const PanicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Релаксација'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Избери алатка',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          _PanicToolCard(
            icon: Icons.headphones,
            title: 'Аудио за паника',
            subtitle: 'Слушај водена аудио поддршка',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PanicListScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          _PanicToolCard(
            icon: Icons.air,
            title: 'Дишење',
            subtitle: 'Користи вежби за смирување на дишењето',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BreathingHomeScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          _PanicToolCard(
            icon: Icons.self_improvement,
            title: 'Мускулна релаксација',
            subtitle: 'Вежби за опуштање на мускулите',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PmrHomeScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PanicToolCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PanicToolCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
