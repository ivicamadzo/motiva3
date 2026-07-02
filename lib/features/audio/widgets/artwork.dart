import 'package:flutter/material.dart';
import '../data/audio_item.dart';

class Artwork extends StatelessWidget {
  final AudioItem item;

  const Artwork({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        item.artwork,
        width: 180,
        height: 180,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 180,
            height: 180,
            color: Colors.red,
            child: Center(
              child: Text("IMG FAIL", style: TextStyle(color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}
