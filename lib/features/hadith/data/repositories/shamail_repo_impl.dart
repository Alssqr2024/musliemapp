import 'package:musliemapp/features/hadith/data/datasources/hadith_local_data.dart';
import 'package:musliemapp/features/hadith/data/models/shamail_model.dart';
import 'package:musliemapp/features/hadith/domain/repositories/shamail_repo.dart';

class ShamailRepoImpl implements ShamailRepo {
  final HadithLocalData localData;

  ShamailRepoImpl({required this.localData});

  @override
  Future<List<ShamailModel>> getShamails() {
    return localData.getShamails();
  }
}
