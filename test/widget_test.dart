import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:musliemapp/main.dart';

void main() {
  setUpAll(() {
    Get.testMode = true;
  });

  tearDownAll(() {
    Get.reset();
  });

  group('MainApp', () {
    testWidgets('يُبنى التطبيق ويعرض النص الرئيسي أذكار المسلم', (tester) async {
      await tester.pumpWidget(const MainApp());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('أذكار المسلم'), findsOneWidget);
      expect(find.text('أهلاً بك،'), findsOneWidget);
    });

    testWidgets('يوجد زر مكتبة الأذكار', (tester) async {
      await tester.pumpWidget(const MainApp());
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('مكتبة الأذكار'), findsOneWidget);
    });
  });
}
