import 'package:musliemapp/features/hadith/data/models/shamail_model.dart';

abstract class ShamailRepo {
  Future<List<ShamailModel>> getShamails();
}
