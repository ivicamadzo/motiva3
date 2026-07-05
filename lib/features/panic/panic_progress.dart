// lib/features/panic/panic_progress.dart
import 'package:flutter/material.dart';
import '../audio/core/audio_controller.dart'; // Или каде и да ти е AudioController
import '../audio/widgets/progress_slider.dart';

class PanicProgress extends StatelessWidget {
  final AudioController controller;

  const PanicProgress({super.key, required this.controller});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
      stream: controller.durationStream,
      initialData: Duration.zero,
      builder: (context, durationSnapshot) {
        final duration = durationSnapshot.data ?? Duration.zero;

        return StreamBuilder<Duration>(
          stream: controller.positionStream,
          initialData: Duration.zero,
          builder: (context, positionSnapshot) {
            final position = positionSnapshot.data ?? Duration.zero;

            return Column(
              children: [
                ProgressSlider(
                  position: position,
                  duration: duration,
                  onSeek: (newPos) => controller.seek(newPos),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(position)),
                      Text("-${_formatDuration(duration - position)}"),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
