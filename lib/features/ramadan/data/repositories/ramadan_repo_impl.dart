import 'package:musliemapp/features/ramadan/data/datasources/ramadan_local_data.dart';
import 'package:musliemapp/features/ramadan/data/models/ramadan_model.dart';
import 'package:musliemapp/features/ramadan/domain/repositories/ramadan_repo.dart';

class RamadanRepoImpl implements RamadanRepo {
  final RamadanLocalData localData;

  RamadanRepoImpl({required this.localData});

  @override
  Future<List<RamadanModel>> getRamadanItems(String jsonFile) async {
    return await localData.getRamadanItems(jsonFile);
  }
}
