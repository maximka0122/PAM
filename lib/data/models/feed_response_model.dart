import '../../domain/entities/feed_entity.dart';
import 'category_model.dart';
import 'collection_model.dart';
import 'product_model.dart';

class FeedResponseModel extends FeedEntity {
  const FeedResponseModel({
    required super.storeName,
    required super.categories,
    required super.heroBanner,
    required super.featureProducts,
    required super.newCollection,
    required super.recommended,
    required super.topCollections,
    required super.categoryPromos,
  });

  factory FeedResponseModel.fromJson(Map<String, dynamic> json) {
    final rawCat = json['categories'] as List? ?? [];
    final rawFeat = json['featureProducts'] as List? ?? [];
    final rawRec = json['recommended'] as List? ?? [];
    final rawTop = json['topCollections'] as List? ?? [];
    final rawPromo = json['categoryPromos'] as List? ?? [];

    return FeedResponseModel(
      storeName: json['storeName']?.toString() ?? 'GemStore',
      categories: rawCat.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>)).toList(),
      heroBanner: CollectionModel.fromJson(json['heroBanner'] as Map<String, dynamic>? ?? {}),
      featureProducts: rawFeat.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList(),
      newCollection: CollectionModel.fromJson(json['newCollection'] as Map<String, dynamic>? ?? {}),
      recommended: rawRec.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList(),
      topCollections: rawTop.map((e) => CollectionModel.fromJson(e as Map<String, dynamic>)).toList(),
      categoryPromos: rawPromo.map((e) => CollectionModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
