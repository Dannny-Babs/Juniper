import 'package:flutter/material.dart';
import 'package:juniper/features/home/data/models/property.dart';
import 'package:juniper/core/widgets/optimized_image.dart';
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
    final borderColor =
        isDark ? AppColors.surfaceDark300 : AppColors.borderLight;

    return RepaintBoundary(
      child: Container(
        width: 240.w,
        height: 240.h,
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: borderColor,
            width: 1.w,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(context),
              SizedBox(height: 8.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            property.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                              color: isDark
                                  ? AppColors.neutral100
                                  : AppColors.neutral900,
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          _buildLocation(theme, isDark),
                        ],
                      ),
                      _buildPriceAndRoi(theme, isDark),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    // Updated to use OptimizedImage for caching and performance.
    return OptimizedImage(
      imageUrl: property.imageUrl,
      width: double.infinity,
      height: 125.h,
      borderRadius: 8.r,
      useShimmer: true,
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
        Expanded(
          child: Text(
            property.location,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.neutral400,
              fontSize: 13.sp,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
            fontSize: 16.sp,
            color: AppColors.primary600,
            height: 1.2,
          ),
        ),
        Row(
          children: [
            Text(
              'ROI: ',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDark ? AppColors.neutral300 : AppColors.neutral500,
                fontSize: 14.sp,
                height: 1.2,
              ),
            ),
            Text(
              property.roi,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.neutral100 : AppColors.neutral900,
                fontSize: 14.sp,
                height: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
