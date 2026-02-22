import 'package:get/get.dart';
import 'package:musliemapp/features/hadith/domain/entities/nawawi.dart';
import 'package:musliemapp/features/hadith/domain/usecases/nawawi_usecase.dart';
import 'package:musliemapp/utils/constants/hadith_constants.dart';

class NawawiController extends GetxController {
  final NawawiUseCase nawawiUseCase;

  NawawiController({required this.nawawiUseCase});

  var nawawis = <Nawawi>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getNawawis();
  }

  Future<void> getNawawis() async {
    try {
      isLoading(true);
      var result = await nawawiUseCase.call();
      // Assign titles from constants
      for (int i = 0; i < result.length; i++) {
        if (i < HadithConstants.nawawiTitles.length) {
          result[i].title = HadithConstants.nawawiTitles[i];
        }
      }
      nawawis.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
