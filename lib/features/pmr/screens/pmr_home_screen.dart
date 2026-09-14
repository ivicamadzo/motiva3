import 'package:flutter/material.dart';

import 'package:motiva3/features/audio/core/audio_singleton.dart';
import 'package:motiva3/features/audio/data/models/audio_category.dart';
import 'package:motiva3/features/audio/data/playlists/pmr_playlist.dart';
import 'package:motiva3/features/audio/screens/audio_screen.dart';

import 'pmr_screen.dart';

class PmrHomeScreen extends StatelessWidget {
  const PmrHomeScreen({super.key});

  void _startGuidedRelaxation(BuildContext context) {
    final item = pmrPlaylist[0];

    final currentTrack = AudioSingleton.controller.currentState.currentTrack;

    if (currentTrack?.assetPath != item.assetPath) {
      AudioSingleton.controller.playTrack(item, category: AudioCategory.pmr);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AudioScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PMR релаксација'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Избери што сакаш да направиш',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // 1. Едукативен дел
          _RelaxationToolCard(
            icon: Icons.menu_book,
            title: 'Научи за ПМР',
            subtitle: 'Што е ПМР и како се прави',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PmrScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          // 2. Водена аудио релаксација
          _RelaxationToolCard(
            icon: Icons.headphones,
            title: 'Водена ПМР релаксација',
            subtitle: 'Следи ги водените инструкции',
            onTap: () {
              _startGuidedRelaxation(context);
            },
          ),
        ],
      ),
    );
  }
}

class _RelaxationToolCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RelaxationToolCard({
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
