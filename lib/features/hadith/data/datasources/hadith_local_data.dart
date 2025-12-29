import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:musliemapp/utils/constants/file_json.dart';
import 'package:musliemapp/features/hadith/data/models/nawawi_model.dart';
import 'package:musliemapp/features/hadith/data/models/qudsi_model.dart';
import 'package:musliemapp/features/hadith/data/models/shamail_model.dart';

class HadithLocalData {
  Future<List<NawawiModel>> getNawawis() async {
    final jsonstring = await rootBundle.loadString(nawawiJson);
    List<dynamic> data = jsonDecode(jsonstring);
    return data.map((e) => NawawiModel.fromJson(e)).toList();
  }

  Future<List<QudsiModel>> getQudsis() async {
    final jsonstring = await rootBundle.loadString(qudsi);
    Map<String, dynamic> json = jsonDecode(jsonstring);
    List<dynamic> data = json['hadiths'];
    return data.map((e) => QudsiModel.fromJson(e)).toList();
  }

  Future<List<ShamailModel>> getShamails() async {
    final jsonstring = await rootBundle.loadString(shamailJson);
    Map<String, dynamic> json = jsonDecode(jsonstring);
    return [ShamailModel.fromJson(json)];
  }
}
