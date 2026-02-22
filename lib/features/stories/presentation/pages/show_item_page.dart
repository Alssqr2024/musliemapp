import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class StoryItem {
  final String title;
  final String content;

  StoryItem({required this.title, required this.content});
}

class ShowItemPage extends StatefulWidget {
  final List<StoryItem> stories;
  final int initialIndex;

  const ShowItemPage({
    super.key,
    required this.stories,
    required this.initialIndex,
  });

  @override
  State<ShowItemPage> createState() => _ShowItemPageState();
}

class _ShowItemPageState extends State<ShowItemPage> {
  late int currentIndex;
  double fontSize = 20;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void _nextStory() {
    if (currentIndex < widget.stories.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Get.snackbar(
        'تنبيه',
        'هذا آخر حديث',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white10,
        colorText: Colors.white,
        borderRadius: 20,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  void _previousStory() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    } else {
      Get.snackbar(
        'تنبيه',
        'هذا أول حديث',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white10,
        colorText: Colors.white,
        borderRadius: 20,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStory = widget.stories[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0F2027),
      body: Stack(
        children: [
          // Background Gradient
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

          SafeArea(
            child: Column(
              children: [
                // Custom Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        iconSize: 20,
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.05),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          currentStory.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            shadows: [
                              Shadow(blurRadius: 10, color: Colors.black26),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.08),
                                Colors.white.withOpacity(0.02),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.auto_stories_rounded,
                                color: const Color(0xFFFFD700).withOpacity(0.5),
                                size: 30,
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: SelectableText(
                                    currentStory.content,
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize,
                                      height: 2.0,
                                      fontWeight: FontWeight.w500,
                                      shadows: const [
                                        Shadow(
                                          blurRadius: 8,
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Indicators
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${currentIndex + 1} من ${widget.stories.length}",
                      style: const TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Bottom Controls
                _buildBottomControls(currentStory),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls(StoryItem story) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildControlBtn(
              Icons.arrow_forward_ios_rounded,
              _nextStory,
              "التالي",
            ),
            _buildControlBtn(
              Icons.add_rounded,
              () => setState(() => fontSize += 2),
              "تكبير",
            ),
            _buildControlBtn(
              Icons.share_rounded,
              () => Share.share(story.content),
              "مشاركة",
              isPrimary: true,
            ),
            _buildControlBtn(
              Icons.remove_rounded,
              () => setState(() => fontSize -= 2),
              "تصغير",
            ),
            _buildControlBtn(
              Icons.arrow_back_ios_new_rounded,
              _previousStory,
              "السابق",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBtn(
    IconData icon,
    VoidCallback onPressed,
    String tooltip, {
    bool isPrimary = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary
            ? const Color(0xFFFFD700).withOpacity(0.15)
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPrimary
              ? const Color(0xFFFFD700).withOpacity(0.3)
              : Colors.white.withOpacity(0.1),
        ),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: const Color(0xFFFFD700).withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isPrimary ? const Color(0xFFFFD700) : Colors.white70,
          size: 22,
        ),
        tooltip: tooltip,
      ),
    );
  }
}
