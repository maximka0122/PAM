import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/app_config_service.dart';
import '../utils/app_colors.dart';
import '../widgets/product_card.dart';
import '../widgets/collection_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> _configFuture;

  @override
  void initState() {
    super.initState();
    _configFuture = AppConfigService.loadConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _configFuture,
          builder: (context, snapshot) {
            final data = snapshot.data?['homePage'] as Map<String, dynamic>?;

            final String storeName = data?['storeName'] ?? "GemStore";

            // Categories
            final List categoriesJson = data?['categories'] as List? ?? [];
            final List<Map<String, dynamic>> categories = categoriesJson.isNotEmpty
                ? categoriesJson.map((e) => e as Map<String, dynamic>).toList()
                : [
                    {"name": "Women", "selected": true},
                    {"name": "Men", "selected": false},
                    {"name": "Accessories", "selected": false},
                    {"name": "Beauty", "selected": false},
                  ];

            // Hero Banner
            final heroBanner = data?['heroBanner'] as Map<String, dynamic>?;
            final String heroTitle = heroBanner?['title'] ?? "Autumn\nCollection\n2021";
            final String heroImage = heroBanner?['imageUrl'] ?? "assets/images/1.jpg";

            // Feature Products
            final List featureJson = data?['featureProducts'] as List? ?? [];
            final List<Product> featureProducts = featureJson.isNotEmpty
                ? featureJson.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList()
                : [
                    Product(id: "p001", name: "Turtleneck Sweater", price: "\$ 39.99", image: "assets/images/2.jpg"),
                    Product(id: "p002", name: "Long Sleeve Dress", price: "\$ 45.00", image: "assets/images/3.png"),
                    Product(id: "p003", name: "Sportwear Set", price: "\$ 80.00", image: "assets/images/4.png"),
                  ];

            // New Collection (Hang Out & Party)
            final newCol = data?['newCollection'] as Map<String, dynamic>?;
            final String newColLabel = newCol?['label'] ?? "NEW COLLECTION";
            final String newColTitle = newCol?['title'] ?? "HANG OUT\n& PARTY";
            final String newColImage = newCol?['imageUrl'] ?? "assets/images/5.png";

            // Recommended
            final List recJson = data?['recommended'] as List? ?? [];
            final List<Product> recommendedProducts = recJson.isNotEmpty
                ? recJson.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList()
                : [
                    Product(id: "p004", name: "White fashion hoodie", price: "\$ 29.00", image: "assets/images/6.png"),
                    Product(id: "p005", name: "Cotton T-shirt", price: "\$ 30.00", image: "assets/images/7.png"),
                  ];

            // Top Collections
            final List topColJson = data?['topCollections'] as List? ?? [];
            final List<Map<String, dynamic>> topCollections = topColJson.isNotEmpty
                ? topColJson.map((e) => e as Map<String, dynamic>).toList()
                : [
                    {"label": "Sale up to 40%", "title": "FOR SLIM\n& BEAUTY", "imageUrl": "assets/images/8.png"},
                    {"label": "Summer Collection 2021", "title": "Most sexy\n& fabulous\ndesign", "imageUrl": "assets/images/9.png"},
                  ];

            // Category Promos (The Office Life / Elegant Design)
            final List promoJson = data?['categoryPromos'] as List? ?? [];
            final List<Map<String, dynamic>> promos = promoJson.isNotEmpty
                ? promoJson.map((e) => e as Map<String, dynamic>).toList()
                : [
                    {"category": "T-Shirts", "title": "The\nOffice\nLife", "imageUrl": "assets/images/10.png"},
                    {"category": "Dresses", "title": "Elegant\nDesign", "imageUrl": "assets/images/11.png"},
                  ];

            return SingleChildScrollView(
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
                      Text(
                        storeName,
                        style: const TextStyle(
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
                    children: categories.map((cat) {
                      final name = cat['name']?.toString() ?? '';
                      final isSel = cat['selected'] == true;
                      IconData icon = Icons.female;
                      if (name.toLowerCase().contains("men")) icon = Icons.male;
                      if (name.toLowerCase().contains("accessories")) icon = Icons.watch;
                      if (name.toLowerCase().contains("beauty")) icon = Icons.auto_awesome;
                      return _buildCategoryItem(icon, name, isSelected: isSel);
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Hero Banner
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: _buildSmartImage(heroImage, fallbackAsset: "assets/images/1.jpg"),
                          ),
                          Positioned.fill(
                            child: Container(color: Colors.black.withValues(alpha: 0.25)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  heroTitle.replaceAll(" ", "\n"),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
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

                  // Feature Products Horizontal List
                  SizedBox(
                    height: 235,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featureProducts.length,
                      itemBuilder: (context, index) {
                        final product = featureProducts[index];
                        final fallbacks = ["assets/images/2.jpg", "assets/images/3.png", "assets/images/4.png"];
                        final fallback = fallbacks[index % fallbacks.length];
                        return ProductCard(
                          product: product,
                          fallbackAsset: fallback,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(product: product),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Middle Banner - Hang Out & Party
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
                              children: [
                                Text(
                                  newColLabel,
                                  style: const TextStyle(fontSize: 11, color: AppColors.textGrey, letterSpacing: 0.5),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  newColTitle.replaceAll(" ", "\n"),
                                  style: const TextStyle(
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
                                  child: _buildSmartImage(newColImage, height: 125, width: 100, fallbackAsset: "assets/images/5.png"),
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

                  // Recommended Section Cards
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recommendedProducts.length,
                      itemBuilder: (context, index) {
                        final p = recommendedProducts[index];
                        final fallbacks = ["assets/images/6.png", "assets/images/7.png"];
                        final fallback = fallbacks[index % fallbacks.length];
                        return _buildSmallListProduct(p.image, p.name, p.price, fallback);
                      },
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

                  // Top Collection Cards
                  ...List.generate(topCollections.length, (index) {
                    final item = topCollections[index];
                    final fallbacks = ["assets/images/8.png", "assets/images/9.png"];
                    return CollectionCard(
                      title: (item['title']?.toString() ?? '').replaceAll(" ", "\n"),
                      subtitle: item['label']?.toString() ?? '',
                      image: item['imageUrl']?.toString() ?? '',
                      fallbackAsset: fallbacks[index % fallbacks.length],
                      bgColor: const Color(0xFFF8F8F8),
                    );
                  }),

                  // Bottom 2 Side-by-Side Cards (Category Promos)
                  if (promos.length >= 2)
                    Row(
                      children: [
                        Expanded(
                          child: SmallCollectionCard(
                            title: (promos[0]['title']?.toString() ?? 'The Office Life').replaceAll(" ", "\n"),
                            subtitle: promos[0]['category']?.toString() ?? 'T-Shirts',
                            image: promos[0]['imageUrl']?.toString() ?? '',
                            fallbackAsset: "assets/images/10.png",
                            imageOnLeft: true,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SmallCollectionCard(
                            title: (promos[1]['title']?.toString() ?? 'Elegant Design').replaceAll(" ", "\n"),
                            subtitle: promos[1]['category']?.toString() ?? 'Dresses',
                            image: promos[1]['imageUrl']?.toString() ?? '',
                            fallbackAsset: "assets/images/11.png",
                            imageOnLeft: false,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, {bool isSelected = false}) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: isSelected ? Colors.black : Colors.grey.shade200, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: isSelected ? Colors.white : Colors.black, size: 22),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? AppColors.textDark : AppColors.textGrey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSmallListProduct(String img, String name, String price, String fallbackAsset) {
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
            child: SizedBox(
              width: 64,
              height: 64,
              child: _buildSmartImage(img, width: 64, height: 64, fallbackAsset: fallbackAsset),
            ),
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

  Widget _buildSmartImage(String src, {double? width, double? height, String fallbackAsset = "assets/images/1.jpg"}) {
    if (src.startsWith('assets/')) {
      return Image.asset(
        src,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Image.asset(fallbackAsset, width: width, height: height, fit: BoxFit.cover),
      );
    }
    return Image.network(
      src,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Image.asset(fallbackAsset, width: width, height: height, fit: BoxFit.cover),
    );
  }
}
