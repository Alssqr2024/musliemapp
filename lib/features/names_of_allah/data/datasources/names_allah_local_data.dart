import 'package:musliemapp/core/utils/json_loader.dart';
import 'package:musliemapp/features/names_of_allah/data/models/names_allah_model.dart';
import 'package:musliemapp/utils/constants/file_json.dart';

class NamesAllahLocalData {
  Future<List<NamesAllahModel>> getNamesOfAllah() async {
    final data = await JsonLoader.loadList(namesOfAllah);
    try {
      return data.map((e) => NamesAllahModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }
}
