import 'package:get/get.dart';
import 'package:musliemapp/core/controllers/base_controller.dart';
import 'package:musliemapp/features/azkar/domain/usecases/azkar_usecase.dart';
import 'package:musliemapp/features/azkar/domain/entities/azkar.dart';

class AzkarController extends BaseController {
  final AzkarUsecase azkarUseCase;

  AzkarController({required this.azkarUseCase});

  var azkarList = <Azkar>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAzkar();
  }

  Future<void> fetchAzkar() async {
    try {
      setLoading(true);
      clearError();
      var result = await azkarUseCase.call();
      azkarList.assignAll(result);
    } catch (e) {
      handleError(e, 'fetchAzkar');
    } finally {
      setLoading(false);
    }
  }
}
