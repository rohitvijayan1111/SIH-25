import 'dart:math';
import 'package:flutter/material.dart';

// Dummy Product and ProductHistoryPage (for demonstration)
class Product {
  final String name;
  final String imageUrl;
  final String category;
  final String price;

  Product({
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.price,
  });
}

class ProductHistoryPPage extends StatefulWidget {
  final Product? product;
  final String? batchid;

  const ProductHistoryPPage({Key? key, this.product, this.batchid})
    : super(key: key);

  @override
  State<ProductHistoryPPage> createState() => _ProductHistoryPageState();
}

class _ProductHistoryPageState extends State<ProductHistoryPPage> {
  final Random random = Random();
  late List<Map<String, dynamic>> blocks;
  late Product product;
  late String batchid;

  final List<String> locations = [
    "Punjab",
    "Delhi",
    "Mumbai",
    "Kolkata",
    "Chennai",
    "Bangalore",
    "Hyderabad",
    "Pune",
  ];

  final List<String> reasons = [
    "Seller Margin",
    "Processing Fee",
    "Logistics",
    "Storage Cost",
    "Packaging",
  ];

  final List<String> sources = [
    "Farmer's Cooperative A",
    "Green Valley Farm",
    "Fresh Harvest Co.",
    "City Distributors Ltd.",
    "Retail Store ABC",
    "E-commerce Warehouse XYZ",
  ];

  @override
  void initState() {
    super.initState();
    if (widget.product == null || widget.batchid == null) {
      _createDummyData();
    } else {
      product = widget.product!;
      batchid = widget.batchid!;
    }
    generateBlocks();
  }

  void _createDummyData() {
    product = Product(
      name: "Organic Tomatoes",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh8Z623PwylM_uvoGrZWafCt8ynkjkonVm-w&s",
      category: "Vegetables",
      price: "150.00",
    );
    batchid = "BATCH-DMY-12345";
  }

  void generateBlocks() {
    double finalPrice = double.tryParse(product.price) ?? 0.0;
    double basePrice =
        finalPrice * (0.5 + random.nextDouble() * 0.2); // 50-70% of final
    int blockCount = 4 + random.nextInt(3); // 3–5 blocks
    DateTime today = DateTime.now();

    List<double> increments = List.generate(blockCount, (i) => 0);
    double remaining = finalPrice - basePrice;

    for (int i = 0; i < blockCount - 1; i++) {
      increments[i] = (remaining * (0.3 + random.nextDouble() * 0.4))
          .roundToDouble(); // 30–70% of remaining
      remaining -= increments[i];
    }
    increments[blockCount - 1] = remaining;

    double cumulative = basePrice;
    blocks = List.generate(blockCount, (i) {
      double added = increments[i];
      cumulative += added;

      String reason = i == 0
          ? "Farmer Price"
          : reasons[random.nextInt(reasons.length)];
      String location = reason == "Logistics"
          ? locations[random.nextInt(locations.length)]
          : locations[random.nextInt(locations.length)];

      String source = i == 0
          ? sources[0]
          : sources[random.nextInt(sources.length)];

      return {
        "blockId": "BLK-${1000 + i}",
        "addedAmount": added,
        "totalAmount": cumulative,
        "reason": reason,
        "location": location,
        "source": source,
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
                        product.imageUrl,
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
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Batch ID: $batchid",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Category: ${product.category}",
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
                Expanded(
                  child: Column(
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
                ),
                Expanded(
                  child: Column(
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
                ),
                Expanded(
                  child: Column(
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
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if ((blk["source"] as String).isNotEmpty)
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.blueAccent,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            "Source: ${blk["source"]}",
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                if ((blk["location"] as String).isNotEmpty)
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            "Location: ${blk["location"]}",
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
