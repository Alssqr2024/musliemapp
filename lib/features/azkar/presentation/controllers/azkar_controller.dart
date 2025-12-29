import 'package:get/get.dart';
import 'package:musliemapp/features/azkar/domain/usecases/azkar_usecase.dart';
import 'package:musliemapp/features/azkar/domain/entities/azkar.dart';

class AzkarController extends GetxController {
  final AzkarUsecase azkarUseCase;

  AzkarController({required this.azkarUseCase});

  var isLoading = true.obs;
  var azkarList = <Azkar>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAzkar();
  }

  void fetchAzkar() async {
    try {
      isLoading(true);
      var result = await azkarUseCase.call();
      azkarList.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
