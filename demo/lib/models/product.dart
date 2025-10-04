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

class BatchFormData {
  String? productId;
  String productName = '';
  double quantity = 0.0;
  int qualityRating = 5;
  DateTime? harvestDate;
  double? geoLat;
  double? geoLon;
  String locationName = '';
  String notes = '';

  bool get isValid {
    return productId != null &&
        quantity > 0 &&
        harvestDate != null &&
        geoLat != null &&
        geoLon != null &&
        locationName.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'initial_qty_kg': quantity,
      'unit': 'KG',
      'harvest_date': harvestDate?.toIso8601String(),
      'geo_lat': geoLat,
      'geo_lon': geoLon,
      'location_name': locationName,
      'meta_hash': 'hash-${DateTime.now().millisecondsSinceEpoch}',
    };
  }
}
