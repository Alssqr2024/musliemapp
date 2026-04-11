import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/features/qibla/presentation/widgets/compass_widget.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';

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
    return MainScaffold(
      slivers: [
        const PremiumSliverAppBar(
          title: 'اتجاه القبلة',
          icon: Icons.explore_rounded, // fallback icon
          subtitle: '﴿ فَوَلِّ وَجْهَكَ شَطْرَ الْمَسْجِدِ الْحَرَامِ ﴾',
          useCircledIcon: true,
        ),
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
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        );
                      }
                      return _buildQiblaCompass();
                    },
                  ),
        ),
      ],
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
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
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
                    shadowColor: AppTheme.secondaryColor.withValues(alpha: 0.3),
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
              CompassWidget(direction: direction, isAligned: isAligned),
              const Spacer(),
              _buildQuoteCard(),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
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
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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

