import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.currency,
    required super.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rawPrice = json['price'];
    double p = 0.0;
    if (rawPrice is num) {
      p = rawPrice.toDouble();
    } else if (rawPrice != null) {
      p = double.tryParse(rawPrice.toString()) ?? 0.0;
    }

    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: p,
      currency: json['currency']?.toString() ?? 'USD',
      imageUrl: json['imageUrl']?.toString() ?? json['mainImageUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'currency': currency,
      'imageUrl': imageUrl,
    };
  }
}
