import 'dart:math';
import '../../../../features/home/data/models/property.dart';

class PortfolioProperty extends Property {
  final double investmentAmount;
  final double currentValue;
  final double monthlyIncome;
  final double changePercent; // Add this property

  PortfolioProperty({
    required super.id,
    required super.imageUrl, // Changed from image to imageUrl
    required super.title,
    required super.location,
    required super.price,
    required super.roi,
    required super.status,
    super.beds = 0,
    super.baths = 0,
    super.sqft = 0,
    required this.investmentAmount,
    required this.currentValue,
    required this.monthlyIncome,
    required this.changePercent, // Add this parameter
  });

  factory PortfolioProperty.fromProperty(Property property) {
    final random = Random();
    final change =
        (random.nextDouble() * 20) - 10; // Random value between -10 and 10

    return PortfolioProperty(
      id: property.id,
      imageUrl: property.imageUrl, // Changed from image to imageUrl
      title: property.title,
      location: property.location,
      price: property.price,
      roi: property.roi,
      status: property.status,
      beds: property.beds,
      baths: property.baths,
      sqft: property.sqft,
      investmentAmount: 100000, // Example values
      currentValue: 120000, // Example values
      monthlyIncome: 1200, // Example values
      changePercent: change, // Add random change percentage
    );
  }
}
