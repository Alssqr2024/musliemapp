import 'package:musliemapp/features/azkar/data/models/azkar_model.dart';
import 'package:musliemapp/features/azkar/domain/repositories/azkar_repo.dart';

class AzkarUsecase {
  final AzkarRepo azkarRepo;

  AzkarUsecase({required this.azkarRepo});

  Future<List<AzkarModel>> call() {
    return azkarRepo.getAzkar();
  }
}
