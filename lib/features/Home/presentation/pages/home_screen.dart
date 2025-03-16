import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final List<Property> _properties = [];
  bool _isLoading = true;
  String? _error;
  final ScrollController _scrollController = ScrollController();

  static const _scrollThrottleDuration = Duration(milliseconds: 500);
  DateTime? _lastLoadTime;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadProperties();
    _scrollController.addListener(_throttledScrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_throttledScrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _throttledScrollListener() {
    final now = DateTime.now();
    if (_lastLoadTime != null &&
        now.difference(_lastLoadTime!) < _scrollThrottleDuration) {
      return;
    }
    _lastLoadTime = now;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 1000) {
      _loadMoreProperties();
    }
  }

  Future<void> _loadProperties() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final rawData = await PropertyProvider.fetchProperties();
      final loadedProperties =
          await compute(PropertyProvider.parseProperties, rawData);

      if (!mounted) return;

      setState(() {
        _properties.clear();
        _properties.addAll(loadedProperties);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = 'Failed to load properties. Please try again.';
        _isLoading = false;
      });
      debugPrint('Error loading properties: $e');
    }
  }

  Future<void> _loadMoreProperties() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final rawData = await PropertyProvider.fetchProperties();
      final loadedProperties =
          await compute(PropertyProvider.parseProperties, rawData);

      if (!mounted) return;

      setState(() {
        _properties.addAll(loadedProperties);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      debugPrint('Error loading more properties: $e');
    }
  }

  void _handlePropertyTap(Property property) {
    // Try to preload the property details
    try {
      context.read<PropertyDetailsBloc>().add(LoadPropertyDetails(property.id));
      
    } catch (e) {
      debugPrint('PropertyDetailsBloc not available: $e');
    }

    // Use push instead of go to maintain the back stack
    context.push('/property/${property.id}');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      maintainBottomViewPadding: true,
      top: false,
      child: RefreshIndicator(
        onRefresh: _loadProperties,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          cacheExtent: 1000.0,
          slivers: [
            const SliverToBoxAdapter(
              child: HomeHeader(),
            ),
            if (_isLoading && _properties.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (_error != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _error!,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadProperties,
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else if (_properties.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'No properties available',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              )
            else ...[
              SliverToBoxAdapter(
                child: PropertyCategories(
                  properties: _properties,
                  onPropertyTap: _handlePropertyTap,
                ),
              ),
              InfinitePropertySliverList(
                properties: _properties,
                onPropertyTap: _handlePropertyTap,
                onLoadMore: _loadMoreProperties,
                isLoading: _isLoading,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
