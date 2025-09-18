// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../screens/product_details.dart';

// class CategorySection extends StatefulWidget {
//   final String category;
//   final List<dynamic> items;
//   final List<dynamic> providers;

//   const CategorySection({
//     super.key,
//     required this.category,
//     required this.items,
//     required this.providers,
//   });

//   @override
//   State<CategorySection> createState() => _CategorySectionState();
// }

// class _CategorySectionState extends State<CategorySection> {
//   final ScrollController _scrollController = ScrollController();
//   Timer? _autoScrollTimer;
//   double scrollPosition = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _startAutoScroll();
//   }

//   void _startAutoScroll() {
//     _autoScrollTimer = Timer.periodic(const Duration( seconds: 3 ), (timer) {
//       if (_scrollController.hasClients) {
//         final maxScroll = _scrollController.position.maxScrollExtent;
//         final viewportWidth = _scrollController.position.viewportDimension;

//         if (scrollPosition < maxScroll) {
//           scrollPosition += viewportWidth * 0.5; // scroll half screen width
//         } else {
//           scrollPosition = 0; // reset to start
//         }

//         _scrollController.animateTo(
//           scrollPosition,
//           duration: const Duration(seconds: 1),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _autoScrollTimer?.cancel();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Category Title
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             widget.category.toUpperCase(),
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const SizedBox(height: 8),

