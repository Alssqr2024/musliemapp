import '../entities/story.dart';
import '../repositories/stories_repo.dart';

class StoriesUseCase {
  final StoriesRepo repo;
  StoriesUseCase({required this.repo});

  Future<List<Story>> getProphetsStories() => repo.getProphetsStories();
  Future<List<Story>> getStoriesOfCompanions() => repo.getStoriesOfCompanions();
  Future<List<Story>> getStoriesOfFemaleCompanions() =>
      repo.getStoriesOfFemaleCompanions();
  Future<List<Story>> getStoriesOfQuran() => repo.getStoriesOfQuran();
  Future<List<Story>> getStoriesOfAnimals() => repo.getStoriesOfAnimals();
  Future<List<Story>> getMiraclesOfProphets() => repo.getMiraclesOfProphets();
  Future<List<Story>> getWivesOfProphets() => repo.getWivesOfProphets();
  Future<List<Story>> getLifeOfProphet() => repo.getLifeOfProphet();
  Future<List<Story>> getFamilyOfProphet() => repo.getFamilyOfProphet();
  Future<List<Story>> getBattlesOfProphet() => repo.getBattlesOfProphet();
  Future<List<Story>> getSummaryLifeOfProphet() =>
      repo.getSummaryLifeOfProphet();
}
