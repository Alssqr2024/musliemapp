import 'package:musliemapp/features/hadith/domain/entities/nawawi.dart';
import 'package:musliemapp/features/hadith/domain/repositories/nawawi_repo.dart';

class NawawiUseCase {
  final NawawiRepo nawawiRepo;
  NawawiUseCase({required this.nawawiRepo});

  Future<List<Nawawi>> call() async {
    return await nawawiRepo.getNawawis();
  }
}
