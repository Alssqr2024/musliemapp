import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:musliemapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    Get.testMode = true;
    await initializeDateFormatting('ar', null);
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'battery_optimization_dialog_shown': true,
      'silence_gps_dialog': true,
    });
  });

  tearDownAll(() {
    Get.reset();
  });

  group('MainApp', () {
    testWidgets('يُبنى التطبيق ويعرض النص الرئيسي أذكار المسلم', (tester) async {
      await tester.pumpWidget(const MainApp());
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('أذكار المسلم'), findsOneWidget);
      expect(find.text('أهلاً بك،'), findsOneWidget);
    });

    testWidgets('يوجد زر مكتبة الأذكار', (tester) async {
      await tester.pumpWidget(const MainApp());
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('مكتبة الأذكار'), findsOneWidget);
    });
  });
}
