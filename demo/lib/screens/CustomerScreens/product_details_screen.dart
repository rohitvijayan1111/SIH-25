// import 'package:flutter/material.dart';
// import 'Widgets/product_card.dart';
// import 'models/product_model.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   final Product product;
//   final List<Product> products;

//   const ProductDetailsScreen({
//     super.key,
//     required this.product,
//     required this.products,
//   });

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   int quantity = 1;

//   void _toggleFavorite(Product product) {
//     setState(() {
//       product.isFavorite = !product.isFavorite;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final product = widget.product;

//     double price = double.tryParse(product.price) ?? 0.0;
//     double total = price * quantity;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           product.name,
//           style: const TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black87),
//         actions: [
//           IconButton(
//             onPressed: () => _toggleFavorite(product),
//             icon: Icon(
//               product.isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: Colors.redAccent,
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Image.network(product.imageUrl, fit: BoxFit.cover),
//             ),

//             // Product Info
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Category: ${product.category}",
//                     style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     "Farmer: ${product.farmerName}",
//                     style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     product.description,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       color: Colors.black87,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Quantity Selector & Price
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Quantity
//                       Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 if (quantity > 1) quantity--;
//                               });
//                             },
//                             icon: const Icon(Icons.remove_circle_outline),
//                           ),
//                           Text(
//                             "$quantity",
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 quantity++;
//                               });
//                             },
//                             icon: const Icon(Icons.add_circle_outline),
//                           ),
//                         ],
//                       ),

