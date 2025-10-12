class Purchase {
  final String id;
  final String purchaseCode;
  final String middlemanId;
  final String farmerId;
  final String? batchId;
  final String productId;
  final double quantityKg;
  final double pricePerKg;
  final double totalPrice;
  final String currency;
  final String? paymentMode;
  final String paymentStatus;
  final String deliveryStatus;
  final DateTime purchaseDate;
  final DateTime updatedAt;

  // Related data from JOINs
  final String? farmerName;
  final String? farmerPhone;
  final String? farmerLocation;
  final String? productName;
  final String? productType;
  final String? productDescription;

  Purchase({
    required this.id,
    required this.purchaseCode,
    required this.middlemanId,
    required this.farmerId,
    this.batchId,
    required this.productId,
    required this.quantityKg,
    required this.pricePerKg,
    required this.totalPrice,
    required this.currency,
    this.paymentMode,
    required this.paymentStatus,
    required this.deliveryStatus,
    required this.purchaseDate,
    required this.updatedAt,
    this.farmerName,
    this.farmerPhone,
    this.farmerLocation,
    this.productName,
    this.productType,
    this.productDescription,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      purchaseCode: json['purchase_code'],
      middlemanId: json['middleman_id'],
      farmerId: json['farmer_id'],
      batchId: json['batch_id'],
      productId: json['product_id'],
      quantityKg: double.parse(json['quantity_kg'].toString()),
      pricePerKg: double.parse(json['price_per_kg'].toString()),
      totalPrice: double.parse(json['total_price'].toString()),
      currency: json['currency'] ?? 'INR',
      paymentMode: json['payment_mode'],
      paymentStatus: json['payment_status'],
      deliveryStatus: json['delivery_status'],
      purchaseDate: DateTime.parse(json['purchase_date']),
      updatedAt: DateTime.parse(json['updated_at']),
      farmerName: json['farmer_name'],
      farmerPhone: json['farmer_phone'],
      farmerLocation: json['farmer_location'],
      productName: json['product_name'],
      productType: json['product_type'],
      productDescription: json['product_description'],
    );
  }
}
