import '../entities/story.dart';

abstract class StoriesRepo {
  Future<List<Story>> getProphetsStories();
  Future<List<Story>> getStoriesOfCompanions();
  Future<List<Story>> getStoriesOfFemaleCompanions();
  Future<List<Story>> getStoriesOfQuran();
  Future<List<Story>> getStoriesOfAnimals();
  Future<List<Story>> getMiraclesOfProphets();
  Future<List<Story>> getWivesOfProphets();
  Future<List<Story>> getLifeOfProphet();
  Future<List<Story>> getFamilyOfProphet();
  Future<List<Story>> getBattlesOfProphet();
  Future<List<Story>> getSummaryLifeOfProphet();
}