//         // Auto-scrolling horizontal carousel
//         SizedBox(
//           height: 260,
//           child: ListView.builder(
//             controller: _scrollController,
//             scrollDirection: Axis.horizontal,
//             itemCount: widget.items.length,
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             itemBuilder: (context, index) {
//               final item = widget.items[index];
//               final name = item['descriptor']?['name'] ?? 'Unknown Item';
//               final imageUrl =
//                   (item['descriptor']?['images'] != null &&
//                       item['descriptor']['images'].isNotEmpty)
//                   ? item['descriptor']['images'][0]
//                   : null;

//               final unit =
//                   item['quantity']?['unitized']?['measure']?['unit'] ?? '';
//               final batches = (item['batches'] as List<dynamic>? ?? []);
//               final price = batches.isNotEmpty
//                   ? (batches[0]['price']?['value'] ?? '-')
//                   : '-';

//               // Get seller (provider)
//               final provider = widget.providers.isNotEmpty
//                   ? widget.providers[index % widget.providers.length]
//                   : null;
//               final seller =
//                   provider?['descriptor']?['name'] ?? 'Unknown Seller';
//               final location =
//                   (provider?['locations'] != null &&
//                       provider!['locations'].isNotEmpty)
//                   ? provider['locations'][0]['address']
//                   : '';

//               return Container(
//                 width: 160,
//                 margin: const EdgeInsets.only(right: 12),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 2,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ProductDetails(product: item),
//                         ),
//                       );
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Upper Half: Image
//                         Expanded(
//                           flex: 5,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(12),
//                             ),
//                             child: imageUrl != null
//                                 ? Image.network(
//                                     imageUrl,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Container(
//                                     color: Colors.grey[200],
//                                     child: const Icon(
//                                       Icons.shopping_bag,
//                                       size: 60,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                           ),
//                         ),

//                         // Lower Half: Text
//                         Expanded(
//                           flex: 5,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(
//                                   name,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 Text(
//                                   "₹$price / $unit",
//                                   style: const TextStyle(
//                                     color: Colors.black87,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Seller: $seller",
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     color: Colors.green,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 if (location.isNotEmpty)
//                                   Text(
//                                     location,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import '../screens/product_details.dart';

// class CategorySection extends StatefulWidget {
//   final String category;
//   final List<dynamic> items;
//   final List<dynamic> providers;

//   const CategorySection({
//     super.key,
//     required this.category,
//     required this.items,
//     required this.providers,
//   });

//   @override
//   State<CategorySection> createState() => _CategorySectionState();
// }

// class _CategorySectionState extends State<CategorySection> {
//   final ScrollController _scrollController = ScrollController();
//   Timer? _autoScrollTimer;
//   double scrollPosition = 0.0;
//   final Random _random = Random();

//   @override
//   void initState() {
//     super.initState();
//     _startAutoScroll();
//   }

//   void _startAutoScroll() {
//     _scheduleNextScroll();
//   }

//   void _scheduleNextScroll() {
//     // Random delay: 2,3,4,5 seconds
//     final delay = [2, 3, 4, 5][_random.nextInt(4)];

//     _autoScrollTimer = Timer(Duration(seconds: delay), () {
//       if (_scrollController.hasClients) {
//         final maxScroll = _scrollController.position.maxScrollExtent;
//         final viewportWidth = _scrollController.position.viewportDimension;

//         if (scrollPosition < maxScroll) {
//           scrollPosition += viewportWidth * 0.5; // scroll half screen width
//         } else {
//           scrollPosition = 0; // reset to start
//         }

//         _scrollController.animateTo(
//           scrollPosition,
//           duration: const Duration(seconds: 1),
//           curve: Curves.easeInOut,
//         );
//       }

//       // Re-run with a new random delay
//       _scheduleNextScroll();
//     });
//   }

//   @override
//   void dispose() {
//     _autoScrollTimer?.cancel();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Category Title
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             widget.category.toUpperCase(),
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const SizedBox(height: 8),

//         // Auto-scrolling horizontal carousel
//         SizedBox(
//           height: 260,
//           child: ListView.builder(
//             controller: _scrollController,
//             scrollDirection: Axis.horizontal,
//             itemCount: widget.items.length,
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             itemBuilder: (context, index) {
//               final item = widget.items[index];
//               final name = item['descriptor']?['name'] ?? 'Unknown Item';
//               final imageUrl =
//                   (item['descriptor']?['images'] != null &&
//                       item['descriptor']['images'].isNotEmpty)
//                   ? item['descriptor']['images'][0]
//                   : null;

//               final unit =
//                   item['quantity']?['unitized']?['measure']?['unit'] ?? '';
//               final batches = (item['batches'] as List<dynamic>? ?? []);
//               final price = batches.isNotEmpty
//                   ? (batches[0]['price']?['value'] ?? '-')
//                   : '-';

//               // Get seller (provider)
//               final provider = widget.providers.isNotEmpty
//                   ? widget.providers[index % widget.providers.length]
//                   : null;
//               final seller =
//                   provider?['descriptor']?['name'] ?? 'Unknown Seller';
//               final location =
//                   (provider?['locations'] != null &&
//                       provider!['locations'].isNotEmpty)
//                   ? provider['locations'][0]['address']
//                   : '';

//               return Container(
//                 width: screenWidth < 600 ? 160 : 220, // Responsive width
//                 margin: const EdgeInsets.only(right: 12),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 2,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ProductDetails(product: item),
//                         ),
//                       );
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Upper Half: Image
//                         Expanded(
//                           flex: 5,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(12),
//                             ),
//                             child: imageUrl != null
//                                 ? Image.network(
//                                     imageUrl,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Container(
//                                     color: Colors.grey[200],
//                                     child: const Icon(
//                                       Icons.shopping_bag,
//                                       size: 60,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                           ),
//                         ),

//                         // Lower Half: Text
//                         Expanded(
//                           flex: 5,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(
//                                   name,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 Text(
//                                   "₹$price / $unit",
//                                   style: const TextStyle(
//                                     color: Colors.black87,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Seller: $seller",
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     color: Colors.green,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 if (location.isNotEmpty)
//                                   Text(
//                                     location,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import '../screens/product_details.dart';

// class CategorySection extends StatefulWidget {
//   final String category;
//   final List<dynamic> items;
//   final List<dynamic> providers;

//   const CategorySection({
//     super.key,
//     required this.category,
//     required this.items,
//     required this.providers,
//   });

//   @override
//   State<CategorySection> createState() => _CategorySectionState();
// }

// class _CategorySectionState extends State<CategorySection> {
//   final ScrollController _scrollController = ScrollController();
//   Timer? _autoScrollTimer;
//   double scrollPosition = 0.0;
//   final Random _random = Random();

//   bool get isTrending => widget.category.toLowerCase() == "trending";

//   @override
//   void initState() {
//     super.initState();
//     if (isTrending) {
//       _startAutoScroll();
//     }
//   }

//   void _startAutoScroll() {
//     _scheduleNextScroll();
//   }

//   void _scheduleNextScroll() {
//     final delay = [2, 3, 4, 5][_random.nextInt(4)];

//     _autoScrollTimer = Timer(Duration(seconds: delay), () {
//       if (_scrollController.hasClients) {
//         final maxScroll = _scrollController.position.maxScrollExtent;
//         final viewportWidth = _scrollController.position.viewportDimension;

//         if (scrollPosition < maxScroll) {
//           scrollPosition += viewportWidth * 0.5;
//         } else {
//           scrollPosition = 0;
//         }

//         _scrollController.animateTo(
//           scrollPosition,
//           duration: const Duration(seconds: 1),
//           curve: Curves.easeInOut,
//         );
//       }
//       _scheduleNextScroll();
//     });
//   }

//   @override
//   void dispose() {
//     _autoScrollTimer?.cancel();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     // 🔥 Different sizing for Trending vs Normal
//     final cardWidth = isTrending
//         ? (screenWidth < 600 ? 200 : 260)
//         : (screenWidth < 600 ? 160 : 220);

//     final cardHeight = isTrending ? 300.0 : 260.0;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Category Title
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             widget.category.toUpperCase(),
//             style: TextStyle(
//               fontSize: isTrending ? 20 : 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),

//         // Horizontal carousel
//         SizedBox(
//           height: cardHeight,
//           child: ListView.builder(
//             controller: _scrollController,
//             scrollDirection: Axis.horizontal,
//             physics: isTrending
//                 ? const AlwaysScrollableScrollPhysics()
//                 : const NeverScrollableScrollPhysics(), // disable manual scroll for non-trending
//             itemCount: widget.items.length,
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             itemBuilder: (context, index) {
//               final item = widget.items[index];
//               final name = item['descriptor']?['name'] ?? 'Unknown Item';
//               final imageUrl =
//                   (item['descriptor']?['images'] != null &&
//                       item['descriptor']['images'].isNotEmpty)
//                   ? item['descriptor']['images'][0]
//                   : null;

//               final unit =
//                   item['quantity']?['unitized']?['measure']?['unit'] ?? '';
//               final batches = (item['batches'] as List<dynamic>? ?? []);
//               final price = batches.isNotEmpty
//                   ? (batches[0]['price']?['value'] ?? '-')
//                   : '-';

//               // Get seller (provider)
//               final provider = widget.providers.isNotEmpty
//                   ? widget.providers[index % widget.providers.length]
//                   : null;
//               final seller =
//                   provider?['descriptor']?['name'] ?? 'Unknown Seller';
//               final location =
//                   (provider?['locations'] != null &&
//                       provider!['locations'].isNotEmpty)
//                   ? provider['locations'][0]['address']
//                   : '';

//               return Container(
//                 width: cardWidth.toDouble(),
//                 margin: const EdgeInsets.only(right: 12),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: isTrending ? 4 : 2,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => ProductDetails(product: item),
//                         ),
//                       );
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Upper Half: Image
//                         Expanded(
//                           flex: isTrending ? 6 : 5,
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(12),
//                             ),
//                             child: imageUrl != null
//                                 ? Image.network(
//                                     imageUrl,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Container(
//                                     color: Colors.grey[200],
//                                     child: const Icon(
//                                       Icons.shopping_bag,
//                                       size: 60,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                           ),
//                         ),

//                         // Lower Half: Text
//                         Expanded(
//                           flex: isTrending ? 4 : 5,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(
//                                   name,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: isTrending ? 16 : 14,
//                                   ),
//                                 ),
//                                 Text(
//                                   "₹$price / $unit",
//                                   style: const TextStyle(
//                                     color: Colors.black87,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Seller: $seller",
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     color: Colors.green,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 if (location.isNotEmpty)
//                                   Text(
//                                     location,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

import 'dart:async';
import 'dart:math';

import 'package:demo/screens/product_details.dart';
import 'package:flutter/material.dart';
import '../screens/product_details.dart';

class CategorySection extends StatefulWidget {
  final String category;
  final List<dynamic> items;
  final List<dynamic> providers;

  const CategorySection({
    super.key,
    required this.category,
    required this.items,
    required this.providers,
  });

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  double scrollPosition = 0.0;
  final Random _random = Random();

  bool get isTrending => widget.category.toLowerCase() == "trending";

  @override
  void initState() {
    super.initState();
    if (isTrending) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _scheduleNextScroll();
  }

  void _scheduleNextScroll() {
    final delay = [2, 3, 4, 5][_random.nextInt(4)];

    _autoScrollTimer = Timer(Duration(seconds: delay), () {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final viewportWidth = _scrollController.position.viewportDimension;

        if (scrollPosition < maxScroll) {
          scrollPosition += viewportWidth * 0.5;
        } else {
          scrollPosition = 0;
        }

        _scrollController.animateTo(
          scrollPosition,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
      _scheduleNextScroll();
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = isTrending
        ? (screenWidth < 600 ? 200.0 : 260.0)
        : (screenWidth < 600 ? 160.0 : 220.0);

    final cardHeight = isTrending ? 300.0 : 260.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.category.toUpperCase(),
            style: TextStyle(
              fontSize: isTrending ? 20 : 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Horizontal carousel
        SizedBox(
          height: cardHeight,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: isTrending
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            itemCount: widget.items.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final item = widget.items[index];
              final name = item['descriptor']?['name'] ?? 'Unknown Item';
              final imageUrl =
                  (item['descriptor']?['images'] != null &&
                      item['descriptor']['images'].isNotEmpty)
                  ? item['descriptor']['images'][0]
                  : null;

              final unit =
                  item['quantity']?['unitized']?['measure']?['unit'] ?? '';
              final batches = (item['batches'] as List<dynamic>? ?? []);
              final price = batches.isNotEmpty
                  ? (batches[0]['price']?['value'] ?? '-')
                  : '-';

              final provider = widget.providers.isNotEmpty
                  ? widget.providers[index % widget.providers.length]
                  : null;
              final seller =
                  provider?['descriptor']?['name'] ?? 'Unknown Seller';
              final location =
                  (provider?['locations'] != null &&
                      provider!['locations'].isNotEmpty)
                  ? provider['locations'][0]['address']
                  : '';

              return Container(

                width: cardWidth.toDouble(),

                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  color: Colors.green[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: isTrending ? 5 : 3,
                  shadowColor: Colors.green.withOpacity(0.3),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetails(product: item),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Upper Half: Image
                        Expanded(
                          flex: isTrending ? 6 : 5,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: imageUrl != null
                                ? Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors.green[100],
                                    child: const Icon(
                                      Icons.shopping_bag,
                                      size: 60,
                                      color: Colors.green,
                                    ),
                                  ),
                          ),
                        ),

                        // Lower Half: Text
                        Expanded(
                          flex: isTrending ? 4 : 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isTrending ? 16 : 14,
                                    color: Colors.green[900],
                                  ),
                                ),
                                Text(
                                  "₹$price / $unit",
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Seller: $seller",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.teal[700],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (location.isNotEmpty)
                                  Text(
                                    location,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
