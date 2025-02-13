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
    final borderColor =
        isDark ? AppColors.surfaceDark200 : AppColors.neutral200;
    final boxDecoration = BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: borderColor,
        width: 1,
      ),
    );

    return RepaintBoundary(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            OptimizedImage(
              imageUrl: property.imageUrl,
              width: 320.w,
              height: 140.h,
              borderRadius: 8.r,
              useShimmer: true,
            ),
            SizedBox(height: 12.h),
            Text(
              property.title,
              style: theme.textTheme.titleMedium?.copyWith(
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.neutral800,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Row(
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
            ),
            SizedBox(height: 8.h),
            Row(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      property.changePercent >= 0
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 14.sp,
                      color: property.changePercent >= 0
                          ? AppColors.success500
                          : AppColors.error500,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '${property.changePercent.abs().toStringAsFixed(1)}%',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: property.changePercent >= 0
                            ? AppColors.success500
                            : AppColors.error500,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
