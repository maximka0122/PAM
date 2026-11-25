class Product {
  final String id;
  final String name;
  final String price;
  final String image;
  final String description;
  final double rating;

  Product({
    this.id = '',
    required this.name,
    required this.price,
    required this.image,
    this.description = "Sportswear is no longer under culture. It is no longer male or cobbled together as it once was. Sport is fashion today. The top is oversized in fit and style, may need to size down.",
    this.rating = 4.9,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final rawPrice = json['price'];
    final currency = json['currency'] ?? 'USD';
    final symbol = currency == 'USD' ? '\$ ' : '';
    String formattedPrice = '';
    if (rawPrice != null) {
      if (rawPrice is num) {
        formattedPrice = '$symbol${rawPrice.toStringAsFixed(2)}';
      } else {
        formattedPrice = '$symbol$rawPrice';
      }
    }
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: formattedPrice,
      image: json['imageUrl']?.toString() ?? json['mainImageUrl']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.9,
    );
  }
}
