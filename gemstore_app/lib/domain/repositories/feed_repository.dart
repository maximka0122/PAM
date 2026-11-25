import '../entities/feed_entity.dart';
import '../entities/product_detail_entity.dart';

abstract class FeedRepository {
  Future<FeedEntity> getFeed();
  Future<ProductDetailEntity> getProductDetails();
}
