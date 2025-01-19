import 'package:flutter/material.dart';
import 'package:juniper/features/home/data/models/property.dart';

import '../../../../core/utils/utils.dart';

class MiniPropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;

  const MiniPropertyCard({
    super.key,
    required this.property,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 240.w,
      
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.surfaceDark300 : AppColors.borderLight,
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

    // Image with error handling
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: SizedBox(
        height: 120.h,
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
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: isDark ? AppColors.neutral100 : AppColors.neutral900,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          _buildLocation(theme, isDark),
          SizedBox(height: 8.h),
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
        SizedBox(width: 4.w),
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
