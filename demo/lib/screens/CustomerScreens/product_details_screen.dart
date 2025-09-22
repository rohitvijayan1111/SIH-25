// import 'dart:math';
// import 'package:flutter/material.dart';
// import '../../global.dart';
// import 'models/product_model.dart';
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
//   late List<Map<String, dynamic>> batches;
//   Product? product;
//   Map<int, int> cartQuantities = {}; // batchIndex -> quantity
//   Map<int, int> selectedProviders = {}; // batchIndex -> providerIndex
//   Map<int, DateTime> selectedDates = {}; // batchIndex -> date
//   Map<int, double> selectedCharges = {}; // batchIndex -> charge

//   final List<LogisticProvider> logisticsProviders = List.generate(5, (i) {
//     double base = (40 + Random().nextInt(30)) as double; // base 40–70
//     double ratio = (5 + Random().nextInt(10)) as double; // ratio 5–15
//     return LogisticProvider(
//       name: "Provider ${i + 1}",
//       baseValue: base.toDouble(),
//       ratio: ratio.toDouble(),
//     );
//   });

//   @override
//   void initState() {
//     super.initState();
//     double basePrice = double.tryParse(widget.product.price) ?? 0.0;
//     product = widget.product;
//     DateTime today = DateTime.now();

//     // Generate dummy batches with dynamic arrival & expiry dates
//     batches = List.generate(3, (i) {
//       // Expiry: 200–700 days from today
//       DateTime expiry = today.add(Duration(days: 10 + random.nextInt(40)));

//       // Arrival: 3–30 days from today (but < expiry)
//       DateTime arrival = today.add(Duration(days: 3 + random.nextInt(20)));

//       if (arrival.isAfter(expiry)) {
//         arrival = expiry.subtract(const Duration(days: 10));
//       }

//       return {
//         "seller": ["Farmer Nanda", "AgroMart", "Green Valley"][i],
//         "price": basePrice * (1 + (i - 1) * 0.2), // vary price
//         "stock": [100, 190, 50][i],
//         "unit": ["2kg per pack", "1kg per pack", "500g per pack"][i],
//         "expiry": expiry,
//         "arrival": arrival,
//         "stars": random.nextInt(5) + 1,
//       };
//     });
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

//   double calculateTotal() {
//     double total = 0.0;
//     cartQuantities.forEach((index, qty) {
//       total += batches[index]["price"] * qty;
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
//                   // Product Image
//                   AspectRatio(
//                     aspectRatio: 16 / 9,
//                     child: Image.network(product.imageUrl, fit: BoxFit.cover),
//                   ),
//                   const SizedBox(height: 20),
//                   // Product Details Section
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

//                   // Available Batches
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
//                       int qty = cartQuantities[index] ?? 0;

//                       DateTime expiry = batch["expiry"];
//                       DateTime arrival = batch["arrival"];
//                       int expiryDays = expiry.difference(DateTime.now()).inDays;
//                       int arrivalDays = arrival
//                           .difference(DateTime.now())
//                           .inDays;

//                       // Date options: tomorrow → 10 days
//                       List<DateTime> dateOptions = List.generate(
//                         10,
//                         (i) => DateTime.now().add(Duration(days: i + 1)),
//                       );

//                       return Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         elevation: qty > 0 ? 6 : 2,
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Row: Price + Stars
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "₹${batch["price"].toStringAsFixed(2)}",
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xFF4CAF50),
//                                     ),
//                                   ),
//                                   buildStars(batch["stars"]),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),

//                               // Seller Info
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.storefront,
//                                     size: 18,
//                                     color: Colors.grey,
//                                   ),
//                                   const SizedBox(width: 6),
//                                   Text(
//                                     batch["seller"],
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 6),

//                               // Stock + Unit
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.inventory,
//                                     size: 18,
//                                     color: Colors.grey,
//                                   ),
//                                   const SizedBox(width: 6),
//                                   Text(
//                                     "${batch["stock"]} packs • ${batch["unit"]}",
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 6),

//                               // Expiry Date
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.event_busy,
//                                     size: 18,
//                                     color: Colors.redAccent,
//                                   ),
//                                   const SizedBox(width: 6),
//                                   Text(
//                                     "Expiry: ${expiry.day}/${expiry.month}/${expiry.year} "
//                                     "(${expiryDays}d left)",
//                                     style: const TextStyle(
//                                       color: Colors.redAccent,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 6),

//                               // Arrival Date
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.local_shipping,
//                                     size: 18,
//                                     color: Colors.blue,
//                                   ),
//                                   const SizedBox(width: 6),
//                                   Text(
//                                     "Arrival: ${arrival.day}/${arrival.month}/${arrival.year} "
//                                     "(${arrivalDays}d left)",
//                                     style: const TextStyle(color: Colors.blue),
//                                   ),
//                                 ],
//                               ),

//                               const Divider(height: 20, thickness: 1),

//                               // Logistics Date Dropdown
//                               DropdownButton<DateTime>(
//                                 value: selectedDates[index],
//                                 hint: const Text(
//                                   "Select Expected Arrival Date",
//                                 ),
//                                 onChanged: (date) {
//                                   setState(() {
//                                     selectedDates[index] = date!;
//                                     int daysFromNow = date
//                                         .difference(DateTime.now())
//                                         .inDays;

