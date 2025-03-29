import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/features/home/data/models/property.dart';
import 'package:juniper/features/home/presentation/widgets/properties_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Properties',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              EneftyIcons.filter_outline,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              // TODO: Implement filter functionality
            },
          ),
        ],
      ),
      body: _mockFavorites.isEmpty
          ? _buildEmptyState(theme, isDark)
          : ListView.builder(
              padding: EdgeInsets.all(16.sp),
              itemCount: _mockFavorites.length,
              itemBuilder: (context, index) {
                final property = _mockFavorites[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: PropertyCard(
                    property: property,
                    onTap: () {
                      context.pushNamed(
                        'propertyDetails',
                        pathParameters: {'propertyId': property.id},
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            EneftyIcons.heart_outline,
            size: 64.sp,
            color: AppColors.neutral400,
          ),
          SizedBox(height: 16.h),
          Text(
            'No saved properties yet',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Properties you save will appear here',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.neutral500,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to home/search
            },
            child: Text('Explore Properties'),
          ),
        ],
      ),
    );
  }
}

final _mockFavorites = [
  Property(
    id: '1',
    title: 'The Urban Oasis',
    location: 'Downtown 1125, NY',
    price: '\$1,243,535',
    imageUrl: 'https://example.com/property1.jpg',
    beds: 2,
    baths: 1,
    sqft: 1500,
    roi: '8.64%',
  ),
  Property(
    id: '2',
    title: 'Skyline Towers',
    location: 'Midtown West, NY',
    price: '\$985,000',
    imageUrl: 'https://example.com/property2.jpg',
    beds: 3,
    baths: 2,
    sqft: 1800,
    roi: '7.5%',
  ),
]; 