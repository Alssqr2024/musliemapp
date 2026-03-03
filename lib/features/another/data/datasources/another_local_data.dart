import 'package:musliemapp/core/utils/json_loader.dart';
import 'package:musliemapp/features/another/data/models/another_model.dart';

class AnotherLocalData {
  Future<List<AnotherModel>> getAnotherItems(String jsonFile) async {
    final data = await JsonLoader.loadList(jsonFile);
    try {
      return data.map((e) => AnotherModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }
}
