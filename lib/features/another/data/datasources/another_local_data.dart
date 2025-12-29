import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:musliemapp/features/another/data/models/another_model.dart';

class AnotherLocalData {
  Future<List<AnotherModel>> getAnotherItems(String jsonFile) async {
    final jsonString = await rootBundle.loadString(jsonFile);
    List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => AnotherModel.fromJson(e)).toList();
  }
}
