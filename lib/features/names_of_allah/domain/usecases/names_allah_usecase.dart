import 'package:musliemapp/features/names_of_allah/domain/entities/names_allah.dart';
import 'package:musliemapp/features/names_of_allah/domain/repositories/names_allah_repo.dart';

class NamesAllahUsecase {
  final NamesAllahRepo namesAllahRepo;

  NamesAllahUsecase({required this.namesAllahRepo});

  Future<List<NamesAllah>> call() async {
    return await namesAllahRepo.getNamesOfAllah();
  }
}
