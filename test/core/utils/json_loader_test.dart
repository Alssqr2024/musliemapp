import 'package:flutter_test/flutter_test.dart';
import 'package:musliemapp/core/utils/json_loader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('JsonLoader', () {
    test('loadList يعيد قائمة فارغة لمسار غير موجود عند الفشل', () async {
      final result = await JsonLoader.loadList('assets/non_existent.json');
      expect(result, isEmpty);
    });

    test('loadMap يعيد خريطة فارغة لمسار غير موجود عند الفشل', () async {
      final result = await JsonLoader.loadMap('assets/non_existent.json');
      expect(result, isEmpty);
    });
  });
}
