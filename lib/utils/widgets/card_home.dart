import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:musliemapp/core/theme/app_theme.dart';

enum CardType { square, wide, tall }

class CardHome extends StatelessWidget {
  const CardHome({
    super.key,
    required this.icon,
    required this.title,
    required this.onClick,
    this.type = CardType.square,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onClick;
  final CardType type;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
                gradient: const LinearGradient(
                  colors: [Colors.white10, Colors.white12],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onClick,
                  splashColor: Colors.white10,
                  highlightColor: Colors.white.withValues(alpha: 0.05),
                  child: _buildLayout(constraints),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLayout(BoxConstraints constraints) {
    switch (type) {
      case CardType.wide:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _buildIcon(size: 24, padding: 12),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: _textStyle(
                        constraints.maxHeight * 0.2,
                      ).copyWith(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null && constraints.maxHeight > 60) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: _subtitleStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white24,
                size: 14,
              ),
            ],
          ),
        );
      case CardType.tall:
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: _buildIcon(size: 24, padding: 12)),
              const SizedBox(height: 12),
              Text(
                title,
                style: _textStyle(14),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null && constraints.maxHeight > 100) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: _subtitleStyle(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        );
      case CardType.square:
        // Use a more compact layout if constraints are very tight
        final bool isVerySmall = constraints.maxHeight < 80;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: _buildIcon(
                  size: isVerySmall ? 20 : 28,
                  padding: isVerySmall ? 8 : 12,
                ),
              ),
              if (!isVerySmall) const SizedBox(height: 8),
              if (constraints.maxHeight > 40)
                Text(
                  title,
                  style: _textStyle(isVerySmall ? 11 : 13),
                  textAlign: TextAlign.center,
                  maxLines: isVerySmall ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        );
    }
  }

  Widget _buildIcon({double size = 32, double padding = 16}) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppTheme.secondaryColor.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: FittedBox(
        child: Icon(icon, size: size, color: AppTheme.secondaryColor),
      ),
    );
  }

  TextStyle _textStyle(double size) {
    return AppTheme.heading2.copyWith(
      fontSize: size,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    );
  }

  TextStyle _subtitleStyle() {
    return const TextStyle(color: Colors.white60, fontSize: 13);
  }
}
