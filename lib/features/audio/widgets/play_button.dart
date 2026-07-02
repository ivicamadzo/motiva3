import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../data/audio_item.dart';

class PlayButton extends StatefulWidget {
  final AudioService audioService;
  final AudioItem item;

  const PlayButton({super.key, required this.audioService, required this.item});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool isPlaying = false;

  void toggle() async {
    if (isPlaying) {
      await widget.audioService.stop();
    } else {
      await widget.audioService.play(widget.item);
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: toggle,
      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
      label: Text(isPlaying ? "Pause" : "Play"),
    );
  }
}
