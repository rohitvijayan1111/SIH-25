class Product {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String category;
  final bool isFavorite;
  final String description;
  final String farmerName;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
    this.description = '',
    this.farmerName = '',
  });

  // Create a copy of product with updated favorite status
  Product copyWith({bool? isFavorite}) {
    return Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      category: category,
      isFavorite: isFavorite ?? this.isFavorite,
      description: description,
      farmerName: farmerName,
    );
  }
}

// Sample data for demonstration
class ProductData {
  static List<Product> getAllProducts() {
    return [
      const Product(
        id: '1',
        name: 'Fresh Broccoli',
        price: '120',
        imageUrl:
            'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400',
        category: 'Vegetables',
        description: 'Fresh green broccoli from local farms',
        farmerName: 'Farmer John',
      ),
      const Product(
        id: '2',
        name: 'Fresh Papaya',
        price: '80',
        imageUrl:
            'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400',
        category: 'Fruits',
        description: 'Sweet and juicy papaya',
        farmerName: 'Farmer Mary',
      ),
      const Product(
        id: '3',
        name: 'Fresh Tomatoes',
        price: '60',
        imageUrl:
            'https://images.unsplash.com/photo-1546470427-227aeb7abd5e?w=400',
        category: 'Vegetables',
        description: 'Red ripe tomatoes',
        farmerName: 'Farmer Bob',
      ),
      const Product(
        id: '4',
        name: 'Fresh Carrots',
        price: '45',
        imageUrl:
            'https://images.unsplash.com/photo-1447175008436-054170c2e979?w=400',
        category: 'Vegetables',
        description: 'Orange fresh carrots',
        farmerName: 'Farmer Alice',
      ),
    ];
  }

  static List<String> getCategories() {
    return ['All', 'Vegetables', 'Fruits', 'Grains', 'Dairy'];
  }
}
