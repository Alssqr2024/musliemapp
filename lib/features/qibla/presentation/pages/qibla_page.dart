import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:musliemapp/core/theme/app_theme.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  bool _hasPermission = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    setState(() => _isLoading = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _hasPermission = false;
      } else {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        _hasPermission =
            (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse);
      }
    } catch (e) {
      _hasPermission = false;
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverHeader(),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.secondaryColor,
                    ),
                  )
                : !_hasPermission
                ? _buildPermissionError()
                : FutureBuilder(
                    future: FlutterQiblah.androidDeviceSensorSupport(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.secondaryColor,
                          ),
                        );
                      }
                      if (snapshot.hasData && snapshot.data == false) {
                        return Center(
                          child: Text(
                            'هذا الجهاز لا يدعم حساس البوصلة',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        );
                      }
                      return _buildQiblaCompass();
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverHeader() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text(
          'اتجاه القبلة',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
                      color: AppTheme.secondaryColor.withOpacity(0.1),
                      border: Border.all(
                        color: AppTheme.secondaryColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Text('🕋', style: TextStyle(fontSize: 32)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '﴿ فَوَلِّ وَجْهَكَ شَطْرَ الْمَسْجِدِ الْحَرَامِ ﴾',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
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

  Widget _buildPermissionError() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_off,
                  size: 80,
                  color: Colors.orangeAccent,
                ),
                const SizedBox(height: 20),
                const Text(
                  'بوصلة القبلة تحتاج لصلاحية الموقع وخدمة GPS لتعمل بدقة.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _checkPermission,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                    foregroundColor: const Color(0xFF0F2027),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10,
                    shadowColor: AppTheme.secondaryColor.withOpacity(0.3),
                  ),
                  child: const Text(
                    'تفعيل الموقع',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQiblaCompass() {
    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white70),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(
            child: Text(
              'تعذّر الوصول إلى البوصلة\nتأكد من تفعيل GPS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
        }

        final direction = snapshot.data!;
        // Alignment feedback: if within 5 degrees, make it "glow"
        final isAligned = (direction.offset.abs() < 5);

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isAligned ? Colors.greenAccent : Colors.white,
                  shadows: isAligned
                      ? [
                          const Shadow(
                            color: Colors.greenAccent,
                            blurRadius: 20,
                          ),
                        ]
                      : [],
                ),
                child: const Text('اتجه نحو القبلة'),
              ),
              const SizedBox(height: 10),
              Text(
                isAligned
                    ? 'أنت في الاتجاه الصحيح 🕋'
                    : 'الزاوية: ${direction.qiblah.toStringAsFixed(1)}°',
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const Spacer(),
              _buildCompassWidget(direction, isAligned),
              const Spacer(),
              _buildQuoteCard(),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompassWidget(QiblahDirection direction, bool isAligned) {
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
                    ? Colors.greenAccent.withOpacity(0.3)
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
          child: Container(
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
                              Colors.greenAccent.withOpacity(0),
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

  Widget _buildQuoteCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: const Text(
              '﴿ وَحَيْثُ مَا كُنتُمْ فَوَلُّوا وُجُوهَكُمْ شَطْرَهُ ﴾',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paintCircle = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paintCircle);

    final paintBorder = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, paintBorder);

    // Draw lines
    final paintLine = Paint()
      ..color = Colors.white.withOpacity(0.3)
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
          ? Colors.white.withOpacity(0.6)
          : Colors.white.withOpacity(0.2);
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
