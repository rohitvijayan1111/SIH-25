// import 'dart:math';
// import 'package:demo/models/batch_model.dart';
// import 'package:flutter/material.dart';

// import '../../global.dart';
// import 'models/product_model.dart';
// import 'package:demo/models/batch_model.dart'; // New import for batch model
// import '../../services/api_service.dart'; // New import for API calls
// import 'product_history.dart';

// class LogisticProvider {
//   final String name;
//   final double baseValue;
//   final double ratio;

//   LogisticProvider({
//     required this.name,
//     required this.baseValue,
//     required this.ratio,
//   });

//   double calculateCharge(int daysFromNow, int qty) {
//     // service charge = baseValue + ratio * days + random factor
//     return (baseValue + (ratio * daysFromNow) + Random().nextDouble() * 10) *
//         qty;
//   }
// }

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
//   final Random random = Random();

//   late Future<List<Batch>> futureBatches;

//   Product? product;
//   Map<int, int> cartQuantities = {}; // batchIndex -> quantity
//   Map<int, int> selectedProviders = {}; // batchIndex -> providerIndex
//   Map<int, DateTime> selectedDates = {}; // batchIndex -> date
//   Map<int, double> selectedCharges = {}; // batchIndex -> charge

//   final List<LogisticProvider> logisticsProviders = [
//     LogisticProvider(name: "DTDC", baseValue: 45, ratio: 8),
//     LogisticProvider(name: "LoadShare Networks", baseValue: 50, ratio: 10),
//     LogisticProvider(name: "Shiprocket", baseValue: 42, ratio: 9),
//     LogisticProvider(name: "Mahindra Logistics", baseValue: 60, ratio: 7),
//     LogisticProvider(name: "iThink Logistics", baseValue: 54, ratio: 8),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     product = widget.product;
//     final String productId = product?.id ?? '';
//     if (product != null && product!.id.isNotEmpty) {
//       futureBatches = ApiService.getBatchesForProduct(productId);
//     } else {
//       futureBatches = Future.value([]);
//     }
//     print("ProductDetailsScreen: product.id = '${product?.id}'");
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

//   double calculateTotal(List<Batch> batches) {
//     double total = 0.0;
//     cartQuantities.forEach((index, qty) {
//       if (index < batches.length) {
//         total += (batches[index].pricePerUnit) * qty;
//       }
//     });
//     return total;
//   }

//   void updateCart(int index, int qty) {
//     setState(() {
//       if (qty > 0) {
//         cartQuantities[index] = qty;
//       } else {
//         cartQuantities.remove(index);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final product = widget.product;
//     final String productId = product.id ?? '';
//     futureBatches = ApiService.getBatchesForProduct(productId);

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
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 200,
//                     width: double.infinity,
//                     child: Image.network(
//                       product.imageUrl,
//                       fit: BoxFit.contain,
//                       alignment: Alignment.center,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product.name,
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           product.category,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.black54,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           product.description,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Available Batches",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   FutureBuilder<List<Batch>>(
//                     future: futureBatches,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Text(
//                           "Failed to fetch batches: ${snapshot.error}",
//                         );
//                       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                         return const Text(
//                           "No batches available for this product",
//                         );
//                       } else {
//                         List<Batch> batches = snapshot.data!;
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: batches.length,
//                           itemBuilder: (context, index) {
//                             final batch = batches[index];
//                             int qty = cartQuantities[index] ?? 0;
//                             DateTime expiry = batch.expiryDate;
//                             int expiryDays = expiry
//                                 .difference(DateTime.now())
//                                 .inDays;

//                             List<DateTime> dateOptions = List.generate(10, (i) {
//                               final d = DateTime.now().add(
//                                 Duration(days: i + 1),
//                               );
//                               return DateTime(d.year, d.month, d.day);
//                             });

//                             return Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               elevation: qty > 0 ? 6 : 2,
//                               margin: const EdgeInsets.symmetric(vertical: 10),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Average Price: ₹${batch.pricePerUnit.toStringAsFixed(2)}",
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Color(0xFF4CAF50),
//                                           ),
//                                         ),
//                                         buildStars(random.nextInt(5) + 1),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 12),
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.storefront,
//                                           size: 18,
//                                           color: Colors.grey,
//                                         ),
//                                         const SizedBox(width: 6),
//                                         Text(
//                                           batch.farmerName!,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.label,
//                                           size: 18,
//                                           color: Colors.blueGrey,
//                                         ),
//                                         const SizedBox(width: 6),
//                                         Text(
//                                           "Batch ID: ${batch.id}",
//                                           style: const TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.blueGrey,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.inventory,
//                                           size: 18,
//                                           color: Colors.grey,
//                                         ),
//                                         const SizedBox(width: 6),
//                                         Text(
//                                           "${batch.quantityKg} packs • ${batch.unit}",
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.event_busy,
//                                           size: 18,
//                                           color: Colors.redAccent,
//                                         ),
//                                         const SizedBox(width: 6),
//                                         Text(
//                                           "Expiry: ${expiry.day}/${expiry.month}/${expiry.year} (${expiryDays}d left)",
//                                           style: const TextStyle(
//                                             color: Colors.redAccent,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const Divider(height: 20, thickness: 1),

