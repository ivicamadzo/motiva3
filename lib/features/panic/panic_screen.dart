import 'dart:async';

import 'package:flutter/material.dart';

import '../audio/core/audio_singleton.dart';
import '../audio/data/models/audio_category.dart';
import '../audio/data/models/audio_state.dart';
import '../audio/widgets/artwork.dart';
import '../audio/widgets/progress_slider.dart';

class PanicScreen extends StatefulWidget {
  const PanicScreen({super.key});

  @override
  State<PanicScreen> createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen> {
  final controller = AudioSingleton.controller;
  StreamSubscription<AudioState>? _sub;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 250));
      if (!mounted) return;
      await controller.playCategory(AudioCategory.panic);
    });

    _sub = controller.stateStream.listen((state) {
      final track = state.currentTrack;
      if (track == null) return;
      if (mounted) {
        precacheImage(AssetImage(track.artwork), context);
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  // 🔥 ПОМОШНА ФУНКЦИЈА: Ги претвора милисекундите во "минути:секунди" формат
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Panic Mode"), centerTitle: true),
      // Користиме StreamBuilder наместо ValueListenableBuilder
      body: StreamBuilder<AudioState>(
        stream: controller.stateStream,
        initialData: controller.currentState,
        builder: (context, snapshot) {
          // Ги земаме податоците од snapshot
          final state = snapshot.data!;
          final track = state.currentTrack;

          if (track == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // 1. Уметничка слика со заоблени агли и дискретна сенка
                Center(
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
                      child: Artwork(artworkPath: track.artwork),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // 2. Информации за песната
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            track.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Motiva Mindset",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border, size: 26),
                      onPressed: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 3. ДИНАМИЧЕН ПРОГРЕС БАР (ОПТИМИЗИРАН)
                StreamBuilder<Duration?>(
                  stream: controller.durationStream,
                  initialData: Duration.zero, // Стави почетна вредност
                  builder: (context, durationSnapshot) {
                    final duration = durationSnapshot.data ?? Duration.zero;

                    return StreamBuilder<Duration>(
                      stream: controller.positionStream,
                      initialData: Duration.zero,
                      builder: (context, positionSnapshot) {
                        final position = positionSnapshot.data ?? Duration.zero;

                        return Column(
                          children: [
                            // Го користиме новиот виджет
                            ProgressSlider(
                              position: position,
                              duration: duration,
                              onSeek: (newPos) => controller.seek(newPos),
                            ),

                            // Ги враќаме текстовите за времето тука
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDuration(position),
                                    style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "-${_formatDuration(duration - position)}",
                                    style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 20),

                // 4. Редизајниран ред со аудио контроли (Динамичен и чист распоред)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Копче за СТОП
                    IconButton(
                      icon: const Icon(Icons.stop_rounded, size: 36),
                      onPressed: () async {
                        await controller.stop();
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),

                    // ДИНАМИЧНО ГЛАВНО КОПЧЕ (Автоматски менува Play ⇆ Pause)
                    IconButton(
                      icon: Icon(
                        state.isPlaying
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_filled_rounded,
                        size: 72,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if (state.isPlaying) {
                          controller.pause();
                        } else {
                          controller.resume();
                        }
                      },
                    ),
                  ],
                ),

                const Spacer(flex: 3),
              ],
            ),
          );
        },
      ),
    );
  }
}
