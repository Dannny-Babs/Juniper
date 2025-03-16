class Property {
  final String id;
  final String title;
  final String description;
  final String price;
  final String location;
  final String imageUrl;
  final int beds;
  final double baths;
  final int sqft;
  final String roi;
  final String status;
  final List<String> amenities;
  final String type;
  final List<String> images;
  final Map<String, dynamic>? coordinates;
  final double? rating;
  final int? reviewsCount;
  final Map<String, dynamic>? agent;
  final List<Map<String, dynamic>>? nearbyLandmarks;
  final Map<String, dynamic>? investmentMetrics;

  Property({
    required this.id,
    required this.title,
    this.description = '',
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.roi,
    this.status = 'Available',
    this.amenities = const [],
    this.type = 'apartment',
    this.images = const [],
    this.coordinates,
    this.rating,
    this.reviewsCount,
    this.agent,
    this.nearbyLandmarks,
    this.investmentMetrics,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    // Handle string vs int conversions
    int parseIntSafely(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) {
        return int.tryParse(value) ?? 0;
      }
      return 0;
    }

    // Handle string vs double conversions
    double parseDoubleSafely(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        return double.tryParse(value) ?? 0.0;
      }
      return 0.0;
    }

    // Handle string values that should be booleans

    // Handle string vs list conversions

    // Handle images list and imageUrl
    List<String> imagesList = [];
    if (json['images'] != null) {
      if (json['images'] is List) {
        imagesList = (json['images'] as List).map((e) => e.toString()).toList();
      }
    }

    String imageUrl = '';
    if (json['imageUrl'] != null) {
      imageUrl = json['imageUrl'].toString();
    } else if (imagesList.isNotEmpty) {
      imageUrl = imagesList.first;
    }

    return Property(
      id: json['id'].toString(),
      title: json['title'].toString(),
      description: json['description']?.toString() ?? '',
      price: json['price'].toString(),
      location: json['location'].toString(),
      imageUrl: imageUrl,
      beds: parseIntSafely(json['beds']),
      baths: parseDoubleSafely(json['baths']),
      sqft: parseIntSafely(json['sqft']),
      roi: json['roi']?.toString() ?? '0%',
      status: json['status']?.toString() ?? 'Available',
      amenities: json['amenities'] is List
          ? (json['amenities'] as List).map((e) => e.toString()).toList()
          : [],
      type: json['property_type']?.toString() ?? 'apartment',
      images: imagesList,
      coordinates: json['coordinates'] is Map
          ? json['coordinates'] as Map<String, dynamic>
          : null,
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
      investmentMetrics: json['investment_metrics'] is Map
          ? json['investment_metrics'] as Map<String, dynamic>
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'imageUrl': imageUrl,
      'beds': beds,
      'baths': baths,
      'sqft': sqft,
      'roi': roi,
      'status': status,
      'amenities': amenities,
      'property_type': type,
      'images': images,
      'coordinates': coordinates,
      'rating': rating,
      'reviews_count': reviewsCount,
      'agent': agent,
      'nearby_landmarks': nearbyLandmarks,
      'investment_metrics': investmentMetrics,
    };
  }
}
