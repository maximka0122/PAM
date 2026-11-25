import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../domain/entities/product_entity.dart';
import 'state_widgets.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;
  final String fallbackAsset;
  final VoidCallback onTap;

  const ProductCardWidget({
    super.key,
    required this.product,
    this.fallbackAsset = "assets/images/2.jpg",
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SmartImage(
                  src: product.imageUrl,
                  fallbackAsset: fallbackAsset,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(fontSize: 13, color: AppColors.textGrey, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              product.formattedPrice,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
