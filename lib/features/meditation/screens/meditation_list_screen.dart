import 'package:flutter/material.dart';

import 'package:motiva3/features/audio/core/audio_singleton.dart';
import 'package:motiva3/features/audio/data/models/audio_category.dart';
import 'package:motiva3/features/audio/data/playlists/meditation_playlist.dart';
import 'package:motiva3/features/audio/screens/audio_screen.dart';

class MeditationListScreen extends StatelessWidget {
  const MeditationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Медитација'), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: meditationPlaylist.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = meditationPlaylist[index];

          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.artwork,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(item.title),
              subtitle: const Text('Водена аудио медитација'),
              trailing: const Icon(Icons.play_circle_fill),
              onTap: () {
                final currentTrack =
                    AudioSingleton.controller.currentState.currentTrack;

                if (currentTrack?.assetPath != item.assetPath) {
                  AudioSingleton.controller.playTrack(
                    item,
                    category: AudioCategory.meditation,
                  );
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AudioScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
