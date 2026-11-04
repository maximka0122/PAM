import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../utils/app_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedColorIndex = 0;
  int selectedSizeIndex = 2; // Default selected 'L' as in design screenshot
  bool isFavorite = true;

  bool isDescriptionExpanded = true;
  bool isReviewsExpanded = true;
  bool isSimilarExpanded = true;

  final List<Color> availableColors = [
    const Color(0xFFE2C2A4), // Beige/Tan
    const Color(0xFF1A1A1A), // Black
    const Color(0xFFE05A50), // Coral Red
  ];

  final List<String> availableSizes = ["S", "M", "L"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Product Image Banner Header
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
                        // Circle background behind model
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
                                tag: widget.product.name,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: _buildImageWidget(widget.product.image, height: 310, width: 220),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Dots Pagination Indicator
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

                  // Back Button (Top Left)
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

                  // Favorite Button (Top Right)
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

              // Main Details Padding
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
                            widget.product.name.isEmpty ? "Sportswear Set" : widget.product.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        Text(
                          widget.product.price.isEmpty ? "\$ 80.00" : widget.product.price,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Rating Stars Row (5 Green Stars + Score)
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => const Icon(Icons.star, color: Color(0xFF508A7B), size: 16),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "(132)",
                          style: TextStyle(color: AppColors.textGrey, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Color & Size Selection Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Color Selector
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Color",
                              style: TextStyle(fontSize: 12, color: AppColors.textGrey, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: List.generate(availableColors.length, (index) {
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
                                      backgroundColor: availableColors[index],
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
                            const Text(
                              "Size",
                              style: TextStyle(fontSize: 12, color: AppColors.textGrey, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: List.generate(availableSizes.length, (index) {
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
                                      availableSizes[index],
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

                    // Expandable Description Section
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        tilePadding: EdgeInsets.zero,
                        title: const Text(
                          "Description",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product.description.isEmpty
                                      ? "Sportswear is no longer under culture. It is no longer male or cobbled together as it once was. Sport is fashion today. The top is oversized in fit and style, may need to size down."
                                      : widget.product.description,
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

                    // Expandable Reviews Section
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        tilePadding: EdgeInsets.zero,
                        title: const Text(
                          "Reviews",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Rating Summary Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left: 4.9 Score
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: const [
                                            Text(
                                              "4.9",
                                              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textDark),
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "OUT OF 5",
                                              style: TextStyle(fontSize: 10, color: AppColors.textGrey, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // Right: Stars & Ratings Count
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
                                        const Text(
                                          "83 ratings",
                                          style: TextStyle(fontSize: 11, color: AppColors.textGrey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),

                                // Progress Bars Breakdown (5 star down to 1 star)
                                _buildRatingBar("5 ★", 0.82, "82%"),
                                _buildRatingBar("4 ★", 0.12, "12%"),
                                _buildRatingBar("3 ★", 0.05, "5%"),
                                _buildRatingBar("2 ★", 0.03, "3%"),
                                _buildRatingBar("1 ★", 0.00, "0%"),
                                const SizedBox(height: 15),

                                // Actions Row (47 REVIEWS | WRITE A REVIEW ✎)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "47 REVIEWS",
                                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textGrey),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: const [
                                          Text(
                                            "WRITE A REVIEW",
                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textGrey),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.edit_outlined, size: 14, color: AppColors.textGrey),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Individual Reviews List
                                _buildUserReview(
                                  name: "Jennifer Rose",
                                  time: "2m ago",
                                  comment: "I love it. Awesome customer service!! Helped me out with sizing an additional item to my order. Thanks again!",
                                  avatarSrc: "assets/images/5.png",
                                ),
                                const SizedBox(height: 15),
                                _buildUserReview(
                                  name: "Kelly Rihana",
                                  time: "5m ago",
                                  comment: "I'm very happy with order, it was delivered on time and good quality. Recommended!",
                                  avatarSrc: "assets/images/8.png",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),

                    // Expandable Similar Products Section
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        tilePadding: EdgeInsets.zero,
                        title: const Text(
                          "Similar Product",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: SizedBox(
                              height: 190,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _buildSimilarCard("Rise Crop Hoodie", "\$ 43.00", "assets/images/2.jpg"),
                                  _buildSimilarCard("Gym Crop Top", "\$ 39.99", "assets/images/3.png"),
                                  _buildSimilarCard("Sportswear Set", "\$ 47.99", "assets/images/4.png"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80), // Bottom padding for sticky button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Fixed Bottom Navigation Bar ("Add To Cart" Button)
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
          backgroundImage: avatarSrc.startsWith('assets/') ? AssetImage(avatarSrc) : NetworkImage(avatarSrc) as ImageProvider,
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

  Widget _buildSimilarCard(String name, String price, String img) {
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
              child: _buildImageWidget(img, width: double.infinity, height: double.infinity),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(fontSize: 11, color: AppColors.textGrey, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            price,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String src, {double? width, double? height}) {
    if (src.startsWith('assets/')) {
      return Image.asset(
        src,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Container(width: width, height: height, color: Colors.grey.shade300, child: const Icon(Icons.checkroom, color: Colors.grey)),
      );
    } else {
      return Image.network(
        src,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Container(width: width, height: height, color: Colors.grey.shade300, child: const Icon(Icons.checkroom, color: Colors.grey)),
      );
    }
  }
}
