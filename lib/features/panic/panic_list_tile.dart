import 'package:flutter/material.dart';
import '../audio/data/models/audio_item.dart';

class PanicListTile extends StatelessWidget {
  final AudioItem item;
  final VoidCallback onTap;

  const PanicListTile({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            item.artwork,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.music_note),
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: const Text("Motiva Audio"),
        trailing: const Icon(Icons.play_circle_fill, color: Colors.blueAccent),
        onTap: onTap,
      ),
    );
  }
}
