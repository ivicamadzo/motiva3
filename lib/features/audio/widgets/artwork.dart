import 'package:flutter/material.dart';

class Artwork extends StatelessWidget {
  final String artworkPath;

  const Artwork({super.key, required this.artworkPath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        artworkPath,
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
