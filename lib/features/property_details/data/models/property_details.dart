import 'package:equatable/equatable.dart';

class PropertyDetails extends Equatable {
  final String id;
  final String title;
  final String location;
  final String type;
  final int beds;
  final int baths;
  final int sqft;
  final List<String> amenities;
  final double price;
  final double profitability;
  final int investorCount;
  final double yearlyReturn;
  final double fiveYearReturn;
  final double roi;
  final List<String> images;
  final bool isFavorite;
  final double investmentProgress;
  final String? description; // Add this field

  const PropertyDetails({
    required this.id,
    required this.title,
    required this.location,
    required this.type,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.amenities,
    required this.price,
    required this.profitability,
    required this.investorCount,
    required this.yearlyReturn,
    required this.fiveYearReturn,
    required this.roi,
    required this.images,
    this.isFavorite = false,
    required this.investmentProgress,
    this.description,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) {
    return PropertyDetails(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      type: json['type'] as String,
      beds: json['beds'] as int,
      baths: json['baths'] as int,
      sqft: json['sqft'] as int,
      amenities: List<String>.from(json['amenities']),
      price: (json['price'] as num).toDouble(),
      profitability: (json['profitability'] as num).toDouble(),
      investorCount: json['investor_count'] as int,
      yearlyReturn: (json['yearly_return'] as num).toDouble(),
      fiveYearReturn: (json['five_year_return'] as num).toDouble(),
      roi: (json['roi'] as num).toDouble(),
      images: List<String>.from(json['images']),
      isFavorite: json['is_favorite'] as bool? ?? false,
      investmentProgress: (json['investment_progress'] as num).toDouble(),
      description: json['description'] as String?, // Add this field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'type': type,
      'beds': beds,
      'baths': baths,
      'sqft': sqft,
      'amenities': amenities,
      'price': price,
      'profitability': profitability,
      'investor_count': investorCount,
      'yearly_return': yearlyReturn,
      'five_year_return': fiveYearReturn,
      'roi': roi,
      'images': images,
      'is_favorite': isFavorite,
      'investment_progress': investmentProgress,
      'description': description, // Add this field
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        type,
        beds,
        baths,
        sqft,
        amenities,
        price,
        profitability,
        investorCount,
        yearlyReturn,
        fiveYearReturn,
        roi,
        images,
        isFavorite,
        investmentProgress,
        description, // Add this field
      ];
}
