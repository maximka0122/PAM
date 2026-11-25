class ProductEntity {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String imageUrl;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.imageUrl,
  });

  String get formattedPrice {
    final symbol = currency == 'USD' ? '\$ ' : '';
    return '$symbol${price.toStringAsFixed(2)}';
  }
}
