import '../../domain/entities/collection_entity.dart';

class CollectionModel extends CollectionEntity {
  const CollectionModel({
    required super.id,
    required super.label,
    required super.title,
    required super.imageUrl,
    super.category,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id']?.toString() ?? '',
      label: json['label']?.toString() ?? json['action']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      category: json['category']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'title': title,
      'imageUrl': imageUrl,
      if (category != null) 'category': category,
    };
  }
}
