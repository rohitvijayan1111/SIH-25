import 'package:flutter/material.dart';
import 'models/product_model.dart';
import 'widgets/product_card.dart';
import 'widgets/category_card.dart';
import 'widgets/search_bar.dart';

import './cart_screen.dart';
import './product_details_screen.dart'; // NEW import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  List<Product> products = ProductData.getAllProducts();
  List<Product> filteredProducts = ProductData.getAllProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomSearchBar(
                onChanged: _filterProducts,
                onFilterTap: _showFilterDialog,
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Customer!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const Text(
                  'Find fresh products',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = ProductData.getCategories();

    return Container(
      height: 50,
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
        height: 120,
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
                children: [
                  const Text(
                    'Fresh & Vegetables',
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
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF4CAF50),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'Shop Now',
                      style: TextStyle(fontSize: 12),
                    ),
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
          childAspectRatio: 0.8,
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
                  builder: (_) =>
                      ProductDetailsScreen(productName: product.name),
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

  // Removed old _showProductDetails() and bottom sheet code
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
