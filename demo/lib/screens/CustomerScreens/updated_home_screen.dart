import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './favorites_screen.dart';
import './notification.dart';
import './product_details_screen.dart';
import 'cart_screen.dart';
import 'models/product_model.dart';
// import '../../services/product_service.dart';
// // Add this import

import '../../services/product_service.dart';
import 'widgets/category_card.dart';
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
  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    valuet = widget.value;
    _loadProducts();
  }

  /// Load products from API with error handling
  Future<void> _loadProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      if (valuet == 0) {
        // Load all products (crops, dairy, etc.)
        products = await ProductService.getAllProducts();
      } else {
        // Load filtered products by type for services
        products = await ProductService.getProductsByType('fertilizer');
        // You can also load multiple types:
        // products = await ProductService.getAllProducts();
        // products = products.where((p) => ['fertilizer', 'tool', 'seed'].contains(p.type)).toList();
      }

      filteredProducts = List.from(products);
      print(filteredProducts);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load products: ${e.toString()}';
        // Fallback to static data
        if (valuet == 0) {
          products = ProductData.getAllProducts();
        } else {
          products = ProductData.getAllServices();
        }
        filteredProducts = List.from(products);
      });
    }
  }

  /// Refresh products from API
  Future<void> _refreshProducts() async {
    await _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(76),
        child: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [Colors.green.shade600, Colors.green.shade400],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            // color: Color(0xFFCA6B27),
            color: Colors.orange,
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.3),
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
                        Text(
                          isLoading
                              ? 'Loading products...'
                              : 'Found ${products.length} products',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Refresh button
                  IconButton(
                    onPressed: _refreshProducts,
                    icon: Icon(
                      isLoading ? Icons.hourglass_empty : Icons.refresh,
                      color: Colors.white,
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
                          builder: (context) => const CartScreen(),
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
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    _searchFromAPI(value);
                  }
                },
              ),
            ),
            // Error/Status message
            if (errorMessage.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Using offline data. $errorMessage',
                        style: TextStyle(color: Colors.orange.shade700),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          errorMessage = '';
                        });
                      },
                    ),
                  ],
                ),
              ),
            if (errorMessage.isNotEmpty) const SizedBox(height: 8),
            // Categories
            _buildCategories(),

            // Featured Section
            // _buildFeaturedSection(),
            // Products Grid
            SizedBox(height: 18),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Loading products from API...'),
                        ],
                      ),
                    )
                  : _buildProductsGrid(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildCategories() {
  //   // final categories = valuet == 0
  //   //     ? _getApiCategories() // Get categories from loaded products
  //   //     : ProductData.getServiceCategories();
  //   final categories = ProductData.getServiceCategories();

  //   return Container(
  //     height: 40,
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: categories.length,
  //       itemBuilder: (context, index) {
  //         final category = categories[index];
  //         return CategoryCard(
  //           category: category,
  //           isSelected: selectedCategory == category,
  //           onTap: () {
  //             setState(() {
  //               selectedCategory = category;
  //               _filterByCategory();
  //             });
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildCategories() {
    final categories = valuet == 0
        ? _getApiCategories()
        : ProductData.getServiceCategories();
    return Container(
      height: 40, // fixed height ensures scrolling works!
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(), // <-- Add this line!
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

  /// Get categories from loaded API products
  List<String> _getApiCategories() {
    print("getApiCategories");
    Set<String> categories = {'All'};
    // Set<String> categories = {};
    for (var product in products) {
      if (product.category.isNotEmpty) {
        categories.add(product.category);
      }
    }
    print(categories.toList());
    return categories.toList();
  }

  Widget _buildFeaturedSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFB75E), Color(0xFFED8F03)],
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
                          'Fresh Products',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          errorMessage.isEmpty
                              ? 'Live data: ${products.length} items'
                              : 'Offline data: ${products.length} items',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ]
                    : [
                        const Text(
                          'Agricultural Services',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          errorMessage.isEmpty
                              ? 'Live data: ${products.length} items'
                              : 'Offline data: ${products.length} items',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
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
    if (filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No products found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _refreshProducts,
              child: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshProducts,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
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
      ),
    );
  }

  /// Search products from API
  Future<void> _searchFromAPI(String searchText) async {
    setState(() {
      isLoading = true;
    });

    try {
      final searchResults = await ProductService.searchProducts(searchText);
      setState(() {
        filteredProducts = searchResults;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Fallback to local search
      _filterProducts(searchText);
    }
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
        title: const Text('Filter & Actions'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Refresh from API'),
              leading: const Icon(Icons.refresh),
              onTap: () {
                Navigator.pop(context);
                _refreshProducts();
              },
            ),
            ListTile(
              title: const Text('Load Fertilizers'),
              leading: const Icon(Icons.grass),
              onTap: () async {
                Navigator.pop(context);
                setState(() {
                  isLoading = true;
                });
                try {
                  final fertilizers = await ProductService.getProductsByType(
                    'fertilizer',
                  );
                  setState(() {
                    products = fertilizers;
                    filteredProducts = fertilizers;
                    isLoading = false;
                    selectedCategory = 'All';
                  });
                } catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
            const Divider(),
            const Text('More filter options coming soon...'),
          ],
        ),
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
