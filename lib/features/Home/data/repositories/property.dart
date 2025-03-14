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

  static Future<List<Property>> loadProperties() async {
    try {
      final String response = await rootBundle
          .loadString('lib/features/home/data/datasources/response.json');
      final data = await json.decode(response);

      if (data == null) {
        debugPrint('Error loading properties: JSON data is null');
        return [];
      }

      if (!data.containsKey('properties')) {
        debugPrint('Error loading properties: Missing "properties" key in JSON');
        return [];
      }

      final List<dynamic> propertyList = data['properties'];
      final List<Property> properties = [];

      for (var item in propertyList) {
        try {
          final property = Property.fromJson(item);
          properties.add(property);
        } catch (e) {
          debugPrint('Error parsing property: $e');
          debugPrint('Property data: $item');
          // Continue with next property instead of failing completely
          continue;
        }
      }

      return properties;
    } catch (e, stackTrace) {
      debugPrint('Error loading properties: $e');
      debugPrint('Stack trace: $stackTrace');
      return [];
    }
  }

  static List<Property> filterByStatus(List<Property> properties, String status) {
    return properties
        .where((property) => 
            property.status.toLowerCase() == status.toLowerCase())
        .toList();
  }
}
