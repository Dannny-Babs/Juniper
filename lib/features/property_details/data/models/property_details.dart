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
  final String? description;
  final double? rating;
  final int? reviewsCount;
  final Map<String, dynamic>? agent;
  final List<Map<String, dynamic>>? nearbyLandmarks;
  final Map<String, dynamic>? coordinates;
  final Map<String, dynamic>? investmentMetrics;
  final List<Map<String, dynamic>>? inspectionTimes;

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
    this.rating,
    this.reviewsCount,
    this.agent,
    this.nearbyLandmarks,
    this.coordinates,
    this.investmentMetrics,
    this.inspectionTimes,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) {
    // Helper functions for safe parsing
    int parseIntSafely(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) {
        return int.tryParse(value.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
      }
      return 0;
    }

    double parseDoubleSafely(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        return double.tryParse(value.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
      }
      return 0.0;
    }

    double parsePercentageSafely(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        return double.tryParse(value.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
      }
      return 0.0;
    }

    bool parseBoolSafely(dynamic value) {
      if (value == null) return false;
      if (value is bool) return value;
      if (value is String) {
        return value.toLowerCase() == 'true' || value == '1';
      }
      if (value is int) return value != 0;
      return false;
    }

    // Extract cap_rate from investment_metrics
    double getCapsRate() {
      if (json['investment_metrics'] is! Map) return 0.0;
      var metrics = json['investment_metrics'] as Map<String, dynamic>;
      var capRate = metrics['cap_rate'];
      return parsePercentageSafely(capRate);
    }

    // Extract and parse ROI
    double getRoi() {
      return parsePercentageSafely(json['roi']);
    }

    // Extract and process images
    List<String> getImages() {
      if (json['images'] is! List) return [];
      return (json['images'] as List).map((e) => e.toString()).toList();
    }

    return PropertyDetails(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      type: json['property_type']?.toString() ?? 'apartment',
      beds: parseIntSafely(json['beds']),
      baths: parseIntSafely(json['baths']),
      sqft: parseIntSafely(json['sqft']),
      amenities: json['amenities'] is List
          ? (json['amenities'] as List).map((e) => e.toString()).toList()
          : [],
      price: parseDoubleSafely(json['price']),
      profitability: getCapsRate(),
      investorCount: parseIntSafely(json['investor_count'] ?? 0),
      yearlyReturn: getRoi(),
      fiveYearReturn: getRoi() * 5,
      roi: getRoi(),
      images: getImages(),
      isFavorite: parseBoolSafely(json['is_favorite']),
      investmentProgress: parseDoubleSafely(json['investment_progress'] ?? 0.0),
      description: json['description']?.toString(),
      rating: parseDoubleSafely(json['rating']),
      reviewsCount: parseIntSafely(json['reviews_count']),
      agent:
          json['agent'] is Map ? json['agent'] as Map<String, dynamic> : null,
      nearbyLandmarks: json['nearby_landmarks'] is List
          ? (json['nearby_landmarks'] as List)
              .where((item) => item is Map)
              .map((item) => item as Map<String, dynamic>)
              .toList()
          : null,
      coordinates: json['coordinates'] is Map
          ? json['coordinates'] as Map<String, dynamic>
          : null,
      investmentMetrics: json['investment_metrics'] is Map
          ? json['investment_metrics'] as Map<String, dynamic>
          : null,
      inspectionTimes: json['inspection_times'] is List
          ? (json['inspection_times'] as List)
              .where((item) => item is Map)
              .map((item) => item as Map<String, dynamic>)
              .toList()
          : null,
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
      'description': description,
      'rating': rating,
      'reviews_count': reviewsCount,
      'agent': agent,
      'nearby_landmarks': nearbyLandmarks,
      'coordinates': coordinates,
      'investment_metrics': investmentMetrics,
      'inspection_times': inspectionTimes,
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
        description,
        rating,
        reviewsCount,
        agent,
        nearbyLandmarks,
        coordinates,
        investmentMetrics,
        inspectionTimes,
      ];
}
