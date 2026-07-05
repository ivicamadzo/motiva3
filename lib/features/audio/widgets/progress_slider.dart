import 'package:flutter/material.dart';

class ProgressSlider extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final Function(Duration) onSeek;

  const ProgressSlider({
    super.key,
    required this.position,
    required this.duration,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    double sliderValue = duration.inMilliseconds > 0
        ? (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return Slider(
      value: sliderValue,
      activeColor: Theme.of(context).primaryColor,
      inactiveColor: Theme.of(context).primaryColor.withOpacity(0.2),
      onChanged: (val) {
        final newPosition = Duration(
          milliseconds: (val * duration.inMilliseconds).toInt(),
        );
        onSeek(newPosition);
      },
    );
  }
}
