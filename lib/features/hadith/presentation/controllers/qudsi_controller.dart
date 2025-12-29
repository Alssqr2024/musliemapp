import 'package:get/get.dart';
import 'package:musliemapp/features/hadith/data/models/qudsi_model.dart';
import 'package:musliemapp/features/hadith/domain/usecases/qudsi_usecase.dart';

class QudsiController extends GetxController {
  final QudsiUseCase qudsiUseCase;

  QudsiController({required this.qudsiUseCase});

  var isLoading = true.obs;
  var hadithList = <QudsiModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHadiths();
  }

  void fetchHadiths() async {
    try {
      isLoading(true);
      var result = await qudsiUseCase.call();
      hadithList.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
