import 'package:musliemapp/features/hadith/data/datasources/hadith_local_data.dart';
import 'package:musliemapp/features/hadith/data/models/nawawi_model.dart';
import 'package:musliemapp/features/hadith/domain/repositories/nawawi_repo.dart';

class NawawiRepoImpl implements NawawiRepo {
  final HadithLocalData localData;

  NawawiRepoImpl({required this.localData});

  @override
  Future<List<NawawiModel>> getNawawis() async {
    return await localData.getNawawis();
  }
}
