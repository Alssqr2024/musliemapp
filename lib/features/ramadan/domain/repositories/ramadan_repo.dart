import 'package:musliemapp/features/ramadan/domain/entities/ramadan_item.dart';

abstract class RamadanRepo {
  Future<List<RamadanItem>> getRamadanItems(String jsonFile);
}
