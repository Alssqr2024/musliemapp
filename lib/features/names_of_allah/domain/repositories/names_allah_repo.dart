import 'package:musliemapp/features/names_of_allah/domain/entities/names_allah.dart';

abstract class NamesAllahRepo {
  Future<List<NamesAllah>> getNamesOfAllah();
}
