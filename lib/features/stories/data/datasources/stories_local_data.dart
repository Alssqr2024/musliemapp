import 'package:musliemapp/core/utils/json_loader.dart';
import 'package:musliemapp/utils/constants/file_json.dart';
import 'package:musliemapp/features/stories/data/models/story_model.dart';

class StoriesLocalData {
  Future<List<StoryModel>> _getStories(String jsonFile) async {
    final data = await JsonLoader.loadList(jsonFile);
    try {
      return data.map((e) => StoryModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<StoryModel>> getProphetsStories() =>
      _getStories(storiesOfProphets);
  Future<List<StoryModel>> getStoriesOfCompanions() =>
      _getStories(storiesOfCompanions);
  Future<List<StoryModel>> getStoriesOfFemaleCompanions() =>
      _getStories(storiesOfFemaleCompanions);
  Future<List<StoryModel>> getStoriesOfQuran() => _getStories(storiesOfQuran);
  Future<List<StoryModel>> getStoriesOfAnimals() =>
      _getStories(storiesOfAnimals);
  Future<List<StoryModel>> getMiraclesOfProphets() =>
      _getStories(miraclesOfProphets);
  Future<List<StoryModel>> getWivesOfProphets() => _getStories(wivesOfProphets);
  Future<List<StoryModel>> getLifeOfProphet() => _getStories(lifeOfProphet);
  Future<List<StoryModel>> getFamilyOfProphet() => _getStories(familyOfProphet);
  Future<List<StoryModel>> getBattlesOfProphet() =>
      _getStories(battlesOfProphet);
  Future<List<StoryModel>> getSummaryLifeOfProphet() =>
      _getStories(summaryLifeOfProphet);
}
