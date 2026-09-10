import 'package:flutter/material.dart';

import 'package:motiva3/features/audio/core/audio_singleton.dart';
import 'package:motiva3/features/audio/data/models/audio_category.dart';
import 'package:motiva3/features/audio/data/playlists/pmr_playlist.dart';
import 'package:motiva3/features/audio/screens/audio_screen.dart';

import '../data/pmr_data.dart';

class PmrScreen extends StatefulWidget {
  const PmrScreen({super.key});

  @override
  State<PmrScreen> createState() => _PmrScreenState();
}

class _PmrScreenState extends State<PmrScreen> {
  final PageController _controller = PageController();

  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < pmrPages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _startGuidedRelaxation();
    }
  }

  void _startGuidedRelaxation() {
    final item = pmrPlaylist[0];

    final currentTrack = AudioSingleton.controller.currentState.currentTrack;

    if (currentTrack?.assetPath != item.assetPath) {
      AudioSingleton.controller.playTrack(item, category: AudioCategory.pmr);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AudioScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Прогресивна мускулна релаксација'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pmrPages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final page = pmrPages[index];

                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            page.content,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pmrPages.length,
              (index) => Container(
                margin: const EdgeInsets.all(4),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _nextPage,
                icon: Icon(
                  _currentPage == pmrPages.length - 1
                      ? Icons.headphones
                      : Icons.arrow_forward,
                ),
                label: Text(
                  _currentPage == pmrPages.length - 1
                      ? 'Започни водена релаксација'
                      : 'Следна',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
