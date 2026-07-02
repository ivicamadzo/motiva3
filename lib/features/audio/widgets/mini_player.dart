import 'package:flutter/material.dart';
import '../data/audio_item.dart';
import '../services/audio_service.dart';
import 'play_button.dart';
import 'progress_bar.dart';
import 'artwork.dart';

class MiniPlayer extends StatelessWidget {
  final AudioItem item;
  final AudioService audioService;

  const MiniPlayer({super.key, required this.item, required this.audioService});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Artwork(item: item),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ProgressBar(progress: 0.3),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          PlayButton(audioService: audioService, item: item),
        ],
      ),
    );
  }
}
