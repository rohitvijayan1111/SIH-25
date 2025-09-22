// import 'package:flutter/material.dart';
// import 'models/product_model.dart';
// import 'widgets/product_card.dart';

// class FavoritesScreen extends StatefulWidget {
//   final int value;
//   const FavoritesScreen({super.key, this.value = 0});

//   @override
//   State<FavoritesScreen> createState() => _FavoritesScreenState();
// }

// class _FavoritesScreenState extends State<FavoritesScreen> {
//   late int valuet
//   List<Product> favoriteProducts = [
//     const Product(
//       id: '3',
//       name: 'Tomatoes',
//       price: '60',
//       imageUrl: 'assets/CustomerUIAssets/images/tomato.jpg',
//       category: 'Vegetables',
//       description: 'Red ripe tomatoes',
//       farmerName: 'Farmer Bob',
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     valuet=widget.value;
//     // Get favorite products (in real app, this would come from state management)
//     favoriteProducts =
//         (widget.value == 0
//                 ? ProductData.getAllProducts()
//                 : ProductData.getAllServices())
//             .where((product) => product.isFavorite)
//             .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Favorites',
//           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           // Sort and Filter buttons
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.sort, color: Colors.black87),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.filter_list, color: Colors.black87),
//           ),
//         ],
//       ),
//       body: favoriteProducts.isEmpty
//           ? _buildEmptyState()
//           : _buildFavoritesList(),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.favorite_outline, size: 80, color: Colors.grey[400]),
//           const SizedBox(height: 16),
//           Text(
//             'No favorites yet',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Tap the heart icon on products\nto add them to your favorites',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: () {
//               // Navigate back to home to browse products
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF4CAF50),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//             child: const Text(
//               'Browse Products',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFavoritesList() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.8,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//         ),
//         itemCount: favoriteProducts.length,
//         itemBuilder: (context, index) {
//           final product = favoriteProducts[index];
//           return ProductCard(
//             product: product,
//             onTap: () => _showProductDetails(product),
//             onFavoriteToggle: () => _removeFavorite(product),
//           );
//         },
//       ),
//     );
//   }

//   void _removeFavorite(Product product) {
//     setState(() {
//       favoriteProducts.removeWhere((p) => p.id == product.id);
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Removed from favorites'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   void _showProductDetails(Product product) {
//     // Same as home screen - you can extract this to a shared widget
//   }
// }

import 'package:flutter/material.dart';
import 'models/product_model.dart';
import 'widgets/product_card.dart';
import './product_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final int value;
  const FavoritesScreen({super.key, this.value = 0});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late int valuet;
  late List<Product> favoriteProducts;

  @override
  void initState() {
    super.initState();
    valuet = widget.value;

    // Get favorite products (in real app, this would come from state management)
    favoriteProducts =
        (valuet == 0
                ? ProductData.getAllProducts()
                : ProductData.getAllServices())
            .where((product) => product.isFavorite)
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort, color: Colors.black87),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, color: Colors.black87),
          ),
        ],
      ),
      body: favoriteProducts.isEmpty
          ? _buildEmptyState()
          : _buildFavoritesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the heart icon on products\nto add them to your favorites',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back to browse products
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Browse Products',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return ProductCard(
            product: product,
            onTap: () => _showProductDetails(product),
            onFavoriteToggle: () => _removeFavorite(product),
          );
        },
      ),
    );
  }

  void _removeFavorite(Product product) {
    setState(() {
      favoriteProducts.removeWhere((p) => p.id == product.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from favorites'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ProductDetailsScreen(product: product, products: favoriteProducts),
      ),
    );
  }
}
