import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:musliemapp/features/names_of_allah/data/models/names_allah_model.dart';
import 'package:musliemapp/utils/constants/file_json.dart';

class NamesAllahLocalData {
  Future<List<NamesAllahModel>> getNamesOfAllah() async {
    final jsonstring = await rootBundle.loadString(namesOfAllah);
    List<dynamic> data = jsonDecode(jsonstring);
    return data.map((e) => NamesAllahModel.fromJson(e)).toList();
  }
}
