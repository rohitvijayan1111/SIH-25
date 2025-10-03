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

class _ProductHistoryPageState extends State<ProductHistoryPage>
    with TickerProviderStateMixin {
  final Random random = Random();
  late List<Map<String, dynamic>> blocks;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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

  // Color scheme for different reasons
  final Map<String, Color> reasonColors = {
    "Farmer Price": Colors.green,
    "Seller Margin": Colors.green,
    "Processing Fee": Colors.green,
    "Logistics": Colors.green,
    "Storage Cost": Colors.green,
    "Packaging": Colors.green,
  };

  @override
  void initState() {
    super.initState();
    generateBlocks();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Product Trace",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.green[600],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            // Header section with product info
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green[600]!, Colors.green[400]!],
                  ),
                ),
                child: Column(
                  children: [
                    _buildProductInfoCard(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Title for trace history
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.timeline, color: Colors.green[600], size: 24),
                    const SizedBox(width: 8),
                    const Text(
                      "Trace History",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Blockchain-style blocks
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    child: _buildEnhancedBlockCard(blocks[index], index),
                  );
                },
                childCount: blocks.length,
              ),
            ),
            // Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfoCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Product image with hero animation
            Hero(
              tag: widget.product.imageUrl,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[400],
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoChip(
                    icon: Icons.qr_code,
                    label: "Batch ID",
                    value: widget.batchid,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 6),
                  _buildInfoChip(
                    icon: Icons.category,
                    label: "Category",
                    value: widget.product.category,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 6),
                  _buildInfoChip(
                    icon: Icons.currency_rupee,
                    label: "Final Price",
                    value: "₹${widget.product.price}",
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedBlockCard(Map<String, dynamic> blk, int index) {
    final Color reasonColor = reasonColors[blk["reason"]] ?? Colors.grey;
    final bool isFirst = index == 0;
    
    return Container(
      margin: EdgeInsets.fromLTRB(
        16, 
        isFirst ? 8 : 4, 
        16, 
        index == blocks.length - 1 ? 16 : 4
      ),
      child: Stack(
        children: [
          // Connecting line
          if (index < blocks.length - 1)
            Positioned(
              left: 28,
              bottom: -4,
              child: Container(
                width: 2,
                height: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      reasonColor.withOpacity(0.6),
                      reasonColors[blocks[index + 1]["reason"]]?.withOpacity(0.6) ?? Colors.grey.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
            ),
          // Main card
          Card(
            elevation: 8,
            shadowColor: reasonColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    reasonColor.withOpacity(0.02),
                  ],
                ),
                border: Border(
                  left: BorderSide(
                    color: reasonColor,
                    width: 4,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: reasonColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: reasonColor.withOpacity(0.4),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              blk["blockId"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 12,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                blk["date"],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Main content
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: reasonColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          // Reason section
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: reasonColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getReasonIcon(blk["reason"]),
                                      size: 16,
                                      color: reasonColor,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      blk["reason"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: reasonColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Price information
                          Row(
                            children: [
                              Expanded(
                                child: _buildPriceInfo(
                                  "Added",
                                  "₹${blk["addedAmount"].toStringAsFixed(2)}",
                                  Colors.orange[600]!,
                                  Icons.add_circle_outline,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildPriceInfo(
                                  "Total",
                                  "₹${blk["totalAmount"].toStringAsFixed(2)}",
                                  Colors.green[600]!,
                                  Icons.account_balance_wallet,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Location info if available
                    if ((blk["location"] as String).isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blue[200]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.blue[600],
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              blk["location"],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getReasonIcon(String reason) {
    switch (reason) {
      case "Farmer Price":
        return Icons.agriculture;
      case "Seller Margin":
        return Icons.store;
      case "Processing Fee":
        return Icons.precision_manufacturing;
      case "Logistics":
        return Icons.local_shipping;
      case "Storage Cost":
        return Icons.warehouse;
      case "Packaging":
        return Icons.inventory;
      default:
        return Icons.info;
    }
  }
}