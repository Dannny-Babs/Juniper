import 'package:flutter/material.dart';
import 'package:juniper/features/home/data/models/property.dart';

import '../../../../core/utils/utils.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
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
      width: double.infinity,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.neutral800 : AppColors.borderLight,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            _buildDetails(theme, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: SizedBox(
        height: 180.h,
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl: property.imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
            highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: theme.colorScheme.surface,
            child: Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: theme.colorScheme.onSurface.withOpacity(0.4),
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(ThemeData theme, bool isDark) {
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: isDark ? AppColors.neutral100 : AppColors.neutral900,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.sp),
          _buildLocation(theme, isDark),
          SizedBox(height: 8.sp),
          _buildAmenities(theme, isDark),
          SizedBox(height: 8.sp),
          _buildPriceAndRoi(theme, isDark),
        ],
      ),
    );
  }

  Widget _buildLocation(ThemeData theme, bool isDark) {
    return Row(
      children: [
        Icon(
          EneftyIcons.location_outline,
          size: 16.sp,
          color: AppColors.primary500,
        ),
        SizedBox(width: 4.sp),
        Text(
          property.location,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.neutral400,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenities(ThemeData theme, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAmenityItem(
            theme, isDark, Icons.bed_outlined, '${property.beds} Beds'),
        _buildAmenityItem(
            theme, isDark, Icons.bathtub_outlined, '${property.baths} Baths'),
        _buildAmenityItem(
            theme, isDark, Icons.square_foot_outlined, '${property.sqft} sqft'),
      ],
    );
  }

  Widget _buildAmenityItem(
      ThemeData theme, bool isDark, IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: AppColors.primary500,
        ),
        SizedBox(width: 4.sp),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppColors.neutral300 : AppColors.neutral500,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndRoi(ThemeData theme, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          property.price,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 17.sp,
            color: AppColors.primary600,
          ),
        ),
        Row(
          children: [
            Text(
              'ROI: ',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDark ? AppColors.neutral300 : AppColors.neutral500,
              ),
            ),
            Text(
              property.roi,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.neutral100 : AppColors.neutral900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
