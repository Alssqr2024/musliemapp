import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:musliemapp/features/ramadan/data/models/ramadan_model.dart';

class RamadanLocalData {
  Future<List<RamadanModel>> getRamadanItems(String jsonFile) async {
    final jsonString = await rootBundle.loadString(jsonFile);
    List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => RamadanModel.fromJson(e)).toList();
  }
}
