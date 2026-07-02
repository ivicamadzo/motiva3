import 'package:flutter/material.dart';

import '../audio/core/audio_singleton.dart';
import '../audio/data/models/audio_category.dart';
import '../audio/widgets/artwork.dart';
import '../audio/data/models/audio_state.dart';

class PanicScreen extends StatefulWidget {
  const PanicScreen({super.key});

  @override
  State<PanicScreen> createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen> {
  @override
  void initState() {
    super.initState();

    // Defer autoplay slightly so the UI can finish the first frame
    // and avoid jank caused by asset loading.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 250), () {
        AudioSingleton.controller.playCategory(AudioCategory.panic);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panic Mode")),

      body: StreamBuilder<AudioState>(
        stream: AudioSingleton.controller.stateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state == null || state.currentTrack == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final track = state.currentTrack!;

          // Ensure artwork is precached so the thumbnail appears immediately
          // and avoids a frame hitch when Image.asset decodes it.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            precacheImage(AssetImage(track.artwork), context);
          });

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Artwork(artworkPath: track.artwork),

              const SizedBox(height: 20),

              Text(
                track.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: AudioSingleton.controller.pause,
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: AudioSingleton.controller.resume,
                  ),
                  IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: AudioSingleton.controller.stop,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
