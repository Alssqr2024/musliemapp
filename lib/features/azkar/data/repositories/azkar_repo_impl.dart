import 'package:musliemapp/features/azkar/data/datasources/azkar_local_data.dart';
import 'package:musliemapp/features/azkar/data/models/azkar_model.dart';
import 'package:musliemapp/features/azkar/domain/repositories/azkar_repo.dart';

class AzkarRepoImpl implements AzkarRepo {
  final AzkarLocalData localData;

  AzkarRepoImpl({required this.localData});
  @override
  Future<List<AzkarModel>> getAzkar() {
    return localData.getAzkar();
  }
}
