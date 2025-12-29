import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:musliemapp/features/azkar/data/models/azkar_model.dart';
import 'package:musliemapp/utils/constants/file_json.dart';

class AzkarLocalData {
  Future<List<AzkarModel>> getAzkar() async {
    final jsonstring = await rootBundle.loadString(azkar);
    List<dynamic> data = jsonDecode(jsonstring);
    return data.map((e) => AzkarModel.fromJson(e)).toList();
  }
}
