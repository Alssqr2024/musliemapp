import 'package:musliemapp/features/another/domain/entities/another_item.dart';

abstract class AnotherRepo {
  Future<List<AnotherItem>> getAnotherItems(String jsonFile);
}
