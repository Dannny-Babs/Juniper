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
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      price: json['price'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      beds: json['beds'] as int,
      baths: (json['baths'] as num).toDouble(),
      sqft: json['sqft'] as int,
      roi: json['roi'] as String,
      status: json['status'] as String? ?? 'Available',
      amenities: (json['amenities'] as List<dynamic>?)?.cast<String>() ?? [],
      type: json['type'] as String? ?? 'apartment',
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
      'type': type,
    };
  }
}
