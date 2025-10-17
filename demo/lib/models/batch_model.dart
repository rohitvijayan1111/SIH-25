class BatchModel {
  final String id;
  final String batchCode;
  final double quantityKg;
  final String farmerName;
  final String unit;
  final double pricePerUnit;
  final DateTime expiryDate;

  BatchModel({
    required this.id,
    required this.batchCode,
    required this.quantityKg,
    required this.farmerName,
    required this.unit,
    required this.pricePerUnit,
    required this.expiryDate,
  });

  factory BatchModel.fromJson(Map<String, dynamic> json) {
    return BatchModel(
      id: json['batch_id'],
      batchCode: json['batch_code'],
      quantityKg: (json['available_qty'] is String)
          ? double.tryParse(json['available_qty']) ?? 0
          : (json['available_qty'] as num).toDouble(),
      farmerName: json['farmer_name'] ?? '',
      unit: json['unit'] ?? '',
      pricePerUnit: (json['price_per_unit'] is String)
          ? double.tryParse(json['price_per_unit']) ?? 0.0
          : (json['price_per_unit'] as num).toDouble(),
      expiryDate: DateTime.parse(json['expiry_date']),
    );
  }
}

// models/batch_model.dart
class Batch {
  final String id;
  final String? batchCode;
  final String productId;
  final String farmerId;
  final int availableQty; // current_qty_kg
  final String? unit;
  final double pricePerUnit;
  final int batchQuantity; // initial_qty_kg
  final double quantityKg;
  final DateTime? harvestDate;
  final String? locationName;
  final double? geoLat;
  final double? geoLon;
  final String? status;
  final String? metaHash;
  final String? chainTx;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime expiryDate;

  // Product details
  final String? productName;
  final String? productType;
  final String? productDescription;

  // Farmer details
  final String? farmerName;
  final String? farmerPhone;
  final String? farmerLocation;
  final bool? organicCertified;
  final String? certifications; // kyc_id

  Batch({
    required this.id,
    this.batchCode,
    required this.productId,
    required this.farmerId,
    required this.availableQty,
    this.unit,
    required this.pricePerUnit,
    required this.batchQuantity,
    required this.quantityKg,
    this.harvestDate,
    this.locationName,
    this.geoLat,
    this.geoLon,
    this.status,
    this.metaHash,
    this.chainTx,
    this.createdAt,
    this.updatedAt,
    this.productName,
    this.productType,
    this.productDescription,
    this.farmerName,
    this.farmerPhone,
    this.farmerLocation,
    this.organicCertified,
    this.certifications,
    required this.expiryDate,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      id: json['batch_id'] ?? '',
      batchCode: json['batch_code'],
      productId: json['product_id'] ?? '',
      farmerId: json['farmer_id'] ?? '',
      availableQty: int.tryParse(json['available_qty']?.toString() ?? '0') ?? 0,
      unit: json['unit'],
      pricePerUnit:
          double.tryParse(json['price_per_unit']?.toString() ?? '0') ?? 0.0,
      batchQuantity:
          int.tryParse(json['batch_quantity']?.toString() ?? '0') ?? 0,
      harvestDate: json['harvest_date'] != null
          ? DateTime.tryParse(json['harvest_date'])
          : null,
      quantityKg: (json['available_qty'] is String)
          ? double.tryParse(json['available_qty']) ?? 0
          : (json['available_qty'] as num).toDouble(),
      locationName: json['location_name'],
      geoLat: double.tryParse(json['geo_lat']?.toString() ?? ''),
      geoLon: double.tryParse(json['geo_lon']?.toString() ?? ''),
      status: json['status'],
      metaHash: json['meta_hash'],
      chainTx: json['chain_tx'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      productName: json['product_name'],
      productType: json['product_type'],
      productDescription: json['product_description'],
      farmerName: json['farmer_name'],
      farmerPhone: json['farmer_phone'],
      farmerLocation: json['farm_location'],
      organicCertified: json['organic_certified'],
      certifications: json['certifications'],
      expiryDate:
          DateTime.tryParse(json['expiry_date']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

class BatchHistoryItem {
  final String batchId;
  final String batchCode;
  final String productName;
  final String productType;
  final String farmerName;
  final String locationName;
  final int initialQuantity;
  final int currentQuantity;
  final String unit;
  final String harvestDate;
  final String status;
  final double pricePerUnit;
  final bool organic;
  final String? metaHash;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BatchHistoryItem({
    required this.batchId,
    required this.batchCode,
    required this.productName,
    required this.productType,
    required this.farmerName,
    required this.locationName,
    required this.initialQuantity,
    required this.currentQuantity,
    required this.unit,
    required this.harvestDate,
    required this.status,
    required this.pricePerUnit,
    required this.organic,
    this.metaHash,
    this.createdAt,
    this.updatedAt,
  });

  factory BatchHistoryItem.fromJson(Map<String, dynamic> json) {
    return BatchHistoryItem(
      batchId: json['id'] ?? json['batch_id'] ?? '',
      batchCode: json['batch_code'] ?? '',
      productName: json['product_name'] ?? '',
      productType: json['product_type'] ?? '',
      farmerName: json['farmer_name'] ?? '',
      locationName: json['location_name'] ?? '',
      initialQuantity: _parseInt(json['initial_qty_kg']),
      currentQuantity: _parseInt(json['current_qty_kg']),
      unit: json['unit'] ?? 'KG',
      harvestDate: json['harvest_date'] ?? '',
      status: json['status'] ?? 'PENDING',
      pricePerUnit: _parseDouble(json['price_per_unit']),
      organic: json['organic'] == true || json['organic'] == 'true',
      metaHash: json['meta_hash'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
