import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../models/property.dart';

class PropertyProvider {
  static const List<String> _fallbackImages = [
    'assets/images/properties/property1.jpg',
    'assets/images/properties/property2.jpg',
    'assets/images/properties/property3.jpg',
    'assets/images/properties/property4.jpg',
  ];

  static String getFallbackImage(int index) {
    return _fallbackImages[index % _fallbackImages.length];
  }

  static Future<List<Property>> loadProperties({int limit = 10}) async {
    try {
      final String response = await rootBundle
          .loadString('lib/features/home/data/datasources/response.json');
      final data = await json.decode(response);

      if (data == null) {
        debugPrint('Error loading properties: JSON data is null');
        return [];
      }

      if (!data.containsKey('properties')) {
        debugPrint(
            'Error loading properties: Missing "properties" key in JSON');
        return [];
      }

      final List<dynamic> propertyList = data['properties'];
      final List<Property> properties = [];

      for (var item in propertyList) {
        try {
          // Make sure each property has at least one image
          if (!item.containsKey('imageUrl') &&
              item.containsKey('images') &&
              item['images'].isNotEmpty) {
            item['imageUrl'] = item['images'][0];
          } else if (!item.containsKey('imageUrl') &&
              (!item.containsKey('images') || item['images'].isEmpty)) {
            item['imageUrl'] = getFallbackImage(properties.length);
          }

          final property = Property.fromJson(item);
          properties.add(property);
        } catch (e) {
          debugPrint('Error parsing property: $e');
          debugPrint('Property data: $item');
          // Continue with next property instead of failing completely
          continue;
        }
      }

      return properties.take(limit).toList();
    } catch (e, stackTrace) {
      debugPrint('Error loading properties: $e');
      debugPrint('Stack trace: $stackTrace');
      return [];
    }
  }

  static List<Property> filterByStatus(
      List<Property> properties, String status) {
    return properties
        .where(
            (property) => property.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  static Future<String> fetchProperties() async {
    try {
      return await rootBundle
          .loadString('lib/features/home/data/datasources/response.json');
    } catch (e) {
      debugPrint('Error fetching property data: $e');
      throw Exception('Failed to fetch property data');
    }
  }

  static List<Property> parseProperties(String jsonData) {
    try {
      final data = json.decode(jsonData);

      if (data == null || !data.containsKey('properties')) {
        return [];
      }

      final List<dynamic> propertyList = data['properties'];
      final List<Property> properties = [];

      for (var item in propertyList) {
        try {
          // Make sure each property has at least one image and that all required fields are present
          if (item is Map<String, dynamic>) {
            // Ensure all required fields exist, even if null
            // This prevents errors during parsing
            final requiredFields = [
              'id',
              'title',
              'price',
              'location',
              'beds',
              'baths',
              'sqft',
              'roi'
            ];

            for (var field in requiredFields) {
              if (!item.containsKey(field)) {
                item[field] = field == 'roi' ? '0%' : '';
              }
            }

            // Handle imageUrl and images
            if (!item.containsKey('imageUrl') &&
                item.containsKey('images') &&
                item['images'] is List &&
                (item['images'] as List).isNotEmpty) {
              item['imageUrl'] = (item['images'] as List).first.toString();
            } else if (!item.containsKey('imageUrl') ||
                (item['imageUrl'] == null) ||
                (!item.containsKey('images') ||
                    item['images'] == null ||
                    (item['images'] is List &&
                        (item['images'] as List).isEmpty))) {
              item['imageUrl'] = getFallbackImage(properties.length);
            }

            final property = Property.fromJson(item);
            properties.add(property);
          }
        } catch (e, stackTrace) {
          debugPrint('Error parsing property: $e');
          debugPrint('Stack trace: $stackTrace');
          // Continue with next property instead of failing completely
        }
      }

      return properties;
    } catch (e, stackTrace) {
      debugPrint('Error parsing properties: $e');
      debugPrint('Stack trace: $stackTrace');
      return [];
    }
  }
}
