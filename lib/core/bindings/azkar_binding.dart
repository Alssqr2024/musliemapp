import 'package:get/get.dart';
import 'package:musliemapp/features/azkar/data/datasources/azkar_local_data.dart';
import 'package:musliemapp/features/azkar/data/repositories/azkar_repo_impl.dart';
import 'package:musliemapp/features/azkar/domain/usecases/azkar_usecase.dart';
import 'package:musliemapp/features/azkar/presentation/controllers/azkar_controller.dart';

/// Binding for Azkar feature
class AzkarBinding extends Bindings {
  @override
  void dependencies() {
    // Data layer
    Get.lazyPut(() => AzkarLocalData(), fenix: true);

    // Repository layer
    Get.lazyPut(
      () => AzkarRepoImpl(localData: Get.find<AzkarLocalData>()),
      fenix: true,
    );

    // Use case layer
    Get.lazyPut(
      () => AzkarUsecase(azkarRepo: Get.find<AzkarRepoImpl>()),
      fenix: true,
    );

    // Controller layer
    Get.lazyPut(
      () => AzkarController(azkarUseCase: Get.find<AzkarUsecase>()),
      fenix: true,
    );
  }
}
