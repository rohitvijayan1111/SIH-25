// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'models/product_model.dart';

// // class ProductHistoryPage extends StatefulWidget {
// //   final Product product;
// //   final String batchid;

// //   const ProductHistoryPage({
// //     Key? key,
// //     required this.product,
// //     required this.batchid,
// //   }) : super(key: key);

// //   @override
// //   State<ProductHistoryPage> createState() => _ProductHistoryPageState();
// // }

// // class _ProductHistoryPageState extends State<ProductHistoryPage> {
// //   final Random random = Random();
// //   late List<Map<String, dynamic>> levels;
// //   final Map<String, bool> expanded = {};

// //   final List<String> locations = [
// //     "Punjab",
// //     "Delhi",
// //     "Mumbai",
// //     "Kolkata",
// //     "Chennai",
// //     "Bangalore",
// //   ];

// //   final List<String> processingCenters = [
// //     "AgriCenter",
// //     "FoodProcessing Hub",
// //     "Organic Warehouse",
// //     "Cold Storage Unit",
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     generateRandomLevels();
// //   }

// //   void generateRandomLevels() {
// //     DateTime today = DateTime.now();
// //     int levelCount = 2 + random.nextInt(4); // 2 or 3 levels
// //     levels = [];

// //     String originLocation = locations[random.nextInt(locations.length)];

// //     for (int i = 0; i < levelCount; i++) {
// //       String location;
// //       if (i == 0) {
// //         location = originLocation;
// //       } else {
// //         // pick random location not same as previous
// //         location = locations[random.nextInt(locations.length)];
// //         if (location == levels[i - 1]["location"]) {
// //           location =
// //               locations[(random.nextInt(locations.length)) % locations.length];
// //         }
// //       }

// //       int kmTravelled = 50 + random.nextInt(400); // 50–450 km

// //       levels.add({
// //         "title": i == 0
// //             ? "Origin / Farmer"
// //             : i == levelCount - 1
// //             ? "Current State"
// //             : "Processing Level $i",
// //         "subtitle": i == 0
// //             ? "Farm: ${widget.product.farmerName}, $location"
// //             : "${processingCenters[random.nextInt(processingCenters.length)]}, $location",
// //         "date": today
// //             .add(Duration(days: i * (2 + random.nextInt(3))))
// //             .toString()
// //             .split(" ")[0],
// //         "icon": i == 0
// //             ? Icons.agriculture
// //             : i == levelCount - 1
// //             ? Icons.store
// //             : Icons.factory,
// //         "chipColor": i == 0
// //             ? Colors.green
// //             : i == levelCount - 1
// //             ? Colors.purple
// //             : Colors.orange,
// //         "chipLabel": i == 0
// //             ? "Harvested"
// //             : i == levelCount - 1
// //             ? "Available"
// //             : "Processed",
// //         "marginLeft": 16.0 + i * 20,
// //         "details": [
// //           if (i == 0) ...[
// //             "Farmer: ${widget.product.farmerName}",
// //             "Soil Type: Alluvial",
// //             "Harvested On: ${today.add(Duration(days: i * 2)).toString().split(" ")[0]}",
// //           ] else ...[
// //             "Transport Mode: ${["Truck", "Refrigerated Truck", "Van"][random.nextInt(3)]}",
// //             "Distance Travelled: $kmTravelled km",
// //             "Handled By: ${["ABC Logistics", "XYZ Transport", "Global Freight"][random.nextInt(3)]}",
// //           ],
// //         ],
// //       });
// //       expanded[levels[i]["title"]] = false;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Product History"),
// //         backgroundColor: Colors.green.shade700,
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(12),
// //         child: Column(
// //           children: [
// //             // Product Info Card
// //             Card(
// //               elevation: 4,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(16),
// //                 child: Row(
// //                   children: [
// //                     ClipRRect(
// //                       borderRadius: BorderRadius.circular(12),
// //                       child: Image.network(
// //                         widget.product.imageUrl,
// //                         width: 80,
// //                         height: 80,
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),
// //                     const SizedBox(width: 16),
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             widget.product.name,
// //                             style: const TextStyle(
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 18,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 6),
// //                           Text(
// //                             "Batch ID: ${widget.batchid}",
// //                             style: const TextStyle(color: Colors.grey),
// //                           ),
// //                           Text(
// //                             "Category: ${widget.product.category}",
// //                             style: const TextStyle(color: Colors.grey),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),

