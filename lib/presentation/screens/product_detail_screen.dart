import 'package:flutter/material.dart';
import '../../core/di/injection_container.dart';
import '../../core/utils/app_colors.dart';
import '../../domain/entities/product_detail_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../controllers/product_detail_controller.dart';
import '../widgets/state_widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late final ProductDetailController _controller;

  int selectedColorIndex = 0;
  int selectedSizeIndex = 2; // Default 'L'
  bool isFavorite = true;

  @override
  void initState() {
    super.initState();
    _controller = ServiceLocator.createProductDetailController();
    _controller.fetchProductDetails();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _parseHexColor(String hexString, Color defaultColor) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      return defaultColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ValueListenableBuilder<ProductDetailState>(
          valueListenable: _controller,
          builder: (context, state, child) {
            switch (state.status) {
              case ProductDetailStatus.initial:
              case ProductDetailStatus.loading:
                return const LoadingView(message: "Fetching product details from REST API...");
              case ProductDetailStatus.error:
                return ErrorView(
                  message: state.errorMessage ?? "An error occurred loading product details.",
                  onRetry: () => _controller.fetchProductDetails(),
                );
              case ProductDetailStatus.loaded:
                final product = state.productDetails;
                if (product == null) {
                  return ErrorView(
                    message: "Product details empty.",
                    onRetry: () => _controller.fetchProductDetails(),
                  );
                }
                return _buildProductDetailBody(product);
            }
          },
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to cart!"), duration: Duration(seconds: 1)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D2D2D),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  Text(
                    "Add To Cart",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetailBody(ProductDetailEntity product) {
    final colors = product.availableColors.isNotEmpty
        ? product.availableColors.map((c) => _parseHexColor(c.value, const Color(0xFFE9C5AC))).toList()
        : [const Color(0xFFE9C5AC), const Color(0xFF000000), const Color(0xFFEF6262)];

    final sizes = product.availableSizes.isNotEmpty ? product.availableSizes : ["S", "M", "L"];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image Header
          Stack(
            children: [
              Container(
                height: 380,
                width: double.infinity,
                color: const Color(0xFFF8F8F8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 230,
                            height: 230,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Hero(
                            tag: product.name,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SmartImage(
                                src: product.mainImageUrl,
                                fallbackAsset: "assets/images/4.png",
                                height: 310,
                                width: 220,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 7, height: 7, decoration: const BoxDecoration(color: AppColors.textDark, shape: BoxShape.circle)),
                        const SizedBox(width: 5),
                        Container(width: 5, height: 5, decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle)),
                        const SizedBox(width: 5),
                        Container(width: 5, height: 5, decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle)),
                      ],
                    ),
                  ],
                ),
              ),

              // Back Button
              Positioned(
                left: 20,
                top: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              // Favorite Button
              Positioned(
                right: 20,
                top: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.redAccent : Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),

          // Details Padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Price Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    Text(
                      product.formattedPrice,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Rating Stars
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => const Icon(Icons.star, color: Color(0xFF508A7B), size: 16),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "(${product.ratingCount})",
                      style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // Color & Size Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Color Selector
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Color", style: TextStyle(fontSize: 12, color: AppColors.textGrey, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(colors.length, (index) {
                            final isSelected = selectedColorIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColorIndex = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? Colors.grey.shade400 : Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: colors[index],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),

                    // Size Selector
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Size", style: TextStyle(fontSize: 12, color: AppColors.textGrey, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(sizes.length, (index) {
                            final isSelected = selectedSizeIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSizeIndex = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: 32,
                                height: 32,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF2D2D2D) : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF2D2D2D) : Colors.grey.shade300,
                                  ),
                                ),
                                child: Text(
                                  sizes[index],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const Divider(height: 1, color: Color(0xFFEEEEEE)),

                // Description
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    tilePadding: EdgeInsets.zero,
                    title: const Text("Description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.description,
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.5),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Read more",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFEEEEEE)),

                // Reviews Section
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    tilePadding: EdgeInsets.zero,
                    title: const Text("Reviews", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      "${product.rating}",
                                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textDark),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text("OUT OF 5", style: TextStyle(fontSize: 10, color: AppColors.textGrey, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: List.generate(
                                        5,
                                        (index) => const Icon(Icons.star, color: Color(0xFF508A7B), size: 16),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text("${product.ratingCount} ratings", style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // Rating Breakdown Bars
                            ...product.ratingBreakdown.map((b) {
                              return _buildRatingBar("${b.stars} ★", b.percentage / 100.0, "${b.percentage}%");
                            }),
                            const SizedBox(height: 15),

                            // Actions
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${product.reviewCount} REVIEWS", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textGrey)),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: const [
                                      Text("WRITE A REVIEW", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textGrey)),
                                      SizedBox(width: 4),
                                      Icon(Icons.edit_outlined, size: 14, color: AppColors.textGrey),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Reviews list
                            ...product.reviews.map((r) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: _buildUserReview(
                                  name: r.author,
                                  time: r.createdAtLabel,
                                  comment: r.text,
                                  avatarSrc: r.avatarUrl,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFEEEEEE)),

                // Similar Products Section
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    tilePadding: EdgeInsets.zero,
                    title: const Text("Similar Product", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          height: 190,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.similarProducts.length,
                            itemBuilder: (context, index) {
                              final sp = product.similarProducts[index];
                              final fallbacks = ["assets/images/2.jpg", "assets/images/3.png", "assets/images/4.png"];
                              return _buildSimilarCard(sp, fallbacks[index % fallbacks.length]);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(String label, double percent, String percentText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          SizedBox(
            width: 25,
            child: Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF508A7B)),
                minHeight: 4,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 30,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(percentText, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserReview({
    required String name,
    required String time,
    required String comment,
    required String avatarSrc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey.shade200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SmartImage(src: avatarSrc, width: 36, height: 36, fallbackAsset: "assets/images/5.png"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark)),
                  Text(time, style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: List.generate(
                  5,
                  (index) => const Icon(Icons.star, color: Color(0xFF508A7B), size: 12),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                comment,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarCard(ProductEntity p, String fallbackAsset) {
    return Container(
      width: 115,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 135,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SmartImage(src: p.imageUrl, width: double.infinity, height: double.infinity, fallbackAsset: fallbackAsset),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            p.name,
            style: const TextStyle(fontSize: 11, color: AppColors.textGrey, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            p.formattedPrice,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }
}
