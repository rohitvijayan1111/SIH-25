import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetailsScreen extends StatefulWidget {
  final String itemId;

  const ProductDetailsScreen({super.key, required this.itemId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool loading = true;
  int quantity = 1;
  Map<String, dynamic>? productData;
  List<dynamic> relatedItems = [];
  int? selectedBatchIndex;
  double? selectedPrice;

  // TODO: Replace with your real server URLs
  final String apiUrl = "http://your-server-ip:5000/bap/select";
  final String searchUrl = "http://your-server-ip:5000/bap/search";

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "items": [
            {"id": widget.itemId},
          ],
        }),
      );

      final json = jsonDecode(response.body);

      final catalog = json["bpp_response"]?["message"]?["catalog"];
      if (catalog != null) {
        setState(() {
          productData = catalog;
        });

        final mainItem = catalog["providers"]?[0]?["items"]?[0];
        if (mainItem != null && mainItem["category_id"] != null) {
          await fetchSimilarProducts(mainItem["category_id"]);
        }
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      debugPrint("❌ Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to load product details")),
        );
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> fetchSimilarProducts(String categoryName) async {
    try {
      final response = await http.post(
        Uri.parse(searchUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "productName": "",
          "category": categoryName,
          "lat": 23.2599,
          "lon": 79.0882,
          "radius": 1000,
        }),
      );

      final json = jsonDecode(response.body);
      setState(() {
        relatedItems = json["catalog"]?["message"]?["catalog"]?["items"] ?? [];
      });
    } catch (e) {
      debugPrint("❌ Error fetching similar products: $e");
    }
  }

  void handleBatchSelect(int index, Map<String, dynamic> batch) {
    setState(() {
      selectedBatchIndex = index;
      selectedPrice = double.tryParse(
        batch["price"]?["value"]?.toString() ?? "0",
      );
    });
  }

  void handleAddToCart(Map<String, dynamic> item) {
    debugPrint("🛒 Added to cart: $item");
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Added to cart")));
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (productData == null ||
        productData!["providers"] == null ||
        productData!["providers"].isEmpty) {
      return const Scaffold(
        body: Center(child: Text("⚠️ No product data available")),
      );
    }

    final provider = productData!["providers"][0];
    final item = provider["items"][0];

    return Scaffold(
      appBar: AppBar(
        title: Text(item["descriptor"]?["name"] ?? "Product"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: Image.network(
                item["descriptor"]?["image"] ??
                    "https://via.placeholder.com/150",
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),

            // Product Name
            Text(
              item["descriptor"]?["name"] ?? "Unnamed Product",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Price
            Text(
              "₹${item["batches"]?[0]?["price"]?["value"] ?? "N/A"}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),

            // Quantity Selector
            Row(
              children: [
                const Text(
                  "Quantity:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => setState(() {
                    if (quantity > 1) quantity--;
                  }),
                ),
                Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                  onPressed: () => setState(() => quantity++),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Available Batches
            if (item["batches"] != null && item["batches"].isNotEmpty) ...[
              const Text(
                "Available Batches",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < item["batches"].length; i++)
                GestureDetector(
                  onTap: () => handleBatchSelect(i, item["batches"][i]),
                  child: Card(
                    color: (selectedBatchIndex == i)
                        ? Colors.green.shade50
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹${item["batches"][i]["price"]?["value"] ?? "N/A"}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Stock: ${item["batches"][i]["quantity"]?["available"]?["count"] ?? "N/A"}",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],

            const SizedBox(height: 20),

            // Add to Cart
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => handleAddToCart({
                  "item_name": item["descriptor"]?["name"],
                  "quantity": quantity,
                  "unit_price":
                      selectedPrice ??
                      double.tryParse(
                        item["batches"]?[0]?["price"]?["value"]?.toString() ??
                            "0",
                      ) ??
                      0,
                }),
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
