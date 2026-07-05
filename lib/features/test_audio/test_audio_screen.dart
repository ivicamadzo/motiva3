import 'package:flutter/material.dart';

import '../audio/core/audio_singleton.dart';
import '../audio/data/models/audio_category.dart';
import '../audio/data/models/audio_state.dart';
import '../audio/widgets/mini_player.dart';
// 1. IMPORT YOUR ARTWORK WIDGET
import '../audio/widgets/artwork.dart';

class TestAudioScreen extends StatelessWidget {
  const TestAudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AudioSingleton.controller;

    return Scaffold(
      appBar: AppBar(title: const Text("Audio Test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Test Playlists",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 🎯 PLAY CATEGORY BUTTONS
            ElevatedButton(
              onPressed: () => controller.playCategory(AudioCategory.test),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                "Play TEST Playlist",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => controller.playCategory(AudioCategory.panic),
              child: const Text("Play Panic Playlist"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () =>
                  controller.playCategory(AudioCategory.overthinking),
              child: const Text("Play Overthinking Playlist"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () =>
                  controller.playCategory(AudioCategory.rumination),
              child: const Text("Play Rumination Playlist"),
            ),

            const Divider(height: 32),

            const Text(
              "Current Status",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 🎧 STATE MONITORING & CONTROLS
            Expanded(
              child: StreamBuilder<AudioState>(
                stream: controller
                    .stateStream, // ИЗМЕНЕТО: Се користи stateStream наместо listenable
                initialData:
                    controller.currentState, // ДОДАДЕНО: За стабилен прв приказ
                builder: (context, snapshot) {
                  final state = snapshot.data;

                  if (state == null || state.currentTrack == null) {
                    return const Center(
                      child: Text(
                        "Nothing is playing right now.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  // ✅ FIX: WRAP THE COLUMN IN A SingleChildScrollView
                  return SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(), // Adds a nice bounce effect
                    child: Column(
                      children: [
                        const SizedBox(height: 16), // A little top padding
                        // 2. SHOW THE IMAGE
                        Artwork(artworkPath: state.currentTrack!.artwork),
                        const SizedBox(height: 24),

                        Text(
                          state.currentTrack!.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Category: ${state.currentCategory?.name ?? 'Unknown'}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 24),

                        // ⏯️ PLAYBACK CONTROLS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 40,
                              icon: const Icon(Icons.skip_previous),
                              onPressed: controller.previous,
                            ),
                            IconButton(
                              iconSize: 64,
                              icon: Icon(
                                state.isPlaying
                                    ? Icons.pause_circle
                                    : Icons.play_circle,
                              ),
                              onPressed: () {
                                if (state.isPlaying) {
                                  controller.pause();
                                } else {
                                  controller.resume();
                                }
                              },
                            ),
                            IconButton(
                              iconSize: 40,
                              icon: const Icon(Icons.skip_next),
                              onPressed: controller.next,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16), // Bottom padding
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // 📱 TEST THE MINI PLAYER
      bottomNavigationBar: MiniPlayer(
        stateStream: controller
            .stateStream, // ИЗМЕНЕТО: Се користи stateStream за да одговара на типот
        onPlayPause: () {
          final state = controller.currentState;
          if (state.isPlaying) {
            controller.pause();
          } else {
            controller.resume();
          }
        },
        onStop: controller.stop,
      ),
    );
  }
}
