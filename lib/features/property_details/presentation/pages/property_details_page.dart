import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/optimized_image.dart';
import '../../data/models/property_details.dart';
import '../widgets/property_details_gallery.dart';

class PropertyDetailsPage extends StatelessWidget {
  final String propertyId;

  const PropertyDetailsPage({
    super.key,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    // Use Builder pattern to make sure we're inside a BlocProvider
    return BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
      builder: (context, state) {
        // Check if we need to load this property
        if (state is PropertyDetailsInitial ||
            (state is PropertyDetailsLoading &&
                state.propertyId != propertyId) ||
            (state is PropertyDetailsError && state.propertyId != propertyId) ||
            (state is PropertyDetailsLoaded &&
                state.propertyDetails.id != propertyId)) {
          // Trigger loading
          context
              .read<PropertyDetailsBloc>()
              .add(LoadPropertyDetails(propertyId));

          // Show loading state
          return _buildLoadingScaffold(context);
        }

        // Handle various states
        if (state is PropertyDetailsLoading) {
          return _buildLoadingScaffold(context);
        } else if (state is PropertyDetailsError) {
          return _buildErrorScaffold(context, state.message);
        } else if (state is PropertyDetailsLoaded) {
          return _buildPropertyDetailsContent(context, state.propertyDetails);
        }

        // Fallback (should not reach here)
        return _buildLoadingScaffold(context);
      },
    );
  }

  Widget _buildLoadingScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _safeNavigateBack(context),
        ),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorScaffold(BuildContext context, String message) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _safeNavigateBack(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error Loading Property',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context
                    .read<PropertyDetailsBloc>()
                    .add(RefreshPropertyDetails(propertyId));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _safeNavigateBack(BuildContext context) {
    try {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        context.go('/');
      }
    } catch (e) {
      debugPrint('Navigation error: $e');
      // Fallback navigation
      context.go('/');
    }
  }

  Widget _buildPropertyDetailsContent(
      BuildContext context, PropertyDetails property) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, property),
          _buildPropertyDetails(context, property),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context, property),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, PropertyDetails property) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'property_image_${property.id}',
          child: OptimizedImage(
            imageUrl: property.images.isNotEmpty ? property.images.first : '',
            width: double.infinity,
            height: 240,
            fit: BoxFit.cover,
            useShimmer: true,
            fallbackAssetImage: 'assets/images/properties/property1.jpg',
          ),
        ),
      ),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              property.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: property.isFavorite ? Colors.red : Colors.black,
            ),
          ),
          onPressed: () {
            // TODO: Implement favorite functionality
          },
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share, color: Colors.black),
          ),
          onPressed: () {
            // TODO: Implement share functionality
          },
        ),
      ],
    );
  }

  Widget _buildPropertyDetails(BuildContext context, PropertyDetails property) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property title
            Text(
              property.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Property location
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    property.location,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Property stats (beds, baths, sqft)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(context, '${property.beds}', 'Beds', Icons.bed),
                _buildStatItem(
                    context, '${property.baths}', 'Baths', Icons.bathtub),
                _buildStatItem(
                    context, '${property.sqft}', 'Sq.ft', Icons.square_foot),
              ],
            ),
            const SizedBox(height: 24),

            // Property price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${property.price.toStringAsFixed(0)}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'ROI',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${property.roi.toStringAsFixed(1)}%',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Property gallery
            if (property.images.length > 1) ...[
              PropertyDetailsGallery(images: property.images.skip(1).toList()),
              const SizedBox(height: 24),
            ],

            // Property description
            if (property.description != null &&
                property.description!.isNotEmpty) ...[
              Text(
                'Description',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                property.description!,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
            ],

            // Property amenities
            if (property.amenities.isNotEmpty) ...[
              Text(
                'Amenities',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: property.amenities
                    .map((amenity) => _buildAmenityChip(context, amenity))
                    .toList(),
              ),
              const SizedBox(height: 24),
            ],

            // Investment metrics
            if (property.investmentMetrics != null) ...[
              Text(
                'Investment Metrics',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildInvestmentMetrics(context, property),
              const SizedBox(height: 24),
            ],

            // Progress bar for investment
            if (property.investmentProgress > 0) ...[
              Text(
                'Investment Progress',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildInvestmentProgress(context, property),
              const SizedBox(height: 24),
            ],

            // Safety margin at the bottom
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context, String value, String label, IconData icon) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, color: theme.primaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildAmenityChip(BuildContext context, String amenity) {
    return Chip(
      label: Text(amenity),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      labelStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildInvestmentMetrics(
      BuildContext context, PropertyDetails property) {
    final metrics = property.investmentMetrics!;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMetricRow(
              context, 'Cap Rate', metrics['cap_rate']?.toString() ?? '-'),
          const Divider(),
          _buildMetricRow(context, 'Cash on Cash',
              metrics['cash_on_cash']?.toString() ?? '-'),
          const Divider(),
          _buildMetricRow(context, '5-Year Return',
              metrics['total_return_5yr']?.toString() ?? '-'),
          const Divider(),
          _buildMetricRow(context, 'Appreciation',
              metrics['appreciation_estimate']?.toString() ?? '-'),
        ],
      ),
    );
  }

  Widget _buildMetricRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentProgress(
      BuildContext context, PropertyDetails property) {
    final theme = Theme.of(context);
    final progress = property.investmentProgress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor: Colors.grey[300],
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${(progress * 100).toInt()}% Funded',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${property.investorCount} Investors',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, PropertyDetails property) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement investment action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Invest Now'),
            ),
          ),
        ],
      ),
    );
  }
}
