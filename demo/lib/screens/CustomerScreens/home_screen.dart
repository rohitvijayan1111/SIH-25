// import 'package:flutter/material.dart';
// import 'models/product_model.dart';
// import 'widgets/product_card.dart';
// import 'widgets/category_card.dart';
// import 'widgets/search_bar.dart';

// import './cart_screen.dart';
// import './product_details_screen.dart'; // NEW import

// class HomeScreen extends StatefulWidget {
//   final int selectedIndex; // 👈 the integer value it receives

//   // 👈 mark as required if always needed

//   const HomeScreen({super.key, this.selectedIndex = 0});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late int current_index ;
//   @override
//   void initState() {
//     super.initState();
//     current_index = widget.selectedIndex;
//     // debugPrint("📌 Received index: ${widget.selectedIndex}");
//   }

//   String selectedCategory = 'All';
//   List<Product> products = current_index == 0
//       ? ProductData.getAllProducts()
//       : ProductData.getAllServices();
//   List<Product> filteredProducts = current_index == 0
//       ? ProductData.getAllProducts()
//       : ProductData.getAllServices();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),

//             // Search Bar
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: CustomSearchBar(
//                 onChanged: _filterProducts,
//                 onFilterTap: _showFilterDialog,
//               ),
//             ),

//             // Categories
//             _buildCategories(),

//             // Featured Section
//             _buildFeaturedSection(),

//             // Products Grid
//             Expanded(child: _buildProductsGrid()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 20,
//             backgroundColor: Colors.grey[300],
//             child: const Icon(Icons.person, color: Colors.grey),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Hello, Customer!',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 const Text(
//                   'Find fresh products',
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.notifications_outlined),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const CartScreen()),
//               );
//             },
//             icon: const Icon(Icons.shopping_cart),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategories() {
//     final categories = widget.selectedIndex == 0
//         ? ProductData.getCategories()
//         : ProductData.getServiceCategories();

//     return Container(
//       height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           return CategoryCard(
//             category: category,
//             isSelected: selectedCategory == category,
//             onTap: () {
//               setState(() {
//                 selectedCategory = category;
//                 _filterByCategory();
//               });
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFeaturedSection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Container(
//         height: 120,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               left: 16,
//               top: 16,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Fresh & Vegetables',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'Produced by local farmers\n& it\'s safe to eat',
//                     style: TextStyle(color: Colors.white70, fontSize: 12),
//                   ),
//                   const SizedBox(height: 8),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: const Color(0xFF4CAF50),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                     ),
//                     child: const Text(
//                       'Shop Now',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProductsGrid() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.8,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//         ),
//         itemCount: filteredProducts.length,
//         itemBuilder: (context, index) {
//           final product = filteredProducts[index];
//           return ProductCard(
//             product: product,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) =>
//                       ProductDetailsScreen(productName: product.name),
//                 ),
//               );
//             },
//             onFavoriteToggle: () => _toggleFavorite(product),
//           );
//         },
//       ),
//     );
//   }

//   void _filterProducts(String searchText) {
//     setState(() {
//       if (searchText.isEmpty) {
//         _filterByCategory();
//       } else {
//         filteredProducts = products
//             .where(
//               (product) =>
//                   product.name.toLowerCase().contains(searchText.toLowerCase()),
//             )
//             .toList();
//       }
//     });
//   }

//   void _filterByCategory() {
//     setState(() {
//       if (selectedCategory == 'All') {
//         filteredProducts = products;
//       } else {
//         filteredProducts = products
//             .where((product) => product.category == selectedCategory)
//             .toList();
//       }
//     });
//   }

//   void _toggleFavorite(Product product) {
//     setState(() {
//       final index = products.indexWhere((p) => p.id == product.id);
//       if (index != -1) {
//         products[index] = product.copyWith(isFavorite: !product.isFavorite);
//         _filterByCategory();
//       }
//     });
//   }

//   // Removed old _showProductDetails() and bottom sheet code
//   void _showFilterDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Filter Products'),
//         content: const Text('Filter options will be implemented here.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'models/product_model.dart';
// import 'widgets/product_card.dart';
// import 'widgets/category_card.dart';
// import 'widgets/search_bar.dart';

// import './cart_screen.dart';
// import './product_details_screen.dart';

// class HomeScreen extends StatefulWidget {
//   final int value;

//   const HomeScreen({super.key, this.value = 0});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late int currentIndex;
//   late int valuet;
//   String selectedCategory = 'All';

//   late List<Product> products;
//   late List<Product> filteredProducts;

//   @override
//   void initState() {
//     super.initState();
//     valuet = widget.value;

//     // Initialize products & filteredProducts here
//     if (valuet == 0) {
//       products = ProductData.getAllProducts();
//     } else {
//       products = ProductData.getAllServices();
//     }
//     filteredProducts = List.from(products);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),

//             // Search Bar
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: CustomSearchBar(
//                 onChanged: _filterProducts,
//                 onFilterTap: _showFilterDialog,
//               ),
//             ),

//             // Categories
//             _buildCategories(),

//             // Featured Section
//             _buildFeaturedSection(),

//             // Products Grid
//             Expanded(child: _buildProductsGrid()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 20,
//             backgroundColor: Colors.grey[300],
//             child: const Icon(Icons.person, color: Colors.grey),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Hello, Customer!',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 const Text(
//                   'Find fresh products',
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.notifications_outlined),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const CartScreen()),
//               );
//             },
//             icon: const Icon(Icons.shopping_cart),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategories() {
//     final categories = valuet == 0
//         ? ProductData.getCategories()
//         : ProductData.getServiceCategories();

