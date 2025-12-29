import 'package:musliemapp/features/azkar/data/models/azkar_model.dart';

abstract class AzkarRepo {
  Future<List<AzkarModel>> getAzkar();
}
