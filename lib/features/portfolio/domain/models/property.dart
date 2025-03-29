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
  final double monthlyIncome;
  final double occupancyRate;

  const Property({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.roi,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.status,
    required this.monthlyIncome,
    required this.occupancyRate,
  });
}
