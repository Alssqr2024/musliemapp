import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class CompassWidget extends StatelessWidget {
  final QiblahDirection direction;
  final bool isAligned;

  const CompassWidget({super.key, required this.direction, required this.isAligned});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glow
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 320,
          height: 320,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isAligned
                    ? Colors.greenAccent.withValues(alpha: 0.3)
                    : Colors.transparent,
                blurRadius: 40,
                spreadRadius: 5,
              ),
            ],
          ),
        ),
        // Compass background (Rotating with device)
        Transform.rotate(
          angle: (direction.direction * (math.pi / 180) * -1),
          child: CustomPaint(
            size: const Size(300, 300),
            painter: _CompassPainter(),
          ),
        ),
        // Qibla Needle (Fixed relative to compass north, so rotates with compass)
        Transform.rotate(
          angle: (direction.qiblah * (math.pi / 180) * -1),
          child: SizedBox(
            width: 300,
            height: 300,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 20,
                  child: Column(
                    children: [
                      Container(
                        width: 4,
                        height: 130,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.greenAccent,
                              Colors.greenAccent.withValues(alpha: 0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      const Text('🕋', style: TextStyle(fontSize: 40)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Center cap
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
          ),
        ),
      ],
    );
  }
}

class _CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paintCircle = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paintCircle);

    final paintBorder = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, paintBorder);

    // Draw lines
    final paintLine = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    for (int i = 0; i < 360; i += 5) {
      final isMajor = i % 30 == 0;
      final length = isMajor ? 15.0 : 8.0;
      final angle = i * (math.pi / 180);

      final p1 = Offset(
        center.dx + (radius - 2) * math.cos(angle),
        center.dy + (radius - 2) * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + (radius - length) * math.cos(angle),
        center.dy + (radius - length) * math.sin(angle),
      );

      paintLine.color = isMajor
          ? Colors.white.withValues(alpha: 0.6)
          : Colors.white.withValues(alpha: 0.2);
      canvas.drawLine(p1, p2, paintLine);

      if (isMajor) {
        final text = i == 0
            ? 'E'
            : i == 90
            ? 'S'
            : i == 180
            ? 'W'
            : i == 270
            ? 'N'
            : i.toString();

        // Skip numbers for cardinal points to look cleaner, or rotate them
        if (i % 90 == 0) {
          _drawText(canvas, text, center, radius - 30, angle);
        }
      }
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center,
    double radius,
    double angle,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: text == 'N' ? Colors.redAccent : Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final offset = Offset(
      center.dx + radius * math.cos(angle) - textPainter.width / 2,
      center.dy + radius * math.sin(angle) - textPainter.height / 2,
    );
    canvas.save();
    canvas.translate(
      offset.dx + textPainter.width / 2,
      offset.dy + textPainter.height / 2,
    );
    canvas.rotate(angle + math.pi / 2);
    canvas.translate(
      -(offset.dx + textPainter.width / 2),
      -(offset.dy + textPainter.height / 2),
    );
    textPainter.paint(canvas, offset);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
