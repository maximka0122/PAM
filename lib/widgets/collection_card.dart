import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CollectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String fallbackAsset;
  final Color bgColor;
  final bool imageOnLeft;
  final double height;

  const CollectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.fallbackAsset = "assets/images/8.png",
    this.bgColor = const Color(0xFFF8F8F8),
    this.imageOnLeft = false,
    this.height = 175,
  });

  @override
  Widget build(BuildContext context) {
    final textContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 2,
                height: 14,
                color: Colors.grey.shade400,
                margin: const EdgeInsets.only(right: 6),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              height: 1.2,
            ),
          ),
        ],
      ),
    );

    final imageWidget = image.startsWith('assets/')
        ? Image.asset(
            image,
            height: 155,
            width: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(fallbackAsset, width: 120, height: 155, fit: BoxFit.cover),
          )
        : Image.network(
            image,
            height: 155,
            width: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(fallbackAsset, width: 120, height: 155, fit: BoxFit.cover),
          );

    final imageContent = Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageWidget,
          ),
        ],
      ),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: imageOnLeft
              ? [
                  Expanded(flex: 4, child: imageContent),
                  Expanded(flex: 5, child: textContent),
                ]
              : [
                  Expanded(flex: 5, child: textContent),
                  Expanded(flex: 4, child: imageContent),
                ],
        ),
      ),
    );
  }
}

class SmallCollectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String fallbackAsset;
  final bool imageOnLeft;

  const SmallCollectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.fallbackAsset = "assets/images/10.png",
    this.imageOnLeft = true,
  });

  @override
  Widget build(BuildContext context) {
    final textContent = Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 2,
                height: 12,
                color: Colors.grey.shade400,
                margin: const EdgeInsets.only(right: 4),
              ),
              Expanded(
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              height: 1.2,
            ),
          ),
        ],
      ),
    );

    final imageWidget = image.startsWith('assets/')
        ? Image.asset(
            image,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(fallbackAsset, fit: BoxFit.cover),
          )
        : Image.network(
            image,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(fallbackAsset, fit: BoxFit.cover),
          );

    final imageContent = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: imageWidget,
    );

    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: imageOnLeft
              ? [
                  Expanded(flex: 5, child: imageContent),
                  Expanded(flex: 6, child: textContent),
                ]
              : [
                  Expanded(flex: 6, child: textContent),
                  Expanded(flex: 5, child: imageContent),
                ],
        ),
      ),
    );
  }
}
