import 'package:musliemapp/core/utils/json_loader.dart';
import 'package:musliemapp/utils/constants/file_json.dart';
import 'package:musliemapp/features/hadith/data/models/nawawi_model.dart';
import 'package:musliemapp/features/hadith/data/models/qudsi_model.dart';
import 'package:musliemapp/features/hadith/data/models/shamail_model.dart';

class HadithLocalData {
  Future<List<NawawiModel>> getNawawis() async {
    final data = await JsonLoader.loadList(nawawiJson);
    try {
      return data.map((e) => NawawiModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<QudsiModel>> getQudsis() async {
    final json = await JsonLoader.loadMap(qudsi);
    final data = json['hadiths'];
    if (data is! List<dynamic>) return [];
    try {
      return data.map((e) => QudsiModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<ShamailModel>> getShamails() async {
    final json = await JsonLoader.loadMap(shamailJson);
    if (json.isEmpty) return [];
    try {
      return [ShamailModel.fromJson(json)];
    } catch (_) {
      return [];
    }
  }
}
