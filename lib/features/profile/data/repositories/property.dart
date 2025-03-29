import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/property.dart';

class PropertyProvider {
  static Future<List<Property>> loadProperties() async {
    try {
      final String response = await rootBundle
          .loadString('lib/features/home/data/datasources/response.json');
      final data = json.decode(response);

      return (data['properties'] as List)
          .map((json) => Property.fromJson(json))
          .toList();
    } catch (e) {
      // Handle errors appropriately
      if (kDebugMode) {
        print('Error loading properties: $e');
      }
      return [];
    }
  }

  static List<Property> filterByStatus(
      List<Property> properties, String status) {
    return properties.where((property) => property.status == status).toList();
  }
}
