import 'package:flutter/material.dart';
import '../audio/core/audio_singleton.dart';

class PanicControls extends StatelessWidget {
  final bool isPlaying;

  const PanicControls({super.key, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    final controller = AudioSingleton.controller;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ⏪ НАЗАД 15 секунди
        IconButton(
          iconSize: 40,
          icon: Icon(Icons.fast_rewind),
          onPressed: () async {
            final currentPos = await controller.engine.positionStream.first;
            final target = currentPos - const Duration(seconds: 15);
            controller.seek(target < Duration.zero ? Duration.zero : target);
          },
        ),

        const SizedBox(width: 20),

        // ⏯️ PLAY / PAUSE
        IconButton(
          iconSize: 72,
          icon: Icon(
            isPlaying
                ? Icons.pause_circle_filled_rounded
                : Icons.play_circle_filled_rounded,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            if (isPlaying) {
              controller.pause();
            } else {
              controller.resume();
            }
          },
        ),

        const SizedBox(width: 20),

        IconButton(
          iconSize: 40,
          icon: Icon(Icons.fast_forward),
          onPressed: () async {
            final currentPos = await controller.engine.positionStream.first;
            controller.seek(currentPos + const Duration(seconds: 15));
          },
        ),
      ],
    );
  }
}
