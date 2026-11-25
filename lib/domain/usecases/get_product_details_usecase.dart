import '../entities/product_detail_entity.dart';
import '../repositories/feed_repository.dart';

class GetProductDetailsUseCase {
  final FeedRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<ProductDetailEntity> call() async {
    return await repository.getProductDetails();
  }
}
