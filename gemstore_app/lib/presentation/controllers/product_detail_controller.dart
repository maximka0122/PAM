import 'package:flutter/foundation.dart';
import '../../domain/entities/product_detail_entity.dart';
import '../../domain/usecases/get_product_details_usecase.dart';

enum ProductDetailStatus { initial, loading, loaded, error }

class ProductDetailState {
  final ProductDetailStatus status;
  final ProductDetailEntity? productDetails;
  final String? errorMessage;

  const ProductDetailState({
    this.status = ProductDetailStatus.initial,
    this.productDetails,
    this.errorMessage,
  });

  ProductDetailState copyWith({
    ProductDetailStatus? status,
    ProductDetailEntity? productDetails,
    String? errorMessage,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      productDetails: productDetails ?? this.productDetails,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ProductDetailController extends ValueNotifier<ProductDetailState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailController({required this.getProductDetailsUseCase})
      : super(const ProductDetailState());

  Future<void> fetchProductDetails() async {
    value = value.copyWith(status: ProductDetailStatus.loading);
    try {
      final details = await getProductDetailsUseCase();
      value = value.copyWith(
        status: ProductDetailStatus.loaded,
        productDetails: details,
      );
    } catch (e) {
      value = value.copyWith(
        status: ProductDetailStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}
