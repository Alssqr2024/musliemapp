import 'package:musliemapp/features/another/domain/entities/another_item.dart';
import 'package:musliemapp/features/another/domain/repositories/another_repo.dart';

class GetAnotherItemsUseCase {
  final AnotherRepo anotherRepo;

  GetAnotherItemsUseCase({required this.anotherRepo});

  Future<List<AnotherItem>> call(String jsonFile) async {
    return await anotherRepo.getAnotherItems(jsonFile);
  }
}
