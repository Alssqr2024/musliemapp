import 'package:musliemapp/features/hadith/domain/entities/nawawi.dart';

abstract class NawawiRepo {
  Future<List<Nawawi>> getNawawis();
}
