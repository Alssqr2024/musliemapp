import 'package:get/get.dart';
import 'package:musliemapp/features/hadith/data/models/qudsi_model.dart';
import 'package:musliemapp/features/hadith/domain/usecases/qudsi_usecase.dart';
import 'package:musliemapp/utils/constants/hadith_constants.dart';

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
      // Assign titles from constants
      for (int i = 0; i < result.length; i++) {
        if (i < HadithConstants.qudsiTitles.length) {
          result[i].title = HadithConstants.qudsiTitles[i];
        }
      }
      hadithList.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
