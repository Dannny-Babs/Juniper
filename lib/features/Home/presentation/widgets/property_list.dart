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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context),
        const SizedBox(height: 12),
        SizedBox(
          height: 243, // Fixed height for the horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: properties.length > 5 ? 5 : properties.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: MiniPropertyCard(
                  property: properties[index],
                  onTap: onPropertyTap != null
                      ? () => onPropertyTap!(properties[index])
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$category Properties',
          style: theme.textTheme.titleLarge?.copyWith(
            color: isDark ? AppColors.neutral200 : AppColors.neutral800,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle view all
          },
          child: Text('View All'),
        ),
      ],
    );
  }
}

// Create a new widget called InfinitePropertySliverList
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
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Text(
                "😔 That's the end...",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: PropertyCard(
              property: properties[index],
              onTap: onPropertyTap != null
                  ? () => onPropertyTap!(properties[index])
                  : null,
            ),
          );
        },
        childCount: properties.length + 1,
      ),
    );
  }
}
