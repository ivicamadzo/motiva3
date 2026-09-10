import 'package:flutter/material.dart';

import 'package:motiva3/features/audio/core/audio_singleton.dart';
import 'package:motiva3/features/audio/data/models/audio_category.dart';
import 'package:motiva3/features/audio/data/playlists/panic_playlist.dart';
import 'package:motiva3/features/audio/screens/audio_screen.dart';

class PanicListScreen extends StatelessWidget {
  const PanicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panic Relief'), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: panicPlaylist.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = panicPlaylist[index];

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
              subtitle: const Text('Panic Relief аудио'),
              trailing: const Icon(Icons.play_circle_fill),
              onTap: () {
                final currentTrack =
                    AudioSingleton.controller.currentState.currentTrack;

                if (currentTrack?.assetPath != item.assetPath) {
                  AudioSingleton.controller.playTrack(
                    item,
                    category: AudioCategory.panic,
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