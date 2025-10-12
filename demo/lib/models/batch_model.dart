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
