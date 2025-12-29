import 'package:musliemapp/features/hadith/data/models/shamail_model.dart';
import 'package:musliemapp/features/hadith/domain/repositories/shamail_repo.dart';

class ShamailUseCase {
  final ShamailRepo shamailRepo;
  ShamailUseCase({required this.shamailRepo});

  Future<List<ShamailModel>> call() async {
    return await shamailRepo.getShamails();
  }
}