//                                     DropdownButton<DateTime>(
//                                       value: selectedDates[index],
//                                       hint: const Text(
//                                         "Select Expected Arrival Date",
//                                       ),
//                                       onChanged: (date) {
//                                         setState(() {
//                                           selectedDates[index] = DateTime(
//                                             date!.year,
//                                             date.month,
//                                             date.day,
//                                           );
//                                           int daysFromNow =
//                                               selectedDates[index]!
//                                                   .difference(DateTime.now())
//                                                   .inDays;

//                                           List<double> charges =
//                                               logisticsProviders
//                                                   .map(
//                                                     (p) => p.calculateCharge(
//                                                       daysFromNow,
//                                                       qty > 0 ? qty : 1,
//                                                     ),
//                                                   )
//                                                   .toList();

//                                           int minIndex = charges.indexOf(
//                                             charges.reduce(min),
//                                           );
//                                           selectedProviders[index] = minIndex;
//                                           selectedCharges[index] =
//                                               charges[minIndex];
//                                         });
//                                       },
//                                       items: dateOptions.map((d) {
//                                         return DropdownMenuItem(
//                                           value: d,
//                                           child: Text(
//                                             "${d.day}/${d.month}/${d.year}",
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ),

//                                     if (selectedDates.containsKey(index)) ...[
//                                       DropdownButton<int>(
//                                         value: selectedProviders[index],
//                                         hint: const Text(
//                                           "Select Logistic Provider",
//                                         ),
//                                         onChanged: (providerIndex) {
//                                           setState(() {
//                                             selectedProviders[index] =
//                                                 providerIndex!;
//                                             int daysFromNow =
//                                                 selectedDates[index]!
//                                                     .difference(DateTime.now())
//                                                     .inDays;
//                                             selectedCharges[index] =
//                                                 logisticsProviders[providerIndex]
//                                                     .calculateCharge(
//                                                       daysFromNow,
//                                                       qty > 0 ? qty : 1,
//                                                     );
//                                           });
//                                         },
//                                         items: List.generate(
//                                           logisticsProviders.length,
//                                           (i) {
//                                             int daysFromNow =
//                                                 selectedDates[index]!
//                                                     .difference(DateTime.now())
//                                                     .inDays;
//                                             double charge =
//                                                 logisticsProviders[i]
//                                                     .calculateCharge(
//                                                       daysFromNow,
//                                                       qty > 0 ? qty : 1,
//                                                     );
//                                             return DropdownMenuItem(
//                                               value: i,
//                                               child: Text(
//                                                 "${logisticsProviders[i].name} - ₹${charge.toStringAsFixed(2)}",
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ],

//                                     if (selectedCharges.containsKey(index))
//                                       Text(
//                                         "Selected Logistics Charge: ₹${selectedCharges[index]!.toStringAsFixed(2)}",
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: Color(0xFF4CAF50),
//                                         ),
//                                       ),

//                                     const Divider(height: 20, thickness: 1),

