import 'package:flutter/material.dart';

import '../data/models/audio_state.dart';
import '../core/audio_singleton.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AudioSingleton.controller;

    return Scaffold(
      appBar: AppBar(title: const Text("Now Playing")),

      body: StreamBuilder<AudioState>(
        stream: controller.stateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state == null || state.currentTrack == null) {
            return const Center(child: Text("No audio playing"));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🎵 TITLE
                Text(
                  state.currentTrack!.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // 📂 CATEGORY
                Text(
                  "Category: ${state.currentCategory}",
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 50),

                // ▶️ PLAY / PAUSE
                IconButton(
                  iconSize: 80,
                  icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    if (state.isPlaying) {
                      controller.pause();
                    } else {
                      controller.resume();
                    }
                  },
                ),

                const SizedBox(height: 20),

                // ⏹ STOP
                ElevatedButton(
                  onPressed: () {
                    controller.stop();
                  },
                  child: const Text("Stop"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
