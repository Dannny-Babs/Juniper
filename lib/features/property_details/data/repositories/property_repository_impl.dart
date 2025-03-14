import '../../domain/repositories/property_repository.dart';
import '../models/property_details.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  @override
  Future<PropertyDetails> getPropertyDetails(String propertyId) async {
    // Mock implementation for testing
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    return PropertyDetails(
      id: propertyId,
      title: 'The Urban Oasis',
      location: 'Down town 1125, NY',
      type: 'Condominium',
      beds: 3,
      baths: 2,
      sqft: 1200,
      amenities: ['Shopping center', 'Private pool', 'Fitness Center'],
      price: 1243535,
      profitability: 8.64,
      investorCount: 146,
      yearlyReturn: 8.37,
      fiveYearReturn: 42.64,
      roi: 4.42,
      images: [
        'https://example.com/property1.jpg',
        'https://example.com/property2.jpg',
        'https://example.com/property3.jpg',
        'https://example.com/property4.jpg',
      ],
      investmentProgress: 0.75,
    );
  }
} 