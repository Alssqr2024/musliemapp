import 'package:get/get.dart';
import 'package:musliemapp/features/prayer/domain/entities/prayer_item.dart';
import 'package:musliemapp/features/prayer/domain/usecases/get_prayer_items_usecase.dart';

class PrayerController extends GetxController {
  final GetPrayerItemsUseCase getPrayerItemsUseCase;

  PrayerController({required this.getPrayerItemsUseCase});

  var isLoading = true.obs;
  var items = <PrayerItem>[].obs;
  var errorMessage = ''.obs;

  Future<void> fetchItems(String jsonFile) async {
    try {
      isLoading(true);
      var result = await getPrayerItemsUseCase.call(jsonFile);
      items.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