//                                     // calculate charges for all providers
//                                     List<double> charges = logisticsProviders
//                                         .map(
//                                           (p) => p.calculateCharge(
//                                             daysFromNow,
//                                             qty > 0 ? qty : 1,
//                                           ),
//                                         )
//                                         .toList();

//                                     // pick cheapest provider as default
//                                     int minIndex = charges.indexOf(
//                                       charges.reduce(min),
//                                     );
//                                     selectedProviders[index] = minIndex;
//                                     selectedCharges[index] = charges[minIndex];
//                                   });
//                                 },
//                                 items: dateOptions.map((d) {
//                                   return DropdownMenuItem(
//                                     value: d,
//                                     child: Text(
//                                       "${d.day}/${d.month}/${d.year}",
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),

//                               // Provider Dropdown (only show if date selected)
//                               if (selectedDates.containsKey(index)) ...[
//                                 DropdownButton<int>(
//                                   value: selectedProviders[index],
//                                   hint: const Text("Select Logistic Provider"),
//                                   onChanged: (providerIndex) {
//                                     setState(() {
//                                       selectedProviders[index] = providerIndex!;
//                                       int daysFromNow = selectedDates[index]!
//                                           .difference(DateTime.now())
//                                           .inDays;
//                                       selectedCharges[index] =
//                                           logisticsProviders[providerIndex]
//                                               .calculateCharge(
//                                                 daysFromNow,
//                                                 qty > 0 ? qty : 1,
//                                               );
//                                     });
//                                   },
//                                   items: List.generate(
//                                     logisticsProviders.length,
//                                     (i) {
//                                       int daysFromNow = selectedDates[index]!
//                                           .difference(DateTime.now())
//                                           .inDays;
//                                       double charge = logisticsProviders[i]
//                                           .calculateCharge(
//                                             daysFromNow,
//                                             qty > 0 ? qty : 1,
//                                           );
//                                       return DropdownMenuItem(
//                                         value: i,
//                                         child: Text(
//                                           "${logisticsProviders[i].name} - ₹${charge.toStringAsFixed(2)}",
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],

//                               // Show current selected charge
//                               if (selectedCharges.containsKey(index))
//                                 Text(
//                                   "Selected Logistics Charge: ₹${selectedCharges[index]!.toStringAsFixed(2)}",
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF4CAF50),
//                                   ),
//                                 ),

//                               const Divider(height: 20, thickness: 1),

//                               // Quantity Selector + History Button
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   // Quantity Selector
//                                   Row(
//                                     children: [
//                                       IconButton(
//                                         onPressed: () {
//                                           if (qty > 0)
//                                             updateCart(index, qty - 1);
//                                         },
//                                         icon: const Icon(
//                                           Icons.remove_circle,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                       Text(
//                                         "$qty",
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           if (qty < batch["stock"])
//                                             updateCart(index, qty + 1);
//                                         },
//                                         icon: const Icon(
//                                           Icons.add_circle,
//                                           color: Colors.green,
//                                         ),
//                                       ),
//                                     ],
//                                   ),

