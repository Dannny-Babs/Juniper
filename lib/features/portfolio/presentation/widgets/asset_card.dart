import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/core/widgets/cached_image.dart';

class AssetCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final String change;
  final String imageUrl; // Add this
  final bool isPositive;
  final VoidCallback? onTap;

  // Make constructor const for better performance
  const AssetCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.change,
    required this.imageUrl, // Add this
    this.isPositive = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CachedImage(
              imageUrl: imageUrl,
              width: 40,
              height: 40,
              type: ImageType.asset, // Specify that we're using asset images
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? AppColors.neutral600 : AppColors.neutral500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                change,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isPositive ? AppColors.success500 : AppColors.error500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
