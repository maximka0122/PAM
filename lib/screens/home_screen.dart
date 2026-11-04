import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../utils/app_colors.dart';
import '../widgets/product_card.dart';
import '../widgets/collection_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> features = [
      Product(
        name: "Turtleneck Sweater",
        price: "\$ 39.99",
        image: "assets/images/2.jpg",
      ),
      Product(
        name: "Long Sleeve Dress",
        price: "\$ 45.00",
        image: "assets/images/3.png",
      ),
      Product(
        name: "Sportswear",
        price: "\$ 80.00",
        image: "assets/images/4.png",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black, size: 26),
                    onPressed: () {},
                  ),
                  const Text(
                    "GemStore",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.textDark,
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 26),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryItem(Icons.female, "Women"),
                  _buildCategoryItem(Icons.male, "Men"),
                  _buildCategoryItem(Icons.watch, "Accessories"),
                  _buildCategoryItem(Icons.auto_awesome, "Beauty"),
                ],
              ),
              const SizedBox(height: 20),

              // Main Banner - Autumn Collection 2021 (Imaginea 1)
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/1.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Autumn\nCollection\n2021",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                          const SizedBox(width: 4),
                          Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.5), shape: BoxShape.circle)),
                          const SizedBox(width: 4),
                          Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.5), shape: BoxShape.circle)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Feature Products Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Feature Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Show all", style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 15),

              // Feature Products Horizontal List (Imaginile 2, 3, 4)
              SizedBox(
                height: 235,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: features[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(product: features[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Middle Banner - Hang Out & Party (Imaginea 5)
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "NEW COLLECTION",
                              style: TextStyle(fontSize: 11, color: AppColors.textGrey, letterSpacing: 0.5),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "HANG OUT\n& PARTY",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                "assets/images/5.png",
                                height: 125,
                                width: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(color: Colors.grey.shade300, child: const Icon(Icons.person, color: Colors.grey)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Recommended Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Recommended", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Show all", style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 15),

              // Recommended Section Cards (Imaginile 6, 7)
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSmallListProduct("assets/images/6.png", "White fashion hoodie", "\$ 29.00"),
                    _buildSmallListProduct("assets/images/7.png", "Cotton Tee", "\$ 30.00"),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Top Collection Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Top Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Show all", style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 15),

              // Top Collection Cards (Imaginile 8, 9, 10, 11)
              const CollectionCard(
                title: "FOR SLIM\n& BEAUTY",
                subtitle: "Sale up to 40%",
                image: "assets/images/8.png",
                bgColor: Color(0xFFF8F8F8),
              ),
              const CollectionCard(
                title: "Most sexy\n& fabulous\ndesign",
                subtitle: "Summer Collection 2021",
                image: "assets/images/9.png",
                bgColor: Color(0xFFF8F8F8),
              ),

              // Bottom 2 Side-by-Side Cards ("The Office Life" - 10 & "Elegant Design" - 11)
              Row(
                children: const [
                  Expanded(
                    child: SmallCollectionCard(
                      title: "The\nOffice\nLife",
                      subtitle: "T-Shirts",
                      image: "assets/images/10.png",
                      imageOnLeft: true,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: SmallCollectionCard(
                      title: "Elegant\nDesign",
                      subtitle: "Dresses",
                      image: "assets/images/11.png",
                      imageOnLeft: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.black, size: 22),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textGrey, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildSmallListProduct(String img, String name, String price) {
    final imageWidget = img.startsWith('assets/')
        ? Image.asset(
            img,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(width: 64, height: 64, color: Colors.grey.shade300, child: const Icon(Icons.shopping_bag, color: Colors.grey)),
          )
        : Image.network(
            img,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(width: 64, height: 64, color: Colors.grey.shade300, child: const Icon(Icons.shopping_bag, color: Colors.grey)),
          );

    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(8),
      width: 210,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageWidget,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
