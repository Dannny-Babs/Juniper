class Property {
  final String id;
  final String imageUrl;
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
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      location: json['location'],
      price: json['price'],
      roi: json['roi'],
      beds: json['beds'],
      baths: (json['baths'] as num).toDouble(),
      sqft: json['sqft'],
      status: json['status'],
    );
  }
}