//                       // Price
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             "₹${price.toStringAsFixed(2)} each",
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           Text(
//                             "₹${total.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF4CAF50),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // Add to Cart Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               "${product.name} added to cart (x$quantity)",
//                             ),
//                             duration: const Duration(seconds: 2),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.shopping_cart),
//                       label: const Text(
//                         "Add to Cart",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF4CAF50),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'Widgets/product_card.dart';
// import 'models/product_model.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   final Product product;
//   final List<Product> products;

//   const ProductDetailsScreen({
//     super.key,
//     required this.product,
//     required this.products,
//   });

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   int quantity = 1;

//   void _toggleFavorite(Product product) {
//     setState(() {
//       product.isFavorite = !product.isFavorite;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final product = widget.product;

//     double price = double.tryParse(product.price) ?? 0.0;
//     double total = price * quantity;

//     // Dummy batches based on the product price
//     final List<Map<String, dynamic>> batches = [
//       {"batch": "Small Pack", "multiplier": 0.5},
//       {"batch": "Medium Pack", "multiplier": 1.0},
//       {"batch": "Large Pack", "multiplier": 2.0},
//       {"batch": "Family Pack", "multiplier": 5.0},
//     ];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           product.name,
//           style: const TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black87),
//         actions: [
//           IconButton(
//             onPressed: () => _toggleFavorite(product),
//             icon: Icon(
//               product.isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: Colors.redAccent,
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Image.network(product.imageUrl, fit: BoxFit.cover),
//             ),

//             // Product Info
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Category: ${product.category}",
//                     style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     "Farmer: ${product.farmerName}",
//                     style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     product.description,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       color: Colors.black87,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Quantity Selector & Price
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Quantity
//                       Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 if (quantity > 1) quantity--;
//                               });
//                             },
//                             icon: const Icon(Icons.remove_circle_outline),
//                           ),
//                           Text(
//                             "$quantity",
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 quantity++;
//                               });
//                             },
//                             icon: const Icon(Icons.add_circle_outline),
//                           ),
//                         ],
//                       ),

//                       // Price
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             "₹${price.toStringAsFixed(2)} each",
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           Text(
//                             "₹${total.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF4CAF50),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // Add to Cart Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               "${product.name} added to cart (x$quantity)",
//                             ),
//                             duration: const Duration(seconds: 2),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.shopping_cart),
//                       label: const Text(
//                         "Add to Cart",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF4CAF50),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),

//                   // Available Batches Section
//                   const Text(
//                     "Available Batches",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: batches.length,
//                     itemBuilder: (context, index) {
//                       final batch = batches[index];
//                       double batchPrice = price * batch["multiplier"];

//                       return Card(
//                         margin: const EdgeInsets.symmetric(vertical: 8),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 2,
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(12),
//                           title: Text(
//                             batch["batch"],
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                             ),
//                           ),
//                           subtitle: Text(
//                             "₹${batchPrice.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black54,
//                             ),
//                           ),
//                           trailing: ElevatedButton(
//                             onPressed: () {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     "${batch["batch"]} added to cart",
//                                   ),
//                                   duration: const Duration(seconds: 2),
//                                 ),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF4CAF50),
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text("Add"),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'models/product_model.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   final Product product;
//   final List<Product> products;

//   const ProductDetailsScreen({
//     super.key,
//     required this.product,
//     required this.products,
//   });

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   int selectedBatchIndex = 0; // Track which batch is selected

//   final Random random = Random();

//   late List<Map<String, dynamic>> batches;

//   @override
//   void initState() {
//     super.initState();

//     double basePrice = double.tryParse(widget.product.price) ?? 0.0;

//     // Dummy sellers/batches
//     batches = [
//       {
//         "seller": "Farmer Nanda",
//         "price": basePrice,
//         "stock": 100,
//         "expiry": "21/03/2026",
//         "stars": random.nextInt(5) + 1,
//       },
//       {
//         "seller": "AgroMart",
//         "price": basePrice * 0.8,
//         "stock": 190,
//         "expiry": "25/11/2025",
//         "stars": random.nextInt(5) + 1,
//       },
//       {
//         "seller": "Green Valley",
//         "price": basePrice * 1.1,
//         "stock": 50,
//         "expiry": "10/08/2026",
//         "stars": random.nextInt(5) + 1,
//       },
//     ];
//   }

//   Widget buildStars(int count) {
//     return Row(
//       children: List.generate(
//         5,
//         (index) => Icon(
//           index < count ? Icons.star : Icons.star_border,
//           color: Colors.amber,
//           size: 18,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final product = widget.product;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           "Product Details",
//           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black87),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Image.network(product.imageUrl, fit: BoxFit.cover),
//             ),
//             const SizedBox(height: 20),

//             // Available Batches
//             const Text(
//               "Available Batches",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 12),

//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: batches.length,
//               itemBuilder: (context, index) {
//                 final batch = batches[index];
//                 bool isSelected = index == selectedBatchIndex;

//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedBatchIndex = index;
//                     });
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       side: BorderSide(
//                         color: isSelected
//                             ? const Color(0xFF4CAF50)
//                             : Colors.grey.shade300,
//                         width: 2,
//                       ),
//                     ),
//                     elevation: isSelected ? 4 : 1,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Price + Stars
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "₹${batch["price"].toStringAsFixed(2)}",
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF4CAF50),
//                                 ),
//                               ),
//                               buildStars(batch["stars"]),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Seller: ${batch["seller"]}",
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             "Stock: ${batch["stock"]} packs",
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                           Text(
//                             "Expiry Date: ${batch["expiry"]}",
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                           if (isSelected)
//                             const Padding(
//                               padding: EdgeInsets.only(top: 8),
//                               child: Text(
//                                 "✓ Selected",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF4CAF50),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),

//             // Pickup Location
//             const Text(
//               "Pickup Location",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 6),
//             const Text(
//               "Ludhiana Central, Punjab\nGPS: 30.9005, 75.8573",
//               style: TextStyle(fontSize: 14, color: Colors.black87),
//             ),
//             const SizedBox(height: 30),

//             // Add to Cart
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   final batch = batches[selectedBatchIndex];
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         "${batch["seller"]}'s batch added to cart @ ₹${batch["price"]}",
//                       ),
//                       duration: const Duration(seconds: 2),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.shopping_cart),
//                 label: const Text(
//                   "Add to Cart",
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF4CAF50),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final List<Product> products;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.products,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final Random random = Random();

  late List<Map<String, dynamic>> batches;
  Map<int, int> cartQuantities = {}; // batchIndex -> quantity

  @override
  void initState() {
    super.initState();
    double basePrice = double.tryParse(widget.product.price) ?? 0.0;

    // Dummy seller batches
    batches = [
      {
        "seller": "Farmer Nanda",
        "price": basePrice,
        "stock": 100,
        "expiry": "21/03/2026",
        "arrival": "25/09/2025",
        "unit": "2kg per pack",
        "stars": random.nextInt(5) + 1,
      },
      {
        "seller": "AgroMart",
        "price": basePrice * 0.8,
        "stock": 190,
        "expiry": "25/11/2025",
        "arrival": "28/09/2025",
        "unit": "1kg per pack",
        "stars": random.nextInt(5) + 1,
      },
      {
        "seller": "Green Valley",
        "price": basePrice * 1.1,
        "stock": 50,
        "expiry": "10/08/2026",
        "arrival": "30/09/2025",
        "unit": "500g per pack",
        "stars": random.nextInt(5) + 1,
      },
    ];
  }

  Widget buildStars(int count) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < count ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 18,
        ),
      ),
    );
  }

  double calculateTotal() {
    double total = 0.0;
    cartQuantities.forEach((index, qty) {
      total += batches[index]["price"] * qty;
    });
    return total;
  }

  void updateCart(int index, int qty) {
    setState(() {
      if (qty > 0) {
        cartQuantities[index] = qty;
      } else {
        cartQuantities.remove(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 20),

                  // Available Batches
                  const Text(
                    "Available Batches",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: batches.length,
                    itemBuilder: (context, index) {
                      final batch = batches[index];
                      int qty = cartQuantities[index] ?? 0;

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: qty > 0
                                ? const Color(0xFF4CAF50)
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        elevation: qty > 0 ? 4 : 1,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Price + Stars
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹${batch["price"].toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4CAF50),
                                    ),
                                  ),
                                  buildStars(batch["stars"]),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text("Seller: ${batch["seller"]}"),
                              Text("Stock: ${batch["stock"]} packs"),
                              Text("Unit: ${batch["unit"]}"),
                              Text("Expiry Date: ${batch["expiry"]}"),
                              Text("Arrival Date: ${batch["arrival"]}"),

                              const SizedBox(height: 10),

                              // Quantity Selector
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  qty > 0
                                      ? Text(
                                          "Selected: $qty packs",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                        )
                                      : const SizedBox(),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (qty > 0) {
                                            updateCart(index, qty - 1);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        "$qty",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (qty < batch["stock"]) {
                                            updateCart(index, qty + 1);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.add_circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Pickup Location
                  const Text(
                    "Pickup Location",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Ludhiana Central, Punjab\nGPS: 30.9005, 75.8573",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Bottom Cart Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Total Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      "₹${calculateTotal().toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                // Add to Cart
                ElevatedButton.icon(
                  onPressed: cartQuantities.isNotEmpty
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Added ${cartQuantities.length} batch(es) to cart!",
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Add to Cart"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
