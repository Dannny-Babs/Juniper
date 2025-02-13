class Property {
  final String id;
  final String imageUrl; // Changed from image to imageUrl
  final String title;
  final String location;
  final String price;
  final String roi;
  final int beds;
  final double baths;
  final int sqft;
  final String status;

  const Property({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.roi,
    this.beds = 0,
    this.baths = 0.0,
    this.sqft = 0,
    required this.status,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id']?.toString() ?? '',
      imageUrl: json['imageUrl'] ??
          'https://images.unsplash.com/photo-1568605114967-8130f3a36994', // Provide a default URL instead of asset path
      title: json['title']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      roi: json['roi']?.toString() ?? '',
      beds: json['beds'] ?? 0,
      baths: (json['baths'] as num?)?.toDouble() ?? 0.0,
      sqft: json['sqft'] ?? 0,
      status: json['status']?.toString() ?? '',
    );
  }
}
