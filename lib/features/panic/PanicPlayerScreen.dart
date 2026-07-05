import 'dart:async';
import 'package:flutter/material.dart';

import '../audio/core/audio_singleton.dart';
import '../audio/data/models/audio_state.dart';
import 'panic_widgets.dart'; // Ги вклучува сите Panic виджети со еден ред!

class PanicPlayerScreen extends StatefulWidget {
  const PanicPlayerScreen({super.key});

  @override
  State<PanicPlayerScreen> createState() => _PanicPlayerScreenState();
}

class _PanicPlayerScreenState extends State<PanicPlayerScreen> {
  final controller = AudioSingleton.controller;
  StreamSubscription<AudioState>? _sub;

  @override
  void initState() {
    super.initState();
    _sub = controller.stateStream.listen((state) {
      final track = state.currentTrack;
      if (track == null) return;
      if (mounted) {
        precacheImage(AssetImage(track.artwork), context);
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Now Playing"), centerTitle: true),
      body: StreamBuilder<AudioState>(
        stream: controller.stateStream,
        initialData: controller.currentState,
        builder: (context, snapshot) {
          final state = snapshot.data!;
          final track = state.currentTrack;

          if (track == null) {
            return const Center(child: Text("No audio selected"));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Сега користиме наши компоненти
                PanicArtwork(artworkPath: track.artwork),

                const Spacer(flex: 1),

                PanicInfo(title: track.title),

                const SizedBox(height: 20),

                PanicProgress(controller: controller),

                const SizedBox(height: 20),

                PanicControls(isPlaying: state.isPlaying),

                const Spacer(flex: 3),
              ],
            ),
          );
        },
      ),
    );
  }
}
