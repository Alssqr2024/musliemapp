import 'package:get/get.dart';
import 'package:musliemapp/features/ramadan/data/datasources/ramadan_local_data.dart';
import 'package:musliemapp/features/ramadan/data/repositories/ramadan_repo_impl.dart';
import 'package:musliemapp/features/ramadan/domain/usecases/get_ramadan_items_usecase.dart';

/// Binding for Ramadan feature - يسجل الاعتماديات فقط، الـ Controller يُسجل في الصفحة مع tag
class RamadanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RamadanLocalData(), fenix: true);
    Get.lazyPut(
      () => RamadanRepoImpl(localData: Get.find<RamadanLocalData>()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetRamadanItemsUseCase(ramadanRepo: Get.find<RamadanRepoImpl>()),
      fenix: true,
    );
  }
}
