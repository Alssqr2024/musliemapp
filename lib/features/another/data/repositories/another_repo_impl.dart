import 'package:musliemapp/features/another/data/datasources/another_local_data.dart';
import 'package:musliemapp/features/another/data/models/another_model.dart';
import 'package:musliemapp/features/another/domain/repositories/another_repo.dart';

class AnotherRepoImpl implements AnotherRepo {
  final AnotherLocalData localData;

  AnotherRepoImpl({required this.localData});

  @override
  Future<List<AnotherModel>> getAnotherItems(String jsonFile) async {
    return await localData.getAnotherItems(jsonFile);
  }
}
