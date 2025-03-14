import '../../data/models/property_details.dart';

abstract class PropertyRepository {
  Future<PropertyDetails> getPropertyDetails(String propertyId);
} 