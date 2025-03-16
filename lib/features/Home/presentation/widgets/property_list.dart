import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../../../features/home/data/models/property.dart';
import 'properties_card.dart';
import 'property_card.dart';

class PropertyList extends StatelessWidget {
  final String category;
  final List<Property> properties;
  final void Function(Property)? onPropertyTap;

  const PropertyList({
    super.key,
    required this.category,
    required this.properties,
    this.onPropertyTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          SizedBox(height: 12.h),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: properties.length > 5 ? 5 : properties.length,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              cacheExtent: 500.0,
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                final property = properties[index];
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: RepaintBoundary(
                    child: MiniPropertyCard(
                      key: ValueKey(property.id),
                      property: property,
                      onTap: onPropertyTap != null
                          ? () => onPropertyTap!(property)
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textStyle = theme.textTheme.titleLarge?.copyWith(
      color: isDark ? AppColors.neutral200 : AppColors.neutral800,
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$category Properties',
            style: textStyle,
          ),
          TextButton(
            onPressed: () {
              // Handle view all
            },
            child: const Text('View All'),
          ),
        ],
      ),
    );
  }
}

class InfinitePropertySliverList extends StatelessWidget {
  final List<Property> properties;
  final void Function(Property)? onPropertyTap;
  final Function()? onLoadMore;
  final bool isLoading;

  const InfinitePropertySliverList({
    super.key,
    required this.properties,
    this.onPropertyTap,
    this.onLoadMore,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == properties.length - 3 &&
              onLoadMore != null &&
              !isLoading) {
            onLoadMore!();
          }

          if (index == properties.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Center(
                child: Text(
                  "😔 That's the end...",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final property = properties[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: RepaintBoundary(
              child: PropertyCard(
                key: ValueKey(property.id),
                property: property,
                onTap: onPropertyTap != null
                    ? () => onPropertyTap!(property)
                    : null,
              ),
            ),
          );
        },
        childCount: properties.length + 1,
      ),
    );
  }
}
