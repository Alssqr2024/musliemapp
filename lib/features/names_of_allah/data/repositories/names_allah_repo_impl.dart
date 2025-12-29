import 'package:musliemapp/features/names_of_allah/data/datasources/names_allah_local_data.dart';
import 'package:musliemapp/features/names_of_allah/data/models/names_allah_model.dart';
import 'package:musliemapp/features/names_of_allah/domain/repositories/names_allah_repo.dart';

class NamesAllahRepoImpl implements NamesAllahRepo {
  final NamesAllahLocalData localData;

  NamesAllahRepoImpl({required this.localData});

  @override
  Future<List<NamesAllahModel>> getNamesOfAllah() async {
    return await localData.getNamesOfAllah();
  }
}
