import 'package:flutter/material.dart';
import '../audio/widgets/artwork.dart';

class PanicArtwork extends StatelessWidget {
  final String artworkPath;

  const PanicArtwork({super.key, required this.artworkPath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Artwork(artworkPath: artworkPath),
        ),
      ),
    );
  }
}
