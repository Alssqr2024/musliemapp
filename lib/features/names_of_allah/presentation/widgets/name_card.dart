import 'package:flutter/material.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/utils/constants/constants.dart';

class NameCard extends StatelessWidget {
  final int index;
  final String name;
  final VoidCallback onTap;

  const NameCard({
    super.key,
    required this.index,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: AppTheme.secondaryColor.withValues(alpha: 0.12),
        highlightColor: AppTheme.secondaryColor.withValues(alpha: 0.06),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppTheme.unifiedGridCardGradient,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.secondaryColor.withValues(alpha: 0.22),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.secondaryColor.withValues(alpha: 0.12),
                      border: Border.all(
                        color: AppTheme.secondaryColor.withValues(alpha: 0.2),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontFamily: Constants.fontTajawal,
                        color: AppTheme.secondaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: Constants.fontTajawal,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.secondaryColor,
                          height: 1.25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
