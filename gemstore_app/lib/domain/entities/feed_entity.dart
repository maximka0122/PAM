import 'category_entity.dart';
import 'collection_entity.dart';
import 'product_entity.dart';

class FeedEntity {
  final String storeName;
  final List<CategoryEntity> categories;
  final CollectionEntity heroBanner;
  final List<ProductEntity> featureProducts;
  final CollectionEntity newCollection;
  final List<ProductEntity> recommended;
  final List<CollectionEntity> topCollections;
  final List<CollectionEntity> categoryPromos;

  const FeedEntity({
    required this.storeName,
    required this.categories,
    required this.heroBanner,
    required this.featureProducts,
    required this.newCollection,
    required this.recommended,
    required this.topCollections,
    required this.categoryPromos,
  });
}
