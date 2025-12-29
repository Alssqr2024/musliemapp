import 'package:get/get.dart';
import 'package:musliemapp/features/names_of_allah/domain/usecases/names_allah_usecase.dart';
import 'package:musliemapp/features/names_of_allah/domain/entities/names_allah.dart';

class NamesAllahController extends GetxController {
  final NamesAllahUsecase namesAllahUseCase;

  NamesAllahController({required this.namesAllahUseCase});

  var isLoading = true.obs;
  var namesList = <NamesAllah>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNames();
  }

  void fetchNames() async {
    try {
      isLoading(true);
      var result = await namesAllahUseCase.call();
      namesList.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
