import 'dart:ui';
import 'package:flutter/material.dart';

class PrayerItemCard extends StatefulWidget {
  final int index;
  final String title;
  final String content;
  final VoidCallback onTap;

  const PrayerItemCard({
    super.key,
    required this.index,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  State<PrayerItemCard> createState() => _PrayerItemCardState();
}

class _PrayerItemCardState extends State<PrayerItemCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String preview = widget.content.replaceAll('\n', ' ').trim();
    if (preview.length > 150) {
      preview = '${preview.substring(0, 147)}...';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: isExpanded ? 0.08 : 0.04),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: isExpanded ? 0.15 : 0.08),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.05),
                  Colors.white.withValues(alpha: 0.01),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFFFD700,
                                  ).withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                (widget.index + 1).toString(),
                                style: const TextStyle(
                                  color: Color(0xFF0F2027),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              widget.content.split('\n').first.trim().length >
                                      30
                                  ? '${widget.content
                                            .split('\n')
                                            .first
                                            .trim()
                                            .substring(0, 27)}...'
                                  : widget.content.split('\n').first.trim(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Icon(
                            isExpanded
                                ? Icons.expand_less_rounded
                                : Icons.expand_more_rounded,
                            color: Colors.white54,
                          ),
                        ],
                      ),
                      AnimatedCrossFade(
                        firstChild: const SizedBox(width: double.infinity),
                        secondChild: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Divider(color: Colors.white10, height: 1),
                            const SizedBox(height: 16),
                            Text(
                              preview,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: widget.onTap,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                    0xFFFFD700,
                                  ).withValues(alpha: 0.1),
                                  foregroundColor: const Color(0xFFFFD700),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: const Color(
                                        0xFFFFD700,
                                      ).withValues(alpha: 0.3),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'عرض التفاصيل',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
