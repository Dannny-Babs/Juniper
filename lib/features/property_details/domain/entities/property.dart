class Property {
  final String id;
  final String title;
  final String description;
  final String location;
  final double price;
  final List<String> images;
  final int beds;
  final int baths;
  final int sqft;
  final String type;
  final double roi;
  final String status;

  const Property({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.images,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.type,
    required this.roi,
    required this.status,
  });
}
