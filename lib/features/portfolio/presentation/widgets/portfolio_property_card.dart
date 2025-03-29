import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import '../../domain/models/portfolio_property.dart';
import '../../../../core/widgets/optimized_image.dart';

class PropertyCard extends StatelessWidget {
  final PortfolioProperty property;
  final VoidCallback? onTap;

  const PropertyCard({
    super.key,
    required this.property,
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
          color: isDark ? AppColors.neutral800 : AppColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          OptimizedImage(
            imageUrl: property.imageUrl,
            width: 60,
            height: 60,
            borderRadius: 8,
            useShimmer: false,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  property.location,
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
                '\${property.price}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '↑ ${property.changePercent}%',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: property.changePercent >= 0
                      ? AppColors.success500
                      : AppColors.error500,
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
