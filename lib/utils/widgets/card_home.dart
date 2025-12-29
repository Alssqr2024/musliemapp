import 'package:flutter/material.dart';
import 'package:musliemapp/core/theme/app_theme.dart';

class CardHome extends StatelessWidget {
  const CardHome({
    super.key,
    required this.icon,
    required this.title,
    required this.onClick,
  });
  final IconData icon;
  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClick,
          borderRadius: BorderRadius.circular(20),
          splashColor: AppTheme.primaryColor.withOpacity(0.1),
          highlightColor: AppTheme.primaryColor.withOpacity(0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.1),
                      AppTheme.primaryColor.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.secondaryColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(icon, size: 32, color: AppTheme.primaryColor),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: AppTheme.heading2.copyWith(
                  fontSize: 16,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
