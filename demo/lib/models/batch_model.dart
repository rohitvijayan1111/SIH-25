class BatchModel {
  final String id;
  final String batchCode;
  final double quantityKg;

  BatchModel({
    required this.id,
    required this.batchCode,
    required this.quantityKg,
  });

  factory BatchModel.fromJson(Map<String, dynamic> json) {
    return BatchModel(
      id: json['batch_id'],
      batchCode: json['batch_code'],
      quantityKg: (json['available_qty'] is String)
          ? double.tryParse(json['available_qty']) ?? 0
          : (json['available_qty'] as num).toDouble(),
    );
  }
}
