// TODO Implement this library.
class Product {
  final String id;
  final String name;
  final String type;
  final String unit;
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.type,
    required this.unit,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      unit: json['unit'] ?? 'kg',
      description: json['description'],
    );
  }
}

// Add this class at the top of your file (after imports)
class BatchFormData {
  String? selectedCategory;
  String? productId;
  String productName = '';
  String productType = '';
  double quantity = 0.0;
  int qualityRating = 5;
  DateTime? harvestDate;
  double geoLat = 12.9716;
  double geoLon = 77.5946;
  String locationName = "Bangalore, India";
  String notes = '';

  bool get isValid {
    return productId != null &&
        productId!.isNotEmpty &&
        quantity > 0 &&
        harvestDate != null;
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'farmer_id': 'dbd62bb4-618d-454a-9a90-523317ab3734',
      'initial_qty_kg': quantity,
      'unit': 'KG',
      'harvest_date': harvestDate?.toIso8601String(),
      'geo_lat': geoLat,
      'geo_lon': geoLon,
      'location_name': locationName,
      'meta_hash': 'hash-${DateTime.now().millisecondsSinceEpoch}',
    };
  }

  @override
  String toString() {
    return 'BatchFormData{productId: $productId, productName: $productName, quantity: $quantity, harvestDate: $harvestDate, qualityRating: $qualityRating, isValid: $isValid}';
  }
}
