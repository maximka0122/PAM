class CollectionEntity {
  final String id;
  final String label;
  final String title;
  final String imageUrl;
  final String? category;

  const CollectionEntity({
    required this.id,
    required this.label,
    required this.title,
    required this.imageUrl,
    this.category,
  });
}
