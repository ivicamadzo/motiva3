import 'package:flutter/material.dart';

import '../../../theme/theme_exports.dart';

class PsychoCard {
  final String title;
  final String content;

  const PsychoCard({required this.title, required this.content});
}

class PsychoeducationScreen extends StatefulWidget {
  final String title;
  final List<PsychoCard> pages;

  const PsychoeducationScreen({
    super.key,
    required this.title,
    required this.pages,
  });

  @override
  State<PsychoeducationScreen> createState() => _PsychoeducationScreenState();
}

class _PsychoeducationScreenState extends State<PsychoeducationScreen> {
  final PageController _controller = PageController();

  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == widget.pages.length - 1;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = widget.pages[index];

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.md,
                      AppSpacing.md,
                      AppSpacing.lg,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppRadius.largeBorder,
                        border: Border.all(color: AppColors.border),
                        boxShadow: AppShadows.softList,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: MotivaTypography.h2.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.lg),

                            Text(
                              page.content,
                              textAlign: TextAlign.center,
                              style: MotivaTypography.body.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ─────────────────────────────────────
            // PAGE INDICATOR
            // ─────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.pages.length, (index) {
                final bool isActive = _currentPage == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 20 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : AppColors.borderLight,
                    borderRadius: AppRadius.pillBorder,
                  ),
                );
              }),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ─────────────────────────────────────
            // ACTION
            // ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(isLastPage ? 'Разбрав' : 'Следна'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