//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             IconButton(
//                                               onPressed: () {
//                                                 if (qty > 0) {
//                                                   updateCart(index, qty - 1);
//                                                 }
//                                               },
//                                               icon: const Icon(
//                                                 Icons.remove_circle,
//                                                 color: Colors.red,
//                                               ),
//                                             ),
//                                             Text(
//                                               "$qty",
//                                               style: const TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                             IconButton(
//                                               onPressed: () {
//                                                 if (qty < batch.quantityKg) {
//                                                   // Note updated from stock to batchQuantity
//                                                   updateCart(index, qty + 1);
//                                                 }
//                                               },
//                                               icon: const Icon(
//                                                 Icons.add_circle,
//                                                 color: Colors.green,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         OutlinedButton.icon(
//                                           style: OutlinedButton.styleFrom(
//                                             side: const BorderSide(
//                                               color: Color(0xFF4CAF50),
//                                             ),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                             ),
//                                           ),
//                                           onPressed: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (_) => ProductHistoryPage(
//                                                   product: product,
//                                                   batchid: batch
//                                                       .id, // Pass actual batchId
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                           icon: const Icon(
//                                             Icons.history,
//                                             color: Color(0xFF4CAF50),
//                                           ),
//                                           label: const Text(
//                                             "View History",
//                                             style: TextStyle(
//                                               color: Color(0xFF4CAF50),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Bottom Cart Bar
//           FutureBuilder<List<Batch>>(
//             future: futureBatches,
//             builder: (context, snapshot) {
//               List<Batch> batches = snapshot.data ?? [];
//               return Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border(top: BorderSide(color: Colors.grey.shade300)),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 4,
//                       offset: Offset(0, -2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Total",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Color.fromARGB(137, 22, 21, 21),
//                           ),
//                         ),
//                         Text(
//                           "Average Price: ₹${calculateTotal(batches).toStringAsFixed(2)}",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                     ElevatedButton.icon(
//                       onPressed: () {
//                         if (!gcart.containsKey(product.id) ||
//                             gcart[product.id] == null) {
//                           gcart[product.id] = <String, List<int>>{};
//                         }
//                         cartQuantities.forEach((batchIndex, qty) {
//                           if (batchIndex < batches.length) {
//                             double price = batches[batchIndex].pricePerUnit;
//                             int providerIndex =
//                                 selectedProviders[batchIndex] ?? 0;
//                             double charge = selectedCharges[batchIndex] ?? 0;
//                             gcart[product.id]!['batch$batchIndex'] = [
//                               price.toInt(),
//                               qty,
//                               providerIndex,
//                               charge.toInt(),
//                             ];
//                           }
//                         });

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               'Added ${cartQuantities.length} batches to cart!',
//                             ),
//                             duration: const Duration(seconds: 2),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.shopping_cart),
//                       label: const Text("Add to Cart"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF4CAF50),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 12,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:demo/models/batch_model.dart';
import 'package:flutter/material.dart';

import '../../global.dart';
import 'models/product_model.dart';
import 'package:demo/models/batch_model.dart';
import '../../services/api_service.dart';
import 'product_history.dart';

class LogisticProvider {
  final String name;
  final double baseValue;
  final double ratio;

  LogisticProvider({
    required this.name,
    required this.baseValue,
    required this.ratio,
  });

  double calculateCharge(int daysFromNow, int qty) {
    return (baseValue + (ratio * daysFromNow) + Random().nextDouble() * 10) *
        qty;
  }
}

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

  late Future<List<Batch>> futureBatches;

  Product? product;
  Map<int, int> cartQuantities = {};
  Map<int, int> selectedProviders = {};
  Map<int, DateTime> selectedDates = {};
  Map<int, double> selectedCharges = {};

  final List<LogisticProvider> logisticsProviders = [
    LogisticProvider(name: "DTDC", baseValue: 45, ratio: 8),
    LogisticProvider(name: "LoadShare Networks", baseValue: 50, ratio: 10),
    LogisticProvider(name: "Shiprocket", baseValue: 42, ratio: 9),
    LogisticProvider(name: "Mahindra Logistics", baseValue: 60, ratio: 7),
    LogisticProvider(name: "iThink Logistics", baseValue: 54, ratio: 8),
  ];

  @override
  void initState() {
    super.initState();
    product = widget.product;
    final String productId = product?.id ?? '';
    if (product != null && product!.id.isNotEmpty) {
      futureBatches = ApiService.getBatchesForProduct(productId);
    } else {
      futureBatches = Future.value([]);
    }
    print("ProductDetailsScreen: product.id = '${product?.id}'");
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

  double calculateTotal(List<Batch> batches) {
    double total = 0.0;
    cartQuantities.forEach((index, qty) {
      if (index < batches.length) {
        total += (batches[index].pricePerUnit) * qty;
      }
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
    // REMOVED: Don't reassign futureBatches here!
    // futureBatches = ApiService.getBatchesForProduct(productId);

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
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.category,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Available Batches",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FutureBuilder<List<Batch>>(
                    future: futureBatches,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text(
                          "Failed to fetch batches: ${snapshot.error}",
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text(
                          "No batches available for this product",
                        );
                      } else {
                        List<Batch> batches = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: batches.length,
                          itemBuilder: (context, index) {
                            final batch = batches[index];
                            int qty = cartQuantities[index] ?? 0;
                            DateTime expiry = batch.expiryDate;
                            int expiryDays = expiry
                                .difference(DateTime.now())
                                .inDays;

                            List<DateTime> dateOptions = List.generate(10, (i) {
                              final d = DateTime.now().add(
                                Duration(days: i + 1),
                              );
                              return DateTime(d.year, d.month, d.day);
                            });

                            return Card(
                              key: ValueKey('batch_${batch.id}_$index'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: qty > 0 ? 6 : 2,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Average Price: ₹${batch.pricePerUnit.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF4CAF50),
                                          ),
                                        ),
                                        buildStars(random.nextInt(5) + 1),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.storefront,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          batch.farmerName!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.label,
                                          size: 18,
                                          color: Colors.blueGrey,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          "Batch ID: ${batch.id}",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.inventory,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          "${batch.quantityKg} packs • ${batch.unit}",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.event_busy,
                                          size: 18,
                                          color: Colors.redAccent,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          "Expiry: ${expiry.day}/${expiry.month}/${expiry.year} (${expiryDays}d left)",
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(height: 20, thickness: 1),

                                    DropdownButton<DateTime>(
                                      value: selectedDates[index],
                                      hint: const Text(
                                        "Select Expected Arrival Date",
                                      ),
                                      onChanged: (date) {
                                        setState(() {
                                          selectedDates[index] = DateTime(
                                            date!.year,
                                            date.month,
                                            date.day,
                                          );
                                          int daysFromNow =
                                              selectedDates[index]!
                                                  .difference(DateTime.now())
                                                  .inDays;

                                          List<double> charges =
                                              logisticsProviders
                                                  .map(
                                                    (p) => p.calculateCharge(
                                                      daysFromNow,
                                                      qty > 0 ? qty : 1,
                                                    ),
                                                  )
                                                  .toList();

                                          int minIndex = charges.indexOf(
                                            charges.reduce(min),
                                          );
                                          selectedProviders[index] = minIndex;
                                          selectedCharges[index] =
                                              charges[minIndex];
                                        });
                                      },
                                      items: dateOptions.map((d) {
                                        return DropdownMenuItem(
                                          value: d,
                                          child: Text(
                                            "${d.day}/${d.month}/${d.year}",
                                          ),
                                        );
                                      }).toList(),
                                    ),

                                    if (selectedDates.containsKey(index)) ...[
                                      DropdownButton<int>(
                                        value: selectedProviders[index],
                                        hint: const Text(
                                          "Select Logistic Provider",
                                        ),
                                        onChanged: (providerIndex) {
                                          setState(() {
                                            selectedProviders[index] =
                                                providerIndex!;
                                            int daysFromNow =
                                                selectedDates[index]!
                                                    .difference(DateTime.now())
                                                    .inDays;
                                            selectedCharges[index] =
                                                logisticsProviders[providerIndex]
                                                    .calculateCharge(
                                                      daysFromNow,
                                                      qty > 0 ? qty : 1,
                                                    );
                                          });
                                        },
                                        items: List.generate(
                                          logisticsProviders.length,
                                          (i) {
                                            int daysFromNow =
                                                selectedDates[index]!
                                                    .difference(DateTime.now())
                                                    .inDays;
                                            double charge =
                                                logisticsProviders[i]
                                                    .calculateCharge(
                                                      daysFromNow,
                                                      qty > 0 ? qty : 1,
                                                    );
                                            return DropdownMenuItem(
                                              value: i,
                                              child: Text(
                                                "${logisticsProviders[i].name} - ₹${charge.toStringAsFixed(2)}",
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],

                                    if (selectedCharges.containsKey(index))
                                      Text(
                                        "Selected Logistics Charge: ₹${selectedCharges[index]!.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF4CAF50),
                                        ),
                                      ),

                                    const Divider(height: 20, thickness: 1),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
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
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                if (qty < batch.quantityKg) {
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
                                        OutlinedButton.icon(
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                              color: Color(0xFF4CAF50),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ProductHistoryPage(
                                                      product: product,
                                                      batchid: batch.id,
                                                    ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.history,
                                            color: Color(0xFF4CAF50),
                                          ),
                                          label: const Text(
                                            "View History",
                                            style: TextStyle(
                                              color: Color(0xFF4CAF50),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom Cart Bar
          FutureBuilder<List<Batch>>(
            future: futureBatches,
            builder: (context, snapshot) {
              List<Batch> batches = snapshot.data ?? [];
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(137, 22, 21, 21),
                          ),
                        ),
                        Text(
                          "Average Price: ₹${calculateTotal(batches).toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (!gcart.containsKey(product.id) ||
                            gcart[product.id] == null) {
                          gcart[product.id] = <String, List<int>>{};
                        }
                        cartQuantities.forEach((batchIndex, qty) {
                          if (batchIndex < batches.length) {
                            double price = batches[batchIndex].pricePerUnit;
                            int providerIndex =
                                selectedProviders[batchIndex] ?? 0;
                            double charge = selectedCharges[batchIndex] ?? 0;
                            gcart[product.id]!['batch$batchIndex'] = [
                              price.toInt(),
                              qty,
                              providerIndex,
                              charge.toInt(),
                            ];
                          }
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Added ${cartQuantities.length} batches to cart!',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
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
              );
            },
          ),
        ],
      ),
    );
  }
}
