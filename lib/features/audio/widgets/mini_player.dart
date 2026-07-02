import 'package:flutter/material.dart';
import '../data/models/audio_state.dart';

class MiniPlayer extends StatelessWidget {
  final Stream<AudioState> stateStream;
  final VoidCallback onPlayPause;
  final VoidCallback onStop;

  const MiniPlayer({
    super.key,
    required this.stateStream,
    required this.onPlayPause,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AudioState>(
      stream: stateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state == null || state.currentTrack == null) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Colors.black87,
            border: Border(top: BorderSide(color: Colors.white12)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.currentTrack!.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state.currentCategory?.name ?? "",
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: onPlayPause,
                icon: Icon(
                  state.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),

              IconButton(
                onPressed: onStop,
                icon: const Icon(Icons.stop, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
