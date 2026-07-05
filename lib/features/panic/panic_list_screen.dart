import 'package:flutter/material.dart';
import '../audio/core/audio_singleton.dart';
import '../audio/data/playlists/panic_playlist.dart';
import 'PanicPlayerScreen.dart';
import 'panic_list_tile.dart';

class PanicListScreen extends StatelessWidget {
  const PanicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(
      "--- Дебагирање: panicPlaylist должина: ${panicPlaylist.length} ---",
    );
    // Ја земаме плејлистата од твојот data фајл
    final playlist = panicPlaylist;

    return Scaffold(
      appBar: AppBar(title: const Text("Panic Relief"), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: playlist.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = playlist[index];
          return PanicListTile(
            item: item,
            onTap: () {
              // 1. Ја поставуваме траката во контролерот
              AudioSingleton.controller.playTrack(item);

              // 2. Навигираме до плеерот
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PanicPlayerScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
