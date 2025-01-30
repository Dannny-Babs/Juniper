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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
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
              fontSize: 15,
            ),
          ),
          SizedBox(height: 8.sp),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 23,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textPrimaryDark : AppColors.neutral500,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
