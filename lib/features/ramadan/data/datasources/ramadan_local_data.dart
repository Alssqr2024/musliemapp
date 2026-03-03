import 'package:musliemapp/core/utils/json_loader.dart';
import 'package:musliemapp/features/ramadan/data/models/ramadan_model.dart';

class RamadanLocalData {
  Future<List<RamadanModel>> getRamadanItems(String jsonFile) async {
    final data = await JsonLoader.loadList(jsonFile);
    try {
      return data.map((e) => RamadanModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }
}
