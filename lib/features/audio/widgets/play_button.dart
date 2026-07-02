import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPressed;

  const PlayButton({
    super.key,
    required this.isPlaying,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
      label: Text(isPlaying ? "Pause" : "Play"),
    );
  }
}
