import 'dart:ui';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';
import 'package:musliemapp/features/azkar/domain/entities/azkar.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';

class ShowAzkarPage extends StatefulWidget {
  const ShowAzkarPage({super.key, required this.data, this.title});
  final String? title;
  final List<Array> data;
  @override
  State<ShowAzkarPage> createState() => _ShowAzkarPageState();
}

class _ShowAzkarPageState extends State<ShowAzkarPage> {
  double fontSize = 20;
  int indexItem = 0;
  PageController pageController = PageController();
  late List<Array> _azkarList;
  final Map<int, int> _initialCounts = {};

  @override
  void initState() {
    super.initState();
    _azkarList = List.from(widget.data);
    for (var item in _azkarList) {
      _initialCounts[item.id] = item.count;
    }
  }

  void stirring(bool next) {
    if (next) {
      if (indexItem >= _azkarList.length - 1) {
        Get.snackbar(
          "تنبيه",
          "وصلت للنهاية",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white10,
          colorText: Colors.white,
          borderRadius: 20,
          margin: const EdgeInsets.all(16),
        );
      } else {
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    } else {
      if (indexItem <= 0) {
        Get.snackbar(
          "تنبيه",
          "وصلت للبداية",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white10,
          colorText: Colors.white,
          borderRadius: 20,
          margin: const EdgeInsets.all(16),
        );
      } else {
        pageController.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SafeArea(
            child: Column(
              children: [
                // Custom Top Bar (Alternative to AppBar for more control)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.title ?? 'الأذكار',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            height: 1.2,
                            shadows: [
                              Shadow(blurRadius: 10, color: Colors.black26),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Spacer for balance
                    ],
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: _azkarList.length,
                    onPageChanged: (value) => setState(() => indexItem = value),
                    itemBuilder: (context, index) {
                      final item = _azkarList[index];
                      final initialCount = _initialCounts[item.id] ?? 1;

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.08),
                                    Colors.white.withValues(alpha: 0.02),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Decorative Icon
                                  Icon(
                                    Icons.auto_awesome_rounded,
                                    color: const Color(
                                      0xFFFFD700,
                                    ).withValues(alpha: 0.5),
                                    size: 30,
                                  ),
                                  const SizedBox(height: 16),
                                  // Content Text
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: SelectableText(
                                          item.text,
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSize,
                                            height: 1.8,
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
                                  ),
                                  const Divider(color: Colors.white10),
                                  // Counter
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "التكرار المطلوب: $initialCount",
                                            style: TextStyle(
                                              color: Colors.white.withValues(alpha: 
                                                0.5,
                                              ),
                                              fontSize: 13,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: _buildCounterCircle(
                                              item,
                                              index,
                                              initialCount,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${indexItem + 1} من ${_azkarList.length}",
                      style: const TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Bottom Controls
                _buildBottomControls(),
              ],
            ),
          ),
    );
  }

  Widget _buildCounterCircle(Array item, int index, int initialCount) {
    return DashedCircularProgressBar(
      width: 180,
      height: 180,
      valueNotifier: ValueNotifier(item.count.toDouble()),
      progress: item.count.toDouble(),
      maxProgress: initialCount.toDouble(),
      corners: StrokeCap.round,
      foregroundColor: const Color(0xFFFFD700),
      backgroundColor: Colors.white.withValues(alpha: 0.05),
      foregroundStrokeWidth: 8,
      backgroundStrokeWidth: 4,
      animation: true,
      child: Center(
        child: InkWell(
          onTap: () => _handleCountClick(index),
          borderRadius: BorderRadius.circular(50),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 85,
            height: 85,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
              border: Border.all(
                color: const Color(0xFFFFD700).withValues(alpha: 0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFD700).withValues(alpha: 0.1),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Text(
              item.count.toString(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD700),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleCountClick(int index) {
    setState(() {
      if (_azkarList[index].count > 1) {
        _azkarList[index].count--;
      } else {
        // Finished this one
        if (_azkarList.length > 1) {
          _azkarList.removeAt(index);
          if (indexItem >= _azkarList.length) {
            indexItem = _azkarList.length - 1;
            pageController.jumpToPage(indexItem);
          }
        } else {
          Get.back(); // Finished all
        }
      }
    });
  }

  Widget _buildBottomControls() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlBtn(
                  Icons.arrow_forward_ios,
                  () => stirring(true),
                  "التالي",
                ),
                _buildControlBtn(
                  Icons.zoom_in,
                  () => setState(() => fontSize += 2),
                  "تكبير",
                ),
                _buildControlBtn(
                  Icons.share_rounded,
                  // ignore: deprecated_member_use
                  () => Share.share(_azkarList[indexItem].text),
                  "مشاركة",
                ),
                _buildControlBtn(
                  Icons.zoom_out,
                  () => setState(() => fontSize -= 2),
                  "تصغير",
                ),
                _buildControlBtn(
                  Icons.arrow_back_ios_new,
                  () => stirring(false),
                  "السابق",
                ),
              ],
            ),
          ),
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
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 22),
        tooltip: tooltip,
      ),
    );
  }
}
