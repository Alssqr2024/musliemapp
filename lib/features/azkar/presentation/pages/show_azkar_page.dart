import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:musliemapp/features/azkar/domain/entities/azkar.dart';

class ShowAzkarPage extends StatefulWidget {
  const ShowAzkarPage({super.key, required this.data, this.title});
  final String? title;
  final List<Array> data;
  @override
  State<ShowAzkarPage> createState() => _ShowAzkarPageState();
}

class _ShowAzkarPageState extends State<ShowAzkarPage> {
  double fontSize = 18;
  int indexItem = 0;
  PageController controller = PageController();
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
          backgroundColor: AppTheme.primaryColor.withOpacity(0.8),
          colorText: Colors.white,
        );
      } else {
        controller.nextPage(
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
          backgroundColor: AppTheme.primaryColor.withOpacity(0.8),
          colorText: Colors.white,
        );
      } else {
        controller.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? 'الأذكار')),
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
              child: PageView.builder(
                controller: controller,
                itemCount: _azkarList.length,
                itemBuilder: (context, index) {
                  return Container(
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
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              _azkarList[index].text,
                              textAlign: TextAlign.center,
                              style: AppTheme.bodyText.copyWith(
                                fontSize: fontSize,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: DashedCircularProgressBar.aspectRatio(
                            aspectRatio: 2,
                            valueNotifier: ValueNotifier(
                              _azkarList[index].count.toDouble(),
                            ),
                            progress: _azkarList[index].count.toDouble(),
                            maxProgress:
                                _initialCounts[_azkarList[index].id]
                                    ?.toDouble() ??
                                1,
                            corners: StrokeCap.round,
                            foregroundColor: AppTheme.primaryColor,
                            backgroundColor: Colors.grey.shade200,
                            foregroundStrokeWidth: 6,
                            backgroundStrokeWidth: 6,
                            animation: true,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_azkarList[index].count > 1) {
                                      _azkarList[index].count--;
                                    } else {
                                      // Count reached 0, remove item
                                      _azkarList.removeAt(index);
                                      if (_azkarList.isEmpty) {
                                        Get.back(); // Return if list is empty
                                      } else {
                                        if (indexItem >= _azkarList.length) {
                                          indexItem = _azkarList.length - 1;
                                          controller.jumpToPage(indexItem);
                                        }
                                      }
                                    }
                                  });
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.primaryColor.withOpacity(
                                      0.1,
                                    ),
                                  ),
                                  child: Text(
                                    _azkarList[index].count.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                onPageChanged: (value) {
                  setState(() {
                    indexItem = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "${indexItem + 1}/${_azkarList.length}",
                style: AppTheme.caption,
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
                    () => stirring(true),
                    "التالي",
                  ),
                  _buildControlBtn(
                    Icons.zoom_in,
                    () => setState(() => fontSize++),
                    "تكبير",
                  ),
                  _buildControlBtn(Icons.share, () {
                    Share.share(_azkarList[indexItem].text);
                  }, "مشاركة"),
                  _buildControlBtn(
                    Icons.zoom_out,
                    () => setState(() => fontSize--),
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
