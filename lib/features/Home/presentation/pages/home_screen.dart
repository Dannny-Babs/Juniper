import 'package:flutter/material.dart';
import 'package:juniper/features/home/presentation/widgets/home_header.dart';
import 'package:juniper/features/home/presentation/widgets/main_content.dart';
import 'package:juniper/features/home/presentation/widgets/property_list.dart';

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

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    try {
      final loadedProperties = await PropertyProvider.loadProperties();
      setState(() {
        print(loadedProperties);
        properties = loadedProperties;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      // Handle error appropriately
    }
  }

  void _handlePropertyTap(Property property) {
    // Navigate to property detail page
    // Navigator.push(context, MaterialPageRoute(...));
  }

  void _loadMoreProperties() async {
    try {
      final loadedProperties = await PropertyProvider.loadProperties();
      setState(() {
        properties.addAll(loadedProperties);
      });
    } catch (e) {
      // Handle error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      top: false,
      child: CustomScrollView(
        slivers: [
          // Header Section
          SliverToBoxAdapter(
            child: HomeHeader(),
          ),

        

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
          ),
        ],
      ),
    );
  }
}
