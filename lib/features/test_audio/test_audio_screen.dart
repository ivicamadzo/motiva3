import 'package:flutter/material.dart';

import '../audio/data/models/audio_category.dart';
import '../audio/widgets/mini_player.dart';
import '../audio/core/audio_singleton.dart';

class TestAudioScreen extends StatefulWidget {
  const TestAudioScreen({super.key});

  @override
  State<TestAudioScreen> createState() => _TestAudioScreenState();
}

class _TestAudioScreenState extends State<TestAudioScreen> {
  final controller = AudioSingleton.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio Test")),

      body: Column(
        children: [
          const SizedBox(height: 40),

          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.playCategory(AudioCategory.panic);
                  },
                  child: const Text("Play Panic"),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    controller.pause();
                  },
                  child: const Text("Pause"),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    controller.resume();
                  },
                  child: const Text("Resume"),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    controller.stop();
                  },
                  child: const Text("Stop"),
                ),
              ],
            ),
          ),

          const Spacer(),

          MiniPlayer(
            stateStream: controller.stateStream,
            onPlayPause: () {
              final state = controller.state;

              if (state.isPlaying) {
                controller.pause();
              } else {
                controller.resume();
              }
            },
            onStop: () {
              controller.stop();
            },
          ),
        ],
      ),
    );
  }
}
