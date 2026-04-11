import 'package:flutter/material.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/utils/constants/constants.dart';

class PremiumSliverAppBar extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? subtitle;
  final Color iconColor;
  final double expandedHeight;
  final bool useCircledIcon;
  final bool showDecorativeCircles;
  final List<Widget>? actions;

  const PremiumSliverAppBar({
    super.key,
    required this.title,
    required this.icon,
    this.subtitle,
    this.iconColor = AppTheme.secondaryColor,
    this.expandedHeight = 200,
    this.useCircledIcon = false,
    this.showDecorativeCircles = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        // الافتراضي 1.5 يضخّم العنوان عند التوسّع فيُقصّ ويتداخل مع العنوان الفرعي
        expandedTitleScale: 1.0,
        centerTitle: true,
        titlePadding: const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 12),
        title: LayoutBuilder(
          builder: (context, constraints) {
            final bool isCollapsed = constraints.maxHeight <=
                kToolbarHeight + (MediaQuery.of(context).padding.top);
            final baseSize = isCollapsed ? 17.0 : 19.0;
            final maxW = MediaQuery.sizeOf(context).width - 32;
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: 1.0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: maxW,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: baseSize,
                        height: 1.15,
                        fontFamily: Constants.fontTajawal,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.black.withValues(alpha: 0.5),
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Optional Decorative Background Circles
            if (showDecorativeCircles) ...[
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconColor.withValues(alpha: 0.04),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                left: -20,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor.withValues(alpha: 0.06),
                  ),
                ),
              ),
            ],

            // Main Header Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  if (useCircledIcon)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: iconColor.withValues(alpha: 0.1),
                        border: Border.all(
                          color: iconColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        icon,
                        size: 40,
                        color: iconColor,
                      ),
                    )
                  else
                    Icon(
                      icon,
                      size: 50,
                      color: iconColor,
                    ),
                  const SizedBox(height: 10),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                        letterSpacing: 1.2,
                        fontFamily: Constants.fontTajawal,
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
