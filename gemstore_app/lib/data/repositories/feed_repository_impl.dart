import '../../domain/entities/feed_entity.dart';
import '../../domain/entities/product_detail_entity.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_datasource.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<FeedEntity> getFeed() async {
    return await remoteDataSource.fetchFeed();
  }

  @override
  Future<ProductDetailEntity> getProductDetails() async {
    return await remoteDataSource.fetchProductDetails();
  }
}
