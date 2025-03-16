import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../../domain/repositories/property_repository.dart';
import '../models/property_details.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  @override
  Future<PropertyDetails> getPropertyDetails(String propertyId) async {
    try {
      // Simulate network delay (shorter for better UX)
      await Future.delayed(const Duration(milliseconds: 300));

      // Load the properties JSON file
      final String response = await rootBundle
          .loadString('lib/features/home/data/datasources/response.json');
      final data = await json.decode(response);

      if (!data.containsKey('properties')) {
        throw Exception('Properties data not found');
      }

      // Find the property with the matching ID
      final List<dynamic> propertyList = data['properties'];
      Map<String, dynamic>? propertyData;

      try {
        propertyData = propertyList.firstWhere(
          (property) => property['id'].toString() == propertyId,
        ) as Map<String, dynamic>;
      } catch (e) {
        throw Exception('Property not found with ID: $propertyId');
      }

      // Add default values for fields that might cause errors
      propertyData['investment_progress'] =
          propertyData['investment_progress'] ?? 0.0;
      propertyData['investor_count'] = propertyData['investor_count'] ?? 0;
      propertyData['is_favorite'] = propertyData['is_favorite'] ?? false;

      // Create a PropertyDetails object from the found property data
      final PropertyDetails details = PropertyDetails.fromJson(propertyData);
      return details;
    } catch (e, stackTrace) {
      debugPrint('Error loading property details: $e');
      debugPrint('Stack trace: $stackTrace');
      throw Exception('Failed to load property details: $e');
    }
  }
}
