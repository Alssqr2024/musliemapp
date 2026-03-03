import 'package:get/get.dart';
import 'package:musliemapp/features/hadith/data/datasources/hadith_local_data.dart';
import 'package:musliemapp/features/hadith/data/repositories/nawawi_repo_impl.dart';
import 'package:musliemapp/features/hadith/data/repositories/qudsi_repo_impl.dart';
import 'package:musliemapp/features/hadith/data/repositories/shamail_repo_impl.dart';
import 'package:musliemapp/features/hadith/domain/usecases/nawawi_usecase.dart';
import 'package:musliemapp/features/hadith/domain/usecases/qudsi_usecase.dart';
import 'package:musliemapp/features/hadith/domain/usecases/shamail_usecase.dart';
import 'package:musliemapp/features/hadith/presentation/controllers/nawawi_controller.dart';
import 'package:musliemapp/features/hadith/presentation/controllers/qudsi_controller.dart';
import 'package:musliemapp/features/hadith/presentation/controllers/shamail_controller.dart';

/// Bindings for Hadith features (Nawawi, Qudsi, Shamail)
class HadithBindings extends Bindings {
  @override
  void dependencies() {
    // Shared local data source
    Get.lazyPut(() => HadithLocalData(), fenix: true);
    final localData = Get.find<HadithLocalData>();

    // Nawawi
    Get.lazyPut(
      () => NawawiRepoImpl(localData: localData),
      fenix: true,
    );
    Get.lazyPut(
      () => NawawiUseCase(nawawiRepo: Get.find<NawawiRepoImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => NawawiController(nawawiUseCase: Get.find<NawawiUseCase>()),
      fenix: true,
    );

    // Qudsi
    Get.lazyPut(
      () => QudsiRepoImpl(localData: localData),
      fenix: true,
    );
    Get.lazyPut(
      () => QudsiUseCase(qudsiRepo: Get.find<QudsiRepoImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => QudsiController(qudsiUseCase: Get.find<QudsiUseCase>()),
      fenix: true,
    );

    // Shamail
    Get.lazyPut(
      () => ShamailRepoImpl(localData: localData),
      fenix: true,
    );
    Get.lazyPut(
      () => ShamailUseCase(shamailRepo: Get.find<ShamailRepoImpl>()),
      fenix: true,
    );
    Get.lazyPut(
      () => ShamailController(shamailUseCase: Get.find<ShamailUseCase>()),
      fenix: true,
    );
  }
}
