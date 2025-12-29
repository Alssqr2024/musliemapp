import 'package:musliemapp/features/hadith/data/models/qudsi_model.dart';

abstract class QudsiRepo {
  Future<List<QudsiModel>> getQudsi();
}
