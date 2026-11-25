import '../entities/feed_entity.dart';
import '../repositories/feed_repository.dart';

class GetFeedUseCase {
  final FeedRepository repository;

  GetFeedUseCase(this.repository);

  Future<FeedEntity> call() async {
    return await repository.getFeed();
  }
}
