import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/features/hadith/data/datasources/hadith_local_data.dart';
import 'package:musliemapp/features/hadith/data/repositories/shamail_repo_impl.dart';
import 'package:musliemapp/features/hadith/domain/usecases/shamail_usecase.dart';
import 'package:musliemapp/features/hadith/presentation/controllers/shamail_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';

class ShamailPage extends StatelessWidget {
  const ShamailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ShamailController(
        shamailUseCase: ShamailUseCase(
          shamailRepo: ShamailRepoImpl(localData: HadithLocalData()),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.secondaryColor),
          );
        }
        if (controller.shamails.isEmpty) {
          return const Center(
            child: Text(
              'لا يوجد بيانات',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        final book = controller.shamails[0];
        final chapters = book.chapters;
        final meta = book.metadata.isNotEmpty ? book.metadata[0] : null;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverHeader(meta?.title ?? 'الشمائل المحمدية'),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final chapter = chapters[index];
                  final chapterHadiths = book.hadiths
                      .where((h) => h.chapterId == chapter.id)
                      .toList();

                  return _ChapterCard(
                    number: index + 1,
                    title: chapter.arabic,
                    hadithCount: chapterHadiths.length,
                    onTap: () {
                      final stories = chapterHadiths.map((h) {
                        return StoryItem(
                          title: chapter.arabic,
                          content: h.arabic,
                        );
                      }).toList();

                      if (stories.isEmpty) {
                        stories.add(
                          StoryItem(
                            title: chapter.arabic,
                            content: 'لا يوجد حديث لهذا الفصل',
                          ),
                        );
                      }

                      Get.to(
                        () => ShowItemPage(stories: stories, initialIndex: 0),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                  );
                }, childCount: chapters.length),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSliverHeader(String title) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Decorative elements
            Positioned(
              top: -30,
              left: -30,
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.secondaryColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.secondaryColor.withOpacity(0.1),
                      border: Border.all(
                        color: AppTheme.secondaryColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_stories_rounded,
                      color: AppTheme.secondaryColor,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'للإمام أبي عيسى الترمذي',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Chapter Card Widget ──────────────────────────────────────────────────────
class _ChapterCard extends StatelessWidget {
  final int number;
  final String title;
  final int hadithCount;
  final VoidCallback onTap;

  const _ChapterCard({
    required this.number,
    required this.title,
    required this.hadithCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.07),
                    Colors.white.withValues(alpha: 0.03),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.secondaryColor.withValues(alpha: 0.18),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Number badge
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppTheme.secondaryColor, Color(0xFFB8860B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.secondaryColor.withValues(
                              alpha: 0.35,
                            ),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          number.toString(),
                          style: const TextStyle(
                            color: Color(0xFF0F2027),
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Chapter info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),
                          if (hadithCount > 0) ...[
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 5,
                                  color: AppTheme.secondaryColor.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '$hadithCount ${hadithCount == 1 ? 'حديث' : 'أحاديث'}',
                                  style: TextStyle(
                                    color: AppTheme.secondaryColor.withValues(
                                      alpha: 0.8,
                                    ),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Chevron
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.secondaryColor.withValues(alpha: 0.1),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        color: AppTheme.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
