import 'package:flutter/material.dart';
import '../../core/di/injection_container.dart';
import '../../core/utils/app_colors.dart';
import '../../domain/entities/feed_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../controllers/feed_controller.dart';
import '../widgets/collection_card.dart';
import '../widgets/product_card.dart';
import '../widgets/state_widgets.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final FeedController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ServiceLocator.createFeedController();
    _controller.fetchFeed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ValueListenableBuilder<FeedState>(
          valueListenable: _controller,
          builder: (context, state, child) {
            switch (state.status) {
              case FeedStatus.initial:
              case FeedStatus.loading:
                return const LoadingView(message: "Fetching feed from REST API...");
              case FeedStatus.error:
                return ErrorView(
                  message: state.errorMessage ?? "An error occurred while loading feed.",
                  onRetry: () => _controller.fetchFeed(),
                );
              case FeedStatus.loaded:
                final feed = state.feed;
                if (feed == null) {
                  return ErrorView(
                    message: "Feed data is empty.",
                    onRetry: () => _controller.fetchFeed(),
                  );
                }
                return RefreshIndicator(
                  color: AppColors.textDark,
                  onRefresh: () => _controller.fetchFeed(),
                  child: _buildFeedBody(feed),
                );
            }
          },
        ),
      ),
    );
  }

  Widget _buildFeedBody(FeedEntity feed) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
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
                feed.storeName,
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
            children: feed.categories.map((cat) {
              IconData icon = Icons.female;
              if (cat.name.toLowerCase().contains("men")) icon = Icons.male;
              if (cat.name.toLowerCase().contains("accessories")) icon = Icons.watch;
              if (cat.name.toLowerCase().contains("beauty")) icon = Icons.auto_awesome;
              return _buildCategoryItem(icon, cat.name, isSelected: cat.selected);
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
                    child: SmartImage(
                      src: feed.heroBanner.imageUrl,
                      fallbackAsset: "assets/images/1.jpg",
                    ),
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
                          feed.heroBanner.title.replaceAll(" ", "\n"),
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
              itemCount: feed.featureProducts.length,
              itemBuilder: (context, index) {
                final product = feed.featureProducts[index];
                final fallbacks = ["assets/images/2.jpg", "assets/images/3.png", "assets/images/4.png"];
                return ProductCardWidget(
                  product: product,
                  fallbackAsset: fallbacks[index % fallbacks.length],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(productId: product.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Middle Banner - HANG OUT & PARTY
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
                          feed.newCollection.label,
                          style: const TextStyle(fontSize: 11, color: AppColors.textGrey, letterSpacing: 0.5),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          feed.newCollection.title.replaceAll(" ", "\n"),
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
                          child: SmartImage(
                            src: feed.newCollection.imageUrl,
                            fallbackAsset: "assets/images/5.png",
                            height: 125,
                            width: 100,
                            fit: BoxFit.cover,
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

          // Recommended Section Cards
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: feed.recommended.length,
              itemBuilder: (context, index) {
                final p = feed.recommended[index];
                final fallbacks = ["assets/images/6.png", "assets/images/7.png"];
                return _buildSmallListProduct(p, fallbacks[index % fallbacks.length]);
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
          ...List.generate(feed.topCollections.length, (index) {
            final col = feed.topCollections[index];
            final fallbacks = ["assets/images/8.png", "assets/images/9.png"];
            return CollectionCardWidget(
              collection: col,
              fallbackAsset: fallbacks[index % fallbacks.length],
              bgColor: const Color(0xFFF8F8F8),
            );
          }),

          // Bottom 2 Side-by-Side Cards (Category Promos)
          if (feed.categoryPromos.length >= 2)
            Row(
              children: [
                Expanded(
                  child: SmallCollectionCardWidget(
                    collection: feed.categoryPromos[0],
                    fallbackAsset: "assets/images/10.png",
                    imageOnLeft: true,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: SmallCollectionCardWidget(
                    collection: feed.categoryPromos[1],
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

  Widget _buildSmallListProduct(ProductEntity p, String fallbackAsset) {
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
              child: SmartImage(
                src: p.imageUrl,
                fallbackAsset: fallbackAsset,
                width: 64,
                height: 64,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  p.formattedPrice,
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
