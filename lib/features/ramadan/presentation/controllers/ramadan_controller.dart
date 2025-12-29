import 'package:get/get.dart';
import 'package:musliemapp/features/ramadan/domain/entities/ramadan_item.dart';
import 'package:musliemapp/features/ramadan/domain/usecases/get_ramadan_items_usecase.dart';

class RamadanController extends GetxController {
  final GetRamadanItemsUseCase getRamadanItemsUseCase;

  RamadanController({required this.getRamadanItemsUseCase});

  var isLoading = true.obs;
  var items = <RamadanItem>[].obs;
  var errorMessage = ''.obs;

  Future<void> fetchItems(String jsonFile) async {
    try {
      isLoading(true);
      var result = await getRamadanItemsUseCase.call(jsonFile);
      items.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
