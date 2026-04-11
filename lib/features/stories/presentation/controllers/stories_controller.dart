import 'package:get/get.dart';
import '../../domain/entities/story.dart';
import '../../domain/usecases/stories_usecase.dart';

class StoriesController extends GetxController {
  final StoriesUseCase storiesUseCase;
  StoriesController({required this.storiesUseCase});

  var stories = <Story>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchStories(String category) async {
    try {
      isLoading(true);
      List<Story> result = [];
      switch (category) {
        case 'prophets':
          result = await storiesUseCase.getProphetsStories();
          break;
        case 'companions':
          result = await storiesUseCase.getStoriesOfCompanions();
          break;
        case 'female_companions':
          result = await storiesUseCase.getStoriesOfFemaleCompanions();
          break;
        case 'quran':
          result = await storiesUseCase.getStoriesOfQuran();
          break;
        case 'animals':
          result = await storiesUseCase.getStoriesOfAnimals();
          break;
        case 'miracles':
          result = await storiesUseCase.getMiraclesOfProphets();
          break;
        case 'wives':
          result = await storiesUseCase.getWivesOfProphets();
          break;
        case 'life':
          result = await storiesUseCase.getLifeOfProphet();
          break;
        case 'family':
          result = await storiesUseCase.getFamilyOfProphet();
          break;
        case 'battles':
          result = await storiesUseCase.getBattlesOfProphet();
          break;
        case 'summary_life':
          result = await storiesUseCase.getSummaryLifeOfProphet();
          break;
        default:
          result = [];
      }
      stories.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
