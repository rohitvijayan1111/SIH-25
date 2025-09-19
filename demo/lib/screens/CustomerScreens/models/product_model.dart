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
        name: 'Broccoli',
        price: '120',
        imageUrl:
            'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400',
        category: 'Vegetables',
        description: 'Fresh green broccoli from local farms',
        farmerName: 'Farmer John',
        isFavorite: true,
      ),
      const Product(
        id: '2',
        name: 'Papaya',
        price: '80',
        imageUrl: 'assets/CustomerUIAssets/images/papaya.jpg',
        category: 'Fruits',
        description: 'Sweet and juicy papaya',
        farmerName: 'Farmer Mary',
        isFavorite: false,
      ),
      const Product(
        id: '3',
        name: 'Tomatoes',
        price: '60',
        imageUrl: 'assets/CustomerUIAssets/images/tomato.jpg',
        category: 'Vegetables',
        description: 'Red ripe tomatoes',
        farmerName: 'Farmer Bob',
        isFavorite: false,
      ),
      const Product(
        id: '4',
        name: 'Carrots',
        price: '45',
        imageUrl:
            'https://images.unsplash.com/photo-1447175008436-054170c2e979?w=400',
        category: 'Vegetables',
        description: 'Orange fresh carrots',
        farmerName: 'Farmer Alice',
        isFavorite: true,
      ),
      const Product(
        id: '6',
        name: 'Banana',
        price: '30',
        imageUrl: 'assets/CustomerUIAssets/images/banana.jpg',
        category: 'Fruits',
        description: 'Fresh bananas, source of potassium',
        farmerName: 'Farmer Kumar',
        isFavorite: false,
      ),

      const Product(
        id: '8',
        name: 'Wheat',
        price: '25',
        imageUrl: 'assets/CustomerUIAssets/images/wheat.jpg',
        category: 'Grains',
        description: 'High-quality wheat grains',
        farmerName: 'Farmer Ramesh',
        isFavorite: false,
      ),
      const Product(
        id: '9',
        name: 'Rice',
        price: '50',
        imageUrl: 'assets/CustomerUIAssets/images/rice.jpg',
        category: 'Grains',
        description: 'Premium basmati rice',
        farmerName: 'Farmer Devi',
        isFavorite: true,
      ),
      const Product(
        id: '10',
        name: 'Maize',
        price: '32',
        imageUrl: 'assets/CustomerUIAssets/images/maize.jpg',
        category: 'Grains',
        description: 'Fresh maize from the farm',
        farmerName: 'Farmer Mohan',
        isFavorite: false,
      ),
      // Dairy
      const Product(
        id: '11',
        name: 'Milk',
        price: '52',
        imageUrl: 'assets/CustomerUIAssets/images/milk.jpg',
        category: 'Dairy',
        description: 'Fresh cow milk delivered daily',
        farmerName: 'Dairy Farmhouse',
        isFavorite: true,
      ),
      const Product(
        id: '12',
        name: 'Paneer',
        price: '210',
        imageUrl: 'assets/CustomerUIAssets/images/paneer.jpg',
        category: 'Dairy',
        description: 'Soft cottage cheese, homemade',
        farmerName: 'Farmer Shanti',
      ),
      const Product(
        id: '13',
        name: 'Curd',
        price: '50',
        imageUrl: 'assets/CustomerUIAssets/images/curd.jpg',
        category: 'Dairy',
        description: 'Thick curd from desi cows',
        farmerName: 'Farmer Anil',
        isFavorite: true,
      ),
      const Product(
        id: '14',
        name: 'Butter',
        price: '380',
        imageUrl: 'assets/CustomerUIAssets/images/butter.webp',
        category: 'Dairy',
        description: 'Freshly churned yellow butter',
        farmerName: 'Dairy Collective',
        isFavorite: true,
      ),
    ];
  }

  static List<String> getCategories() {
    return ['All', 'Vegetables', 'Fruits', 'Grains', 'Dairy'];
  }
}
