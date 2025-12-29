import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
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
  double fontSize = 18;

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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStory = widget.stories[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text(currentStory.title)),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.surfaceColor, Color(0xFFE8F5E9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    currentStory.content,
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    style: AppTheme.bodyText.copyWith(
                      fontSize: fontSize,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlBtn(
                    Icons.arrow_forward_ios,
                    _nextStory,
                    "التالي",
                  ),
                  _buildControlBtn(
                    Icons.zoom_in,
                    () => setState(() => fontSize++),
                    "تكبير",
                  ),
                  _buildControlBtn(Icons.share, () {
                    Share.share(currentStory.content);
                  }, "مشاركة"),
                  _buildControlBtn(
                    Icons.zoom_out,
                    () => setState(() => fontSize--),
                    "تصغير",
                  ),
                  _buildControlBtn(
                    Icons.arrow_back_ios_new,
                    _previousStory,
                    "السابق",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBtn(
    IconData icon,
    VoidCallback onPressed,
    String tooltip,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppTheme.primaryColor),
        tooltip: tooltip,
      ),
    );
  }
}
