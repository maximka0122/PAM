import '../../domain/entities/product_detail_entity.dart';
import 'product_model.dart';

class ColorOptionModel extends ColorOptionEntity {
  const ColorOptionModel({
    required super.id,
    required super.name,
    required super.value,
  });

  factory ColorOptionModel.fromJson(Map<String, dynamic> json) {
    return ColorOptionModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
    );
  }
}

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.author,
    required super.avatarUrl,
    required super.rating,
    required super.createdAtLabel,
    required super.text,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id']?.toString() ?? '',
      author: json['author']?.toString() ?? '',
      avatarUrl: json['avatarUrl']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      createdAtLabel: json['createdAtLabel']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
    );
  }
}

class RatingBreakdownModel extends RatingBreakdownEntity {
  const RatingBreakdownModel({
    required super.stars,
    required super.percentage,
  });

  factory RatingBreakdownModel.fromJson(Map<String, dynamic> json) {
    return RatingBreakdownModel(
      stars: (json['stars'] as num?)?.toInt() ?? 5,
      percentage: (json['percentage'] as num?)?.toInt() ?? 0,
    );
  }
}

class ProductDetailModel extends ProductDetailEntity {
  const ProductDetailModel({
    required super.id,
    required super.name,
    required super.price,
    required super.currency,
    required super.mainImageUrl,
    required super.galleryImageUrls,
    required super.rating,
    required super.ratingCount,
    required super.reviewCount,
    required super.description,
    required super.availableColors,
    required super.selectedColor,
    required super.availableSizes,
    required super.selectedSize,
    required super.ratingBreakdown,
    required super.reviews,
    required super.similarProducts,
    required super.isFavorite,
    required super.addToCartLabel,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    final pData = json['product'] as Map<String, dynamic>? ?? json;

    final rawGallery = pData['galleryImageUrls'] as List? ?? [];
    final rawColors = pData['availableColors'] as List? ?? [];
    final rawSizes = pData['availableSizes'] as List? ?? [];
    final rawBreakdown = pData['ratingBreakdown'] as List? ?? [];
    final rawReviews = pData['reviews'] as List? ?? [];
    final rawSimilar = pData['similarProducts'] as List? ?? [];
    final actions = pData['actions'] as Map<String, dynamic>? ?? {};

    final rawPrice = pData['price'];
    double p = 80.0;
    if (rawPrice is num) {
      p = rawPrice.toDouble();
    } else if (rawPrice != null) {
      p = double.tryParse(rawPrice.toString()) ?? 80.0;
    }

    return ProductDetailModel(
      id: pData['id']?.toString() ?? 'p003',
      name: pData['name']?.toString() ?? 'Sportwear Set',
      price: p,
      currency: pData['currency']?.toString() ?? 'USD',
      mainImageUrl: pData['mainImageUrl']?.toString() ?? '',
      galleryImageUrls: rawGallery.map((e) => e.toString()).toList(),
      rating: (pData['rating'] as num?)?.toDouble() ?? 4.9,
      ratingCount: (pData['ratingCount'] as num?)?.toInt() ?? 83,
      reviewCount: (pData['reviewCount'] as num?)?.toInt() ?? 47,
      description: pData['description']?.toString() ?? '',
      availableColors: rawColors.map((e) => ColorOptionModel.fromJson(e as Map<String, dynamic>)).toList(),
      selectedColor: pData['selectedColor']?.toString() ?? 'beige',
      availableSizes: rawSizes.map((e) => e.toString()).toList(),
      selectedSize: pData['selectedSize']?.toString() ?? 'L',
      ratingBreakdown: rawBreakdown.map((e) => RatingBreakdownModel.fromJson(e as Map<String, dynamic>)).toList(),
      reviews: rawReviews.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>)).toList(),
      similarProducts: rawSimilar.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList(),
      isFavorite: actions['isFavorite'] == true,
      addToCartLabel: actions['addToCartLabel']?.toString() ?? 'Add To Cart',
    );
  }
}
