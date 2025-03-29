// lib/features/home/presentation/widgets/main_content.dart
import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/features/home/presentation/widgets/property_list.dart';
import 'package:juniper/features/home/presentation/widgets/segmented_tab.dart';
import '../../data/models/property.dart';
import '../../data/repositories/property.dart';

// property_categories.dart
class PropertyCategories extends StatelessWidget {
  final List<Property> properties;
  final Function(Property)? onPropertyTap;

  const PropertyCategories({
    super.key,
    required this.properties,
    this.onPropertyTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            width: 1,
            color: isDark ? AppColors.neutral800 : AppColors.borderLight,
          ),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SegmentedTabWidget(
            tabs: const ['Available', 'Funded', 'Exited'],
            content: [
              PropertyList(
                category: 'Available',
                properties:
                    PropertyProvider.filterByStatus(properties, 'Available'),
                onPropertyTap: onPropertyTap,
              ),
              PropertyList(
                category: 'Funded',
                properties:
                    PropertyProvider.filterByStatus(properties, 'Funded'),
                onPropertyTap: onPropertyTap,
              ),
              PropertyList(
                category: 'Exited',
                properties:
                    PropertyProvider.filterByStatus(properties, 'Exited'),
                onPropertyTap: onPropertyTap,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            'Popular Property',
            textAlign: TextAlign.start,
            style: theme.textTheme.titleLarge?.copyWith(
              color: isDark ? AppColors.neutral200 : AppColors.neutral800,
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
