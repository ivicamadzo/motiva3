import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../data/playlist.dart';
import '../widgets/artwork.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioService audio = AudioService();

  @override
  void dispose() {
    audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Artwork(item: welcomeTrack),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => audio.play(welcomeTrack),
              child: const Text("Play"),
            ),

            ElevatedButton(
              onPressed: () => audio.stop(),
              child: const Text("Stop"),
            ),
          ],
        ),
      ),
    );
  }
}
