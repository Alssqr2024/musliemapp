import '../../domain/entities/story.dart';
import '../../domain/repositories/stories_repo.dart';
import '../../data/datasources/stories_local_data.dart';

class StoriesRepoImpl implements StoriesRepo {
  final StoriesLocalData localData;
  StoriesRepoImpl({required this.localData});

  @override
  Future<List<Story>> getProphetsStories() => localData.getProphetsStories();
  @override
  Future<List<Story>> getStoriesOfCompanions() =>
      localData.getStoriesOfCompanions();
  @override
  Future<List<Story>> getStoriesOfFemaleCompanions() =>
      localData.getStoriesOfFemaleCompanions();
  @override
  Future<List<Story>> getStoriesOfQuran() => localData.getStoriesOfQuran();
  @override
  Future<List<Story>> getStoriesOfAnimals() => localData.getStoriesOfAnimals();
  @override
  Future<List<Story>> getMiraclesOfProphets() =>
      localData.getMiraclesOfProphets();
  @override
  Future<List<Story>> getWivesOfProphets() => localData.getWivesOfProphets();
  @override
  Future<List<Story>> getLifeOfProphet() => localData.getLifeOfProphet();
  @override
  Future<List<Story>> getFamilyOfProphet() => localData.getFamilyOfProphet();
  @override
  Future<List<Story>> getBattlesOfProphet() => localData.getBattlesOfProphet();
  @override
  Future<List<Story>> getSummaryLifeOfProphet() =>
      localData.getSummaryLifeOfProphet();
}
