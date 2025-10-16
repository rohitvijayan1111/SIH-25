class CartItem {
  final String id;           // Cart table row id
  final String userId;
  final String batchId;      // Usually maps to bppproductid from backend
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final String imageUrl;
  final String batchCode;
  final String farmerName;
  final String location;
  final String category;

  CartItem({
    required this.id,
    required this.userId,
    required this.batchId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.imageUrl,
    required this.batchCode,
    required this.farmerName,
    required this.location,
    required this.category,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      batchId: json['bpp_product_id'] ?? '',
      productId: json['product_id'] ?? '',       // Map this to your key
      productName: json['item_name'] ?? '',       // Use 'itemname' as the display name
      quantity: int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
      unitPrice: double.tryParse(json['unit_price']?.toString() ?? '0') ?? 0,
      imageUrl: json['image_url'] ?? '',
      batchCode: json['batch_code'] ?? '',
      farmerName: json['farmer_name'] ?? '',
      location: json['location'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
