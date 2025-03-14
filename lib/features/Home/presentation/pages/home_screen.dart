import 'package:flutter/material.dart';
import 'package:juniper/features/home/presentation/widgets/home_header.dart';
import 'package:juniper/features/home/presentation/widgets/main_content.dart';
import 'package:juniper/features/home/presentation/widgets/property_list.dart';
import 'package:juniper/core/utils/utils.dart';

import '../../data/models/property.dart';
import '../../data/repositories/property.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Property> properties = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    if (!mounted) return;
    
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final loadedProperties = await PropertyProvider.loadProperties();
      if (!mounted) return;
      
      setState(() {
        properties = loadedProperties;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        error = 'Failed to load properties. Please try again.';
        isLoading = false;
      });
      debugPrint('Error loading properties: $e');
    }
  }

  void _handlePropertyTap(Property property) {
    context.pushNamed(
      'propertyDetails',
      pathParameters: {'propertyId': property.id},
    );
  }

  void _loadMoreProperties() async {
    if (isLoading) return;

    try {
      final loadedProperties = await PropertyProvider.loadProperties();
      if (!mounted) return;

      setState(() {
        properties.addAll(loadedProperties);
      });
    } catch (e) {
      debugPrint('Error loading more properties: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      top: false,
      child: RefreshIndicator(
        onRefresh: _loadProperties,
        child: CustomScrollView(
          slivers: [
            // Header Section
            SliverToBoxAdapter(
              child: HomeHeader(),
            ),

            if (isLoading)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (error != null)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        error!,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: _loadProperties,
                        child: Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              )
            else if (properties.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No properties available',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              )
            else ...[
              // Properties Section
              SliverToBoxAdapter(
                child: PropertyCategories(
                  properties: properties,
                  onPropertyTap: _handlePropertyTap,
                ),
              ),

              InfinitePropertySliverList(
                properties: properties,
                onPropertyTap: _handlePropertyTap,
                onLoadMore: _loadMoreProperties,
                isLoading: isLoading,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