// //             // Timeline
// //             ...levels.map(
// //               (lvl) => Container(
// //                 margin: EdgeInsets.only(left: lvl["marginLeft"], bottom: 16),
// //                 child: buildStepCard(
// //                   title: lvl["title"],
// //                   subtitle: lvl["subtitle"],
// //                   date: lvl["date"],
// //                   icon: lvl["icon"],
// //                   chipColor: lvl["chipColor"],
// //                   chipLabel: lvl["chipLabel"],
// //                   keyName: lvl["title"],
// //                   details: List<String>.from(lvl["details"]),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget buildStepCard({
// //     required String title,
// //     required String subtitle,
// //     required String date,
// //     required IconData icon,
// //     required Color chipColor,
// //     required String chipLabel,
// //     required String keyName,
// //     required List<String> details,
// //   }) {
// //     return Card(
// //       elevation: 3,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
// //       child: Padding(
// //         padding: const EdgeInsets.all(14),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               children: [
// //                 CircleAvatar(
// //                   radius: 24,
// //                   backgroundColor: chipColor.withOpacity(0.2),
// //                   child: Icon(icon, color: chipColor, size: 26),
// //                 ),
// //                 const SizedBox(width: 12),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         title,
// //                         style: const TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 16,
// //                         ),
// //                       ),
// //                       Text(
// //                         subtitle,
// //                         style: TextStyle(
// //                           fontSize: 13,
// //                           color: Colors.grey.shade600,
// //                         ),
// //                       ),
// //                       Text(
// //                         date,
// //                         style: TextStyle(
// //                           fontSize: 12,
// //                           color: Colors.grey.shade500,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Chip(
// //                   label: Text(
// //                     chipLabel,
// //                     style: const TextStyle(
// //                       fontSize: 12,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                   backgroundColor: chipColor.withOpacity(0.15),
// //                   labelStyle: TextStyle(color: chipColor),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 8),
// //             GestureDetector(
// //               onTap: () {
// //                 setState(() {
// //                   expanded[keyName] = !(expanded[keyName] ?? false);
// //                 });
// //               },
// //               child: Text(
// //                 expanded[keyName] == true ? "Hide Details ▲" : "View Details ▼",
// //                 style: TextStyle(
// //                   color: chipColor,
// //                   fontWeight: FontWeight.w600,
// //                   fontSize: 13,
// //                 ),
// //               ),
// //             ),
// //             if (expanded[keyName] == true) ...[
// //               const SizedBox(height: 8),
// //               Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: details
// //                     .map(
// //                       (d) => Padding(
// //                         padding: const EdgeInsets.symmetric(vertical: 3),
// //                         child: Row(
// //                           children: [
// //                             const Icon(
// //                               Icons.check_circle,
// //                               color: Colors.green,
// //                               size: 16,
// //                             ),
// //                             const SizedBox(width: 6),
// //                             Expanded(
// //                               child: Text(
// //                                 d,
// //                                 style: const TextStyle(fontSize: 13),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     )
// //                     .toList(),
// //               ),
// //             ],
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'models/product_model.dart';

// class ProductHistoryPage extends StatefulWidget {
//   final Product product;
//   final String batchid;

//   const ProductHistoryPage({
//     Key? key,
//     required this.product,
//     required this.batchid,
//   }) : super(key: key);

//   @override
//   State<ProductHistoryPage> createState() => _ProductHistoryPageState();
// }

// class _ProductHistoryPageState extends State<ProductHistoryPage> {
//   final Random random = Random();
//   late List<Map<String, dynamic>> blocks;

//   final List<String> locations = [
//     "Punjab",
//     "Delhi",
//     "Mumbai",
//     "Kolkata",
//     "Chennai",
//     "Bangalore",
//   ];

//   final List<String> reasons = [
//     "Seller Margin",
//     "Processing Fee",
//     "Logistics",
//     "Storage Cost",
//     "Packaging",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     generateBlocks();
//   }

//   void generateBlocks() {
//     int blockCount = 3 + random.nextInt(3); // 3–5 blocks
//     double basePrice = double.tryParse(widget.product.price) ?? 0.0;
//     double cumulative = 0.0;
//     DateTime today = DateTime.now();

//     blocks = List.generate(blockCount, (i) {
//       String reason = reasons[random.nextInt(reasons.length)];
//       double addedAmount = (basePrice * (0.05 + random.nextDouble() * 0.15))
//           .roundToDouble(); // 5–20% of base price
//       cumulative += addedAmount;

//       String location = reason == "Logistics"
//           ? locations[random.nextInt(locations.length)]
//           : "";

