class Product {
  final String name;
  final String price;
  final String image;
  final String description;
  final double rating;

  Product({
    required this.name,
    required this.price,
    required this.image,
    this.description = "Sportswear is no longer uniform culture. It is no longer under or untold...",
    this.rating = 4.9,
  });
}
