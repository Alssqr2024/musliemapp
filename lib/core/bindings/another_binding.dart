import 'package:get/get.dart';
import 'package:musliemapp/features/another/data/datasources/another_local_data.dart';
import 'package:musliemapp/features/another/data/repositories/another_repo_impl.dart';
import 'package:musliemapp/features/another/domain/usecases/get_another_items_usecase.dart';

/// Binding for Another (Miscellaneous) feature - يسجل الاعتماديات فقط، الـ Controller يُسجل في الصفحة مع tag
class AnotherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnotherLocalData(), fenix: true);
    Get.lazyPut(
      () => AnotherRepoImpl(localData: Get.find<AnotherLocalData>()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetAnotherItemsUseCase(anotherRepo: Get.find<AnotherRepoImpl>()),
      fenix: true,
    );
  }
}
