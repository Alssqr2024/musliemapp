import 'package:musliemapp/features/hadith/data/models/qudsi_model.dart';
import 'package:musliemapp/features/hadith/domain/repositories/qudsi_repo.dart';

class QudsiUseCase {
  final QudsiRepo qudsiRepo;
  QudsiUseCase({required this.qudsiRepo});
  Future<List<QudsiModel>> call() {
    return qudsiRepo.getQudsi();
  }
}
