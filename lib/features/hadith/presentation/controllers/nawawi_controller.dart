import 'package:get/get.dart';
import 'package:musliemapp/features/hadith/domain/entities/nawawi.dart';
import 'package:musliemapp/features/hadith/domain/usecases/nawawi_usecase.dart';

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
      nawawis.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
