import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../domain/entities/collection_entity.dart';
import 'state_widgets.dart';

class CollectionCardWidget extends StatelessWidget {
  final CollectionEntity collection;
  final String fallbackAsset;
  final Color bgColor;
  final bool imageOnLeft;
  final double height;

  const CollectionCardWidget({
    super.key,
    required this.collection,
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
                collection.label,
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
            collection.title.replaceAll(" ", "\n"),
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
            child: SmartImage(
              src: collection.imageUrl,
              fallbackAsset: fallbackAsset,
              height: 155,
              width: 120,
              fit: BoxFit.cover,
            ),
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

class SmallCollectionCardWidget extends StatelessWidget {
  final CollectionEntity collection;
  final String fallbackAsset;
  final bool imageOnLeft;

  const SmallCollectionCardWidget({
    super.key,
    required this.collection,
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
                  collection.category ?? collection.label,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            collection.title.replaceAll(" ", "\n"),
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

    final imageContent = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SmartImage(
        src: collection.imageUrl,
        fallbackAsset: fallbackAsset,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
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
