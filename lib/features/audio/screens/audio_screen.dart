import 'package:flutter/material.dart';

import '../core/audio_singleton.dart';
import '../data/models/audio_state.dart';
import '../widgets/artwork.dart';
import '../widgets/progress_slider.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = AudioSingleton.controller;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.pause();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Аудио'), centerTitle: true),

        body: StreamBuilder<AudioState>(
          stream: controller.stateStream,
          initialData: controller.currentState,

          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state == null || state.currentTrack == null) {
              return const Center(child: Text('Нема активно аудио'));
            }

            final track = state.currentTrack!;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),

                child: Column(
                  children: [
                    // ─────────────────────────────
                    // ARTWORK
                    // ─────────────────────────────
                    Artwork(artworkPath: track.artwork),

                    const SizedBox(height: 32),

                    // ─────────────────────────────
                    // TITLE
                    // ─────────────────────────────
                    Text(
                      track.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ─────────────────────────────
                    // CATEGORY
                    // ─────────────────────────────
                    if (state.currentCategory != null)
                      Text(
                        _categoryName(state.currentCategory),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),

                    const SizedBox(height: 32),

                    // ─────────────────────────────
                    // PROGRESS
                    // ─────────────────────────────
                    StreamBuilder<Duration?>(
                      stream: controller.durationStream,
                      initialData: null,

                      builder: (context, durationSnapshot) {
                        final duration = durationSnapshot.data ?? Duration.zero;

                        return StreamBuilder<Duration>(
                          stream: controller.positionStream,
                          initialData: Duration.zero,

                          builder: (context, positionSnapshot) {
                            final position =
                                positionSnapshot.data ?? Duration.zero;

                            final safePosition = position > duration
                                ? duration
                                : position;

                            return Column(
                              children: [
                                ProgressSlider(
                                  position: safePosition,
                                  duration: duration,
                                  onSeek: (value) {
                                    controller.seek(value);
                                  },
                                ),

                                const SizedBox(height: 6),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDuration(safePosition),
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),

                                    Text(
                                      _formatDuration(duration),
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // ─────────────────────────────
                    // MAIN CONTROLS
                    // ─────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // PREVIOUS
                        IconButton(
                          iconSize: 32,
                          onPressed: () {
                            controller.previous();
                          },
                          icon: const Icon(Icons.skip_previous_rounded),
                        ),

                        const SizedBox(width: 12),

                        // REWIND 15
                        IconButton(
                          iconSize: 30,
                          onPressed: () async {
                            final position = await _currentPosition(controller);

                            final newPosition =
                                position - const Duration(seconds: 15);

                            await controller.seek(
                              newPosition < Duration.zero
                                  ? Duration.zero
                                  : newPosition,
                            );
                          },
                          icon: const Icon(Icons.replay_10_rounded),
                        ),

                        const SizedBox(width: 8),

                        // PLAY / PAUSE
                        Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),

                          child: IconButton(
                            iconSize: 42,
                            color: Colors.white,

                            onPressed: () {
                              if (state.isPlaying) {
                                controller.pause();
                              } else {
                                controller.resume();
                              }
                            },

                            icon: Icon(
                              state.isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // FORWARD 15
                        IconButton(
                          iconSize: 30,
                          onPressed: () async {
                            final position = await _currentPosition(controller);

                            final duration = await _currentDuration(controller);

                            final newPosition =
                                position + const Duration(seconds: 15);

                            await controller.seek(
                              newPosition > duration ? duration : newPosition,
                            );
                          },
                          icon: const Icon(Icons.forward_10_rounded),
                        ),

                        const SizedBox(width: 12),

                        // NEXT
                        IconButton(
                          iconSize: 32,
                          onPressed: () {
                            controller.next();
                          },
                          icon: const Icon(Icons.skip_next_rounded),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ─────────────────────────────
                    // STOP
                    // ─────────────────────────────
                    OutlinedButton.icon(
                      onPressed: () async {
                        await controller.stop();

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },

                      icon: const Icon(Icons.stop_rounded),

                      label: const Text('Стоп'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────

  static String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  static String _categoryName(dynamic category) {
    final value = category.toString().split('.').last;

    switch (value) {
      case 'panic':
        return 'Паника';

      case 'overthinking':
        return 'Прекумерно размислување';

      case 'rumination':
        return 'Руминација';

      case 'insomnia':
        return 'Несоница';

      case 'meditation':
        return 'Медитација';

      case 'pmr':
        return 'ПМР';

      default:
        return value;
    }
  }

  static Future<Duration> _currentPosition(dynamic controller) async {
    Duration? position;

    try {
      position = await controller.positionStream.first;
    } catch (_) {}

    return position ?? Duration.zero;
  }

  static Future<Duration> _currentDuration(dynamic controller) async {
    Duration? duration;

    try {
      duration = await controller.durationStream.first;
    } catch (_) {}

    return duration ?? Duration.zero;
  }
}
