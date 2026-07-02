import 'package:flutter/material.dart';
import '../audio/services/audio_service.dart';
import '../audio/data/playlist.dart';
import '../audio/widgets/artwork.dart';

class PanicScreen extends StatefulWidget {
  const PanicScreen({super.key});

  @override
  State<PanicScreen> createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen> {
  final AudioService audio = AudioService();

  static bool _played = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_played) {
        _played = true;
        await audio.play(welcomeTrack);
      }
    });
  }

  @override
  void dispose() {
    audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panic Mode")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🎨 Thumbnail
            Artwork(item: welcomeTrack),

            const SizedBox(height: 20),

            // 🎵 Title
            Text(
              welcomeTrack.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // 🌿 Calm UI placeholder
            const Text(
              "Breathing / Calm UI here",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
