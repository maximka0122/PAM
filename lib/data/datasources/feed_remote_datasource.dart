import 'dart:convert';
import 'package:flutter/services.dart';
import '../../core/errors/failures.dart';
import '../../core/network/api_client.dart';
import '../models/feed_response_model.dart';
import '../models/product_detail_model.dart';

abstract class FeedRemoteDataSource {
  Future<FeedResponseModel> fetchFeed();
  Future<ProductDetailModel> fetchProductDetails();
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final ApiClient apiClient;

  FeedRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<FeedResponseModel> fetchFeed() async {
    try {
      final response = await apiClient.get('/feed');
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body) as Map<String, dynamic>;
        return FeedResponseModel.fromJson(decoded);
      }
    } catch (_) {
      // Fallback to local asset if remote REST fails or timeouts
    }

    try {
      final jsonStr = await rootBundle.loadString('assets/lab_v1.json');
      final decoded = json.decode(jsonStr) as Map<String, dynamic>;
      final homeData = decoded['homePage'] as Map<String, dynamic>? ?? {};
      return FeedResponseModel.fromJson(homeData);
    } catch (e) {
      throw const ServerFailure("Failed to load feed data from API and fallback");
    }
  }

  @override
  Future<ProductDetailModel> fetchProductDetails() async {
    try {
      final response = await apiClient.get('/feed/details');
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body) as Map<String, dynamic>;
        return ProductDetailModel.fromJson(decoded);
      }
    } catch (_) {
      // Fallback to local asset if remote REST fails or timeouts
    }

    try {
      final jsonStr = await rootBundle.loadString('assets/lab_v1.json');
      final decoded = json.decode(jsonStr) as Map<String, dynamic>;
      final productData = decoded['productPage'] as Map<String, dynamic>? ?? {};
      return ProductDetailModel.fromJson(productData);
    } catch (e) {
      throw const ServerFailure("Failed to load product details data from API and fallback");
    }
  }
}
