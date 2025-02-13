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

      if (data == null || !data.containsKey('properties')) {
        debugPrint('Invalid JSON structure: missing properties key');
        return [];
      }

      final List<dynamic> propertyList = data['properties'];
      return propertyList.map((item) => Property.fromJson(item)).toList();
    } catch (e) {
      debugPrint('Error loading properties: $e');
      return [];
    }
  }

  static List<Property> filterByStatus(
      List<Property> properties, String status) {
    return properties.where((property) => property.status == status).toList();
  }
}
