import 'package:musliemapp/features/ramadan/domain/entities/ramadan_item.dart';
import 'package:musliemapp/features/ramadan/domain/repositories/ramadan_repo.dart';

class GetRamadanItemsUseCase {
  final RamadanRepo ramadanRepo;

  GetRamadanItemsUseCase({required this.ramadanRepo});

  Future<List<RamadanItem>> call(String jsonFile) async {
    return await ramadanRepo.getRamadanItems(jsonFile);
  }
}
