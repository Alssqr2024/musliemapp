import 'package:get/get.dart';
import 'package:musliemapp/features/hadith/domain/entities/shamail.dart';
import 'package:musliemapp/features/hadith/domain/usecases/shamail_usecase.dart';

class ShamailController extends GetxController {
  final ShamailUseCase shamailUseCase;

  ShamailController({required this.shamailUseCase});

  var shamails = <Shamail>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getShamails();
  }

  Future<void> getShamails() async {
    try {
      isLoading(true);
      var result = await shamailUseCase.call();
      shamails.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
