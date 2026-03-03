import 'package:musliemapp/core/utils/json_loader.dart';
import 'package:musliemapp/features/azkar/data/models/azkar_model.dart';
import 'package:musliemapp/utils/constants/file_json.dart';

class AzkarLocalData {
  Future<List<AzkarModel>> getAzkar() async {
    final data = await JsonLoader.loadList(azkar);
    try {
      return data.map((e) => AzkarModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }
}
