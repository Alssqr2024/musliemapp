import 'package:musliemapp/features/hadith/data/datasources/hadith_local_data.dart';
import 'package:musliemapp/features/hadith/data/models/qudsi_model.dart';
import 'package:musliemapp/features/hadith/domain/repositories/qudsi_repo.dart';

class QudsiRepoImpl implements QudsiRepo {
  final HadithLocalData localData;
  QudsiRepoImpl({required this.localData});
  @override
  Future<List<QudsiModel>> getQudsi() {
    return localData.getQudsis();
  }
}
