import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const MetricCard({
    required this.title,
    required this.value,
    required this.description,
    this.isSelected = false,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.surfaceDark200 : AppColors.neutral200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textPrimaryDark : AppColors.neutral500,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              height: 1.2,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
              height: 1.2,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textPrimaryDark : AppColors.neutral500,
              fontWeight: FontWeight.normal,
              fontSize: 13.sp,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