//       return {
//         "blockId": "BLK-${1000 + i}",
//         "addedAmount": addedAmount,
//         "totalAmount": cumulative,
//         "reason": reason,
//         "location": location,
//         "date": today
//             .add(Duration(days: i * (1 + random.nextInt(3))))
//             .toString()
//             .split(" ")[0],
//       };
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Product History"),
//         backgroundColor: Colors.green.shade700,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             // Product Info
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.network(
//                         widget.product.imageUrl,
//                         width: 80,
//                         height: 80,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.product.name,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             "Batch ID: ${widget.batchid}",
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                           Text(
//                             "Category: ${widget.product.category}",
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Blockchain-style Blocks
//             ...blocks.map((blk) => buildBlockCard(blk)).toList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBlockCard(Map<String, dynamic> blk) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Block ID and Date
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   blk["blockId"],
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   blk["date"],
//                   style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
//                 ),
//               ],
//             ),
//             const Divider(height: 16, thickness: 1),
//             // Transaction Details
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Reason",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 13,
//                       ),
//                     ),
//                     Text(
//                       blk["reason"],
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Added",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 13,
//                       ),
//                     ),
//                     Text(
//                       "₹${blk["addedAmount"].toStringAsFixed(2)}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Total",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 13,
//                       ),
//                     ),
//                     Text(
//                       "₹${blk["totalAmount"].toStringAsFixed(2)}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             if ((blk["location"] as String).isNotEmpty) ...[
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   const Icon(
//                     Icons.location_on,
//                     color: Colors.blueAccent,
//                     size: 16,
//                   ),
//                   const SizedBox(width: 6),
//                   Text(blk["location"], style: const TextStyle(fontSize: 13)),
//                 ],
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'models/product_model.dart';

class ProductHistoryPage extends StatefulWidget {
  final Product product;
  final String batchid;

  const ProductHistoryPage({
    Key? key,
    required this.product,
    required this.batchid,
  }) : super(key: key);

  @override
  State<ProductHistoryPage> createState() => _ProductHistoryPageState();
}

class _ProductHistoryPageState extends State<ProductHistoryPage> {
  final Random random = Random();
  late List<Map<String, dynamic>> blocks;

  final List<String> locations = [
    "Punjab",
    "Delhi",
    "Mumbai",
    "Kolkata",
    "Chennai",
    "Bangalore",
  ];

  final List<String> reasons = [
    "Seller Margin",
    "Processing Fee",
    "Logistics",
    "Storage Cost",
    "Packaging",
  ];

  @override
  void initState() {
    super.initState();
    generateBlocks();
  }

  void generateBlocks() {
    double finalPrice = double.tryParse(widget.product.price) ?? 0.0;
    double basePrice =
        finalPrice * (0.5 + random.nextDouble() * 0.2); // 50-70% of final
    int blockCount = 3 + random.nextInt(3); // 3–5 blocks
    DateTime today = DateTime.now();

    // Calculate incremental amounts to reach final price
    List<double> increments = List.generate(blockCount, (i) => 0);
    double remaining = finalPrice - basePrice;
    for (int i = 0; i < blockCount - 1; i++) {
      increments[i] = (remaining * (0.3 + random.nextDouble() * 0.4))
          .roundToDouble(); // 30–70% of remaining
      remaining -= increments[i];
    }
    increments[blockCount - 1] = remaining; // last block adjustment

    double cumulative = basePrice;
    blocks = List.generate(blockCount, (i) {
      double added = increments[i];
      cumulative += added;

      String reason = i == 0
          ? "Farmer Price"
          : reasons[random.nextInt(reasons.length)];
      String location = reason == "Logistics"
          ? locations[random.nextInt(locations.length)]
          : "";

      return {
        "blockId": "BLK-${1000 + i}",
        "addedAmount": added,
        "totalAmount": cumulative,
        "reason": reason,
        "location": location,
        "date": today
            .add(Duration(days: i * (1 + random.nextInt(3))))
            .toString()
            .split(" ")[0],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product History"),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Product Info
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.product.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Batch ID: ${widget.batchid}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Category: ${widget.product.category}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Blockchain-style blocks
            ...blocks.map((blk) => buildBlockCard(blk)).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildBlockCard(Map<String, dynamic> blk) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Block ID and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  blk["blockId"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  blk["date"],
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
            const Divider(height: 16, thickness: 1),
            // Transaction Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Reason",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      blk["reason"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Added",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "₹${blk["addedAmount"].toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "₹${blk["totalAmount"].toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if ((blk["location"] as String).isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.blueAccent,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(blk["location"], style: const TextStyle(fontSize: 13)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
