import 'product_entity.dart';

class ColorOptionEntity {
  final String id;
  final String name;
  final String value;

  const ColorOptionEntity({
    required this.id,
    required this.name,
    required this.value,
  });
}

class ReviewEntity {
  final String id;
  final String author;
  final String avatarUrl;
  final double rating;
  final String createdAtLabel;
  final String text;

  const ReviewEntity({
    required this.id,
    required this.author,
    required this.avatarUrl,
    required this.rating,
    required this.createdAtLabel,
    required this.text,
  });
}

class RatingBreakdownEntity {
  final int stars;
  final int percentage;

  const RatingBreakdownEntity({
    required this.stars,
    required this.percentage,
  });
}

class ProductDetailEntity {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String mainImageUrl;
  final List<String> galleryImageUrls;
  final double rating;
  final int ratingCount;
  final int reviewCount;
  final String description;
  final List<ColorOptionEntity> availableColors;
  final String selectedColor;
  final List<String> availableSizes;
  final String selectedSize;
  final List<RatingBreakdownEntity> ratingBreakdown;
  final List<ReviewEntity> reviews;
  final List<ProductEntity> similarProducts;
  final bool isFavorite;
  final String addToCartLabel;

  const ProductDetailEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.mainImageUrl,
    required this.galleryImageUrls,
    required this.rating,
    required this.ratingCount,
    required this.reviewCount,
    required this.description,
    required this.availableColors,
    required this.selectedColor,
    required this.availableSizes,
    required this.selectedSize,
    required this.ratingBreakdown,
    required this.reviews,
    required this.similarProducts,
    required this.isFavorite,
    required this.addToCartLabel,
  });

  String get formattedPrice {
    final symbol = currency == 'USD' ? '\$ ' : '';
    return '$symbol${price.toStringAsFixed(2)}';
  }
}