//     return Container(
//       height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           return CategoryCard(
//             category: category,
//             isSelected: selectedCategory == category,
//             onTap: () {
//               setState(() {
//                 selectedCategory = category;
//                 _filterByCategory();
//               });
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFeaturedSection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Container(
//         height: 120,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               left: 16,
//               top: 16,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Fresh & Vegetables',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'Produced by local farmers\n& it\'s safe to eat',
//                     style: TextStyle(color: Colors.white70, fontSize: 12),
//                   ),
//                   const SizedBox(height: 8),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: const Color(0xFF4CAF50),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                     ),
//                     child: const Text(
//                       'Shop Now',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProductsGrid() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.8,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//         ),
//         itemCount: filteredProducts.length,
//         itemBuilder: (context, index) {
//           final product = filteredProducts[index];
//           return ProductCard(
//             product: product,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) =>
//                       ProductDetailsScreen(productName: product.name),
//                 ),
//               );
//             },
//             onFavoriteToggle: () => _toggleFavorite(product),
//           );
//         },
//       ),
//     );
//   }

//   void _filterProducts(String searchText) {
//     setState(() {
//       if (searchText.isEmpty) {
//         _filterByCategory();
//       } else {
//         filteredProducts = products
//             .where(
//               (product) =>
//                   product.name.toLowerCase().contains(searchText.toLowerCase()),
//             )
//             .toList();
//       }
//     });
//   }

//   void _filterByCategory() {
//     setState(() {
//       if (selectedCategory == 'All') {
//         filteredProducts = products;
//       } else {
//         filteredProducts = products
//             .where((product) => product.category == selectedCategory)
//             .toList();
//       }
//     });
//   }

//   void _toggleFavorite(Product product) {
//     setState(() {
//       final index = products.indexWhere((p) => p.id == product.id);
//       if (index != -1) {
//         products[index] = product.copyWith(isFavorite: !product.isFavorite);
//         _filterByCategory();
//       }
//     });
//   }

//   void _showFilterDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Filter Products'),
//         content: const Text('Filter options will be implemented here.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import './cart_screen.dart';
import './notification.dart'; // 👈 import your NotificationPage
import './product_details_screen.dart';
import 'models/product_model.dart';
import 'widgets/category_card.dart';
import 'widgets/product_card.dart';
import 'widgets/search_bar.dart';
import './favorites_screen.dart';

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

    // Initialize products & filteredProducts here
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
      color: Colors.green,
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
                    color: Colors.white,
                  ),
                ),
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
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
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
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = valuet == 0
        ? ProductData.getCategories()
        : ProductData.getServiceCategories();

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
                children: widget.value == 0
                    ? [
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
                          onPressed: () {
                            // Navigate to Products page
                          },
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
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to Services page
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF4CAF50),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: const Text(
                            'Book Now',
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