//                                   // Blockchain History Button
//                                   OutlinedButton.icon(
//                                     style: OutlinedButton.styleFrom(
//                                       side: const BorderSide(
//                                         color: Color(0xFF4CAF50),
//                                       ),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) => ProductHistoryPage(
//                                             product: product,
//                                             batchid: "batch#1673abhgi@bh",
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     icon: const Icon(
//                                       Icons.history,
//                                       color: Color(0xFF4CAF50),
//                                     ),
//                                     label: const Text(
//                                       "View History",
//                                       style: TextStyle(
//                                         color: Color(0xFF4CAF50),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 20),

//                   // Pickup Location
//                   const Text(
//                     "Pickup Location",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "Ludhiana Central, Punjab\nGPS: 30.9005, 75.8573",
//                     style: TextStyle(fontSize: 14, color: Colors.black87),
//                   ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ),

//           // Bottom Cart Bar
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border(top: BorderSide(color: Colors.grey.shade300)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 4,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Total Price
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Total",
//                       style: TextStyle(fontSize: 14, color: Colors.black54),
//                     ),
//                     Text(
//                       "₹${calculateTotal().toStringAsFixed(2)}",
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: cartQuantities.isNotEmpty
//                       ? () {
//                           if (!gcart.containsKey(product.id)) {
//                             gcart[product.id] = {};
//                           }

//                           cartQuantities.forEach((batchIndex, qty) {
//                             double price = batches[batchIndex]["price"];
//                             int providerIndex =
//                                 selectedProviders[batchIndex] ?? 0;
//                             double charge = selectedCharges[batchIndex] ?? 0;

//                             gcart[product.id]!["batch_$batchIndex"] = [
//                               price.toInt(),
//                               qty,
//                               providerIndex,
//                               charge.toInt(),
//                             ];
//                           });

//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 "Added ${cartQuantities.length} batch(es) to cart!",
//                               ),
//                               duration: const Duration(seconds: 2),
//                             ),
//                           );

//                           print(gcart);
//                         }
//                       : null,
//                   icon: const Icon(Icons.shopping_cart),
//                   label: const Text("Add to Cart"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF4CAF50),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import '../../global.dart';
import 'models/product_model.dart';
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
    // service charge = baseValue + ratio * days + random factor
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
  late List<Map<String, dynamic>> batches;
  Product? product;
  Map<int, int> cartQuantities = {}; // batchIndex -> quantity
  Map<int, int> selectedProviders = {}; // batchIndex -> providerIndex
  Map<int, DateTime> selectedDates = {}; // batchIndex -> date
  Map<int, double> selectedCharges = {}; // batchIndex -> charge

  final List<LogisticProvider> logisticsProviders = List.generate(5, (i) {
    double base = (40 + Random().nextInt(30)).toDouble(); // base 40–70
    double ratio = (5 + Random().nextInt(10)).toDouble(); // ratio 5–15
    return LogisticProvider(
      name: "Provider ${i + 1}",
      baseValue: base,
      ratio: ratio,
    );
  });

  @override
  void initState() {
    super.initState();
    double basePrice = double.tryParse(widget.product.price) ?? 0.0;
    product = widget.product;
    DateTime today = DateTime.now();

    // Generate dummy batches
    batches = List.generate(3, (i) {
      DateTime expiry = today.add(Duration(days: 10 + random.nextInt(40)));
      DateTime arrival = today.add(Duration(days: 3 + random.nextInt(20)));

      if (arrival.isAfter(expiry)) {
        arrival = expiry.subtract(const Duration(days: 10));
      }

      return {
        "seller": ["Farmer Nanda", "AgroMart", "Green Valley"][i],
        "price": basePrice * (1 + (i - 1) * 0.2),
        "stock": [100, 190, 50][i],
        "unit": ["2kg per pack", "1kg per pack", "500g per pack"][i],
        "expiry": expiry,
        "arrival": arrival,
        "stars": random.nextInt(5) + 1,
      };
    });
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
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
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

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: batches.length,
                    itemBuilder: (context, index) {
                      final batch = batches[index];
                      int qty = cartQuantities[index] ?? 0;

                      DateTime expiry = batch["expiry"];
                      DateTime arrival = batch["arrival"];
                      int expiryDays = expiry.difference(DateTime.now()).inDays;
                      int arrivalDays = arrival
                          .difference(DateTime.now())
                          .inDays;

                      List<DateTime> dateOptions = List.generate(10, (i) {
                        final d = DateTime.now().add(Duration(days: i + 1));
                        return DateTime(d.year, d.month, d.day); // normalize
                      });

                      return Card(
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
                                    "₹${batch["price"].toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4CAF50),
                                    ),
                                  ),
                                  buildStars(batch["stars"]),
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
                                    batch["seller"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
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
                                    "${batch["stock"]} packs • ${batch["unit"]}",
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
                                    "Expiry: ${expiry.day}/${expiry.month}/${expiry.year} "
                                    "(${expiryDays}d left)",
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       Icons.local_shipping,
                              //       size: 18,
                              //       color: Colors.blue,
                              //     ),
                              //     const SizedBox(width: 6),
                              //     Text(
                              //       "Arrival: ${arrival.day}/${arrival.month}/${arrival.year} "
                              //       "(${arrivalDays}d left)",
                              //       style: const TextStyle(color: Colors.blue),
                              //     ),
                              //   ],
                              // ),
                              const Divider(height: 20, thickness: 1),

                              // Logistics Date Dropdown
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
                                    int daysFromNow = selectedDates[index]!
                                        .difference(DateTime.now())
                                        .inDays;

                                    List<double> charges = logisticsProviders
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
                                    selectedCharges[index] = charges[minIndex];
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
                                  hint: const Text("Select Logistic Provider"),
                                  onChanged: (providerIndex) {
                                    setState(() {
                                      selectedProviders[index] = providerIndex!;
                                      int daysFromNow = selectedDates[index]!
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
                                      int daysFromNow = selectedDates[index]!
                                          .difference(DateTime.now())
                                          .inDays;
                                      double charge = logisticsProviders[i]
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
                                          if (qty > 0)
                                            updateCart(index, qty - 1);
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
                                  OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Color(0xFF4CAF50),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ProductHistoryPage(
                                            product: product,
                                            batchid: "batch#1673abhgi@bh",
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
                  ),
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
                ElevatedButton.icon(
                  onPressed: cartQuantities.isNotEmpty
                      ? () {
                          gcart ??= {};
                          gcart![product.id] ??= {};

                          cartQuantities.forEach((batchIndex, qty) {
                            double price = batches[batchIndex]["price"];
                            int providerIndex =
                                selectedProviders[batchIndex] ?? 0;
                            double charge = selectedCharges[batchIndex] ?? 0;

                            gcart![product.id]!["batch_$batchIndex"] = [
                              price.toInt(),
                              qty,
                              providerIndex,
                              charge.toInt(),
                            ];
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Added ${cartQuantities.length} batch(es) to cart!",
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          print(gcart);
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
