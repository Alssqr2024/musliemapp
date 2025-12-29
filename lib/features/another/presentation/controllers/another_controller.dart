import 'package:get/get.dart';
import 'package:musliemapp/features/another/domain/entities/another_item.dart';
import 'package:musliemapp/features/another/domain/usecases/get_another_items_usecase.dart';

class AnotherController extends GetxController {
  final GetAnotherItemsUseCase getAnotherItemsUseCase;

  AnotherController({required this.getAnotherItemsUseCase});

  var isLoading = true.obs;
  var items = <AnotherItem>[].obs;
  var errorMessage = ''.obs;

  Future<void> fetchItems(String jsonFile) async {
    try {
      isLoading(true);
      var result = await getAnotherItemsUseCase.call(jsonFile);
      items.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
