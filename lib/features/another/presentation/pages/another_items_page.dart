import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/bindings/another_binding.dart';
import 'package:musliemapp/features/another/domain/usecases/get_another_items_usecase.dart';
import 'package:musliemapp/features/another/presentation/controllers/another_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';

class AnotherItemsPage extends StatelessWidget {
  final String title;
  final String jsonFile;

  const AnotherItemsPage({
    super.key,
    required this.title,
    required this.jsonFile,
  });

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<GetAnotherItemsUseCase>()) {
      AnotherBinding().dependencies();
    }
    if (!Get.isRegistered<AnotherController>(tag: jsonFile)) {
      Get.put(
        AnotherController(getAnotherItemsUseCase: Get.find<GetAnotherItemsUseCase>()),
        tag: jsonFile,
      );
    }
    final controller = Get.find<AnotherController>(tag: jsonFile);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchItems(jsonFile);
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0F2027),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFFFD700)),
          );
        }
        if (controller.items.isEmpty) {
          return const Center(
            child: Text(
              'لا يوجد بيانات',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverHeader(),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = controller.items[index];
                  final preview = item.content.length > 150
                      ? '${item.content.replaceAll('\n', ' ').substring(0, 150)}...'
                      : item.content.replaceAll('\n', ' ');

                  return _ItemCard(
                    number: index + 1,
                    title: item.title,
                    preview: preview,
                    onTap: () {
                      final stories = controller.items.map((e) {
                        return StoryItem(title: e.title, content: e.content);
                      }).toList();
                      Get.to(
                        () =>
                            ShowItemPage(stories: stories, initialIndex: index),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                  );
                }, childCount: controller.items.length),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSliverHeader() {
    IconData headerIcon = Icons.auto_stories_rounded;
    if (title.contains('وصية')) headerIcon = Icons.star_outline_rounded;
    if (title.contains('الإيمان')) headerIcon = Icons.favorite_border_rounded;
    if (title.contains('الجنة')) headerIcon = Icons.landscape_rounded;
    if (title.contains('الرقية')) headerIcon = Icons.shield_moon_outlined;
    if (title.contains('سنن')) headerIcon = Icons.event_repeat_rounded;
    if (title.contains('فرص')) headerIcon = Icons.auto_awesome_outlined;

    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: const Color(0xFF0F2027),
      elevation: 0,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 2),
              ),
            ],
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFD700).withOpacity(0.1),
                      border: Border.all(
                        color: const Color(0xFFFFD700).withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      headerIcon,
                      color: const Color(0xFFFFD700),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'قائمة المحتويات المتاحة',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13,
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

class _ItemCard extends StatefulWidget {
  final int number;
  final String title;
  final String preview;
  final VoidCallback onTap;

  const _ItemCard({
    required this.number,
    required this.title,
    required this.preview,
    required this.onTap,
  });

  @override
  State<_ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<_ItemCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
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
                  color: const Color(
                    0xFFFFD700,
                  ).withOpacity(_expanded ? 0.35 : 0.15),
                  width: 1,
                ),
                boxShadow: _expanded
                    ? [
                        BoxShadow(
                          color: const Color(0xFFFFD700).withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFD700), Color(0xFFB8860B)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFD700).withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              widget.number.toString(),
                              style: const TextStyle(
                                color: Color(0xFF0F2027),
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                              if (_expanded) ...[
                                const SizedBox(height: 10),
                                const Divider(color: Colors.white10, height: 1),
                                const SizedBox(height: 10),
                                Text(
                                  widget.preview,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => setState(() => _expanded = !_expanded),
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 300),
                            turns: _expanded ? 0.25 : 0,
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: Color(0xFFFFD700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_expanded)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: widget.onTap,
                            icon: const Icon(
                              Icons.menu_book_rounded,
                              size: 16,
                              color: Color(0xFFFFD700),
                            ),
                            label: const Text(
                              'عرض التفاصيل',
                              style: TextStyle(
                                color: Color(0xFFFFD700),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(
                                0xFFFFD700,
                              ).withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: const Color(
                                    0xFFFFD700,
                                  ).withOpacity(0.2),
                                ),
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
      ),
    );
  }
}
