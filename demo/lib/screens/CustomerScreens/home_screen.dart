import 'package:flutter/material.dart';

import './favorites_screen.dart';
import './notification.dart';
import './product_details_screen.dart';
import 'cart_screen.dart';
import 'models/product_model.dart';
import 'widgets/category_card.dart';
// Import the fixed ProductCard
import 'widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  final int value;

  const HomeScreen({super.key, this.value = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int valuet;
  String selectedCategory = 'All';

  late List<Product> products;
  late List<Product> filteredProducts;

  @override
  void initState() {
    super.initState();
    valuet = widget.value;

    if (valuet == 0) {
      products = ProductData.getAllProducts();
    } else {
      products = ProductData.getAllServices();
    }
    filteredProducts = List.from(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(76),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade600, Colors.green.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Customer!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Find fresh products',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoritesScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(
                            userId: 'a985baac-9028-4dc1-bbd9-a6f3aae49ef5',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search products...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: _showFilterDialog,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: _filterProducts,
              ),
            ),
            // Categories
            _buildCategories(),
            // Featured Section
            _buildFeaturedSection(),
            // Products Grid
            Expanded(child: _buildProductsGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = valuet == 0
        ? ProductData.getCategories()
        : ProductData.getServiceCategories();

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(
            category: category,
            isSelected: selectedCategory == category,
            onTap: () {
              setState(() {
                selectedCategory = category;
                _filterByCategory();
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              top: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.value == 0
                    ? [
                        const Text(
                          'Fruits & Vegetables',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Produced by local farmers\n& it\'s safe to eat',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ]
                    : [
                        const Text(
                          'Crafted Services',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Affordable and reliable\nfrom trusted professionals',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7, // ✅ More height for images + text
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(
                    product: product,
                    products: products,
                  ),
                ),
              );
            },
            onFavoriteToggle: () => _toggleFavorite(product),
          );
        },
      ),
    );
  }

  void _filterProducts(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        _filterByCategory();
      } else {
        filteredProducts = products
            .where(
              (product) =>
                  product.name.toLowerCase().contains(searchText.toLowerCase()),
            )
            .toList();
      }
    });
  }

  void _filterByCategory() {
    setState(() {
      if (selectedCategory == 'All') {
        filteredProducts = products;
      } else {
        filteredProducts = products
            .where((product) => product.category == selectedCategory)
            .toList();
      }
    });
  }

  void _toggleFavorite(Product product) {
    setState(() {
      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = product.copyWith(isFavorite: !product.isFavorite);
        _filterByCategory();
      }
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Products'),
        content: const Text('Filter options will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
