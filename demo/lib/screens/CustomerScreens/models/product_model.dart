
class Product {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String category;
  final String description;
  final String farmerName;
  final String averageBatchPrice;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.description = '',
    this.farmerName = '',
    required this.averageBatchPrice,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Product',
      price: json['weight'] ?? '0',
      imageUrl: json['image_url'] ?? '',
      category: _mapTypeToCategory(json['type'] ?? 'Unknown'),
      description: json['description'] ?? '',
      farmerName: json['farmer_id'] ?? '',
      averageBatchPrice: json['average_batch_price']?.toString() ?? '0',
    );
  }

  static String _mapTypeToCategory(String type) {
    switch (type.toLowerCase()) {
      case 'fertilizer':
        return 'Fertilizers';
      case 'crop':
        return 'Crops';
      case 'dairy':
        return 'Dairy';
      case 'tool':
        return 'Tools';
      case 'seed':
        return 'Seeds';
      case 'herbicide':
        return 'Herbicides';
      case 'pesticide':
        return 'Pesticides';
      case 'fungicide':
        return 'Fungicides';
      case 'growth_regulator':
        return 'Growth Regulators';
      case 'growth_promoter':
        return 'Growth Promoters';
      case 'micro_nutrient':
        return 'Micro Nutrients';
      case 'fruits':
        return 'Fruits';
      case 'vegetables':
        return 'Vegetables';
      case 'Cereal':
        return 'Cereals';

      default:
        return 'Others';
    }
  }

  String get displayPrice =>
      'Average price: ₹${double.tryParse(price)?.toStringAsFixed(0) ?? price}';

  String get displayAverageBatchPrice =>
      'Avg Batch: ₹${double.tryParse(averageBatchPrice)?.toStringAsFixed(0) ?? averageBatchPrice}';

  Product copyWith({bool? isFavorite, String? averageBatchPrice}) {
    return Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      category: category,
      description: description,
      farmerName: farmerName,
      averageBatchPrice: averageBatchPrice ?? this.averageBatchPrice,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Product.empty() {
    return Product(
      id: '',
      name: 'Unknown Product',
      price: '0',
      imageUrl: '',
      category: 'Unknown',
      description: '',
      farmerName: '',
      averageBatchPrice: '0',
      isFavorite: false,
    );
  }
}

class ProductData {
  static List<Product> getAllServices() {
    return []; // Empty list for now
  }

  static List<String> getServiceCategories() {
    return [
      // 'Herbicides',
      'Growth Regulators',
      'Fungicides',
      'Growth Promoters',
      // 'Fertilizers',
      'Micro Nutrients',
      // 'Seeds',
      'Pesticides',
      'Land Lease & Sale',
    ];
  }

  static List<Product> getAllProducts() {
    return [
      Product(
        id: '1',
        name: 'Broccoli',
        price: '120',
        imageUrl:
            'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400',
        category: 'Vegetables',
        description: 'Fresh green broccoli from local farms',
        farmerName: 'Farmer John',
        averageBatchPrice: '110',
        isFavorite: true,
      ),
      Product(
        id: '2',
        name: 'Papaya',
        price: '80',
        imageUrl:
            'https://m.media-amazon.com/images/I/61CuiyI4aBL._UF894,1000_QL80_.jpg',
        category: 'Fruits',
        description: 'Sweet and juicy papaya',
        farmerName: 'Farmer Mary',
        averageBatchPrice: '75',
        isFavorite: false,
      ),
      // Add more products as needed...
    ];
  }

  static List<String> getCategories() {
    return ['All', 'Vegetables', 'Fruits', 'Grains', 'Dairy'];
  }
}
