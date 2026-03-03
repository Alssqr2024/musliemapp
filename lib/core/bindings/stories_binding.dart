import 'package:get/get.dart';
import 'package:musliemapp/features/stories/data/datasources/stories_local_data.dart';
import 'package:musliemapp/features/stories/data/repositories/stories_repo_impl.dart';
import 'package:musliemapp/features/stories/domain/usecases/stories_usecase.dart';

/// Binding for Stories feature - يسجل الاعتماديات فقط، الـ Controller يُسجل في الصفحة مع tag
class StoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoriesLocalData(), fenix: true);
    Get.lazyPut(
      () => StoriesRepoImpl(localData: Get.find<StoriesLocalData>()),
      fenix: true,
    );
    Get.lazyPut(
      () => StoriesUseCase(repo: Get.find<StoriesRepoImpl>()),
      fenix: true,
    );
  }
}
