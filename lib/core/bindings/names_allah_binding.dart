import 'package:get/get.dart';
import 'package:musliemapp/features/names_of_allah/data/datasources/names_allah_local_data.dart';
import 'package:musliemapp/features/names_of_allah/data/repositories/names_allah_repo_impl.dart';
import 'package:musliemapp/features/names_of_allah/domain/usecases/names_allah_usecase.dart';
import 'package:musliemapp/features/names_of_allah/presentation/controllers/names_allah_controller.dart';

/// Binding for Names of Allah feature
class NamesAllahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NamesAllahLocalData(), fenix: true);
    Get.lazyPut(
      () => NamesAllahRepoImpl(localData: Get.find<NamesAllahLocalData>()),
      fenix: true,
    );
    Get.lazyPut(
      () => NamesAllahUsecase(namesAllahRepo: Get.find<NamesAllahRepoImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => NamesAllahController(
        namesAllahUseCase: Get.find<NamesAllahUsecase>(),
      ),
      fenix: true,
    );
  }
}
