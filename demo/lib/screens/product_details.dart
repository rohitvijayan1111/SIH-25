import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/similar_products.dart';
// import 'similar_products.dart';

// Replace with your .env values
const SERVER_URL = "http://your-server-ip:5000";

class ProductDetailsScreen extends StatefulWidget {
  final String itemId;

  const ProductDetailsScreen({Key? key, required this.itemId, required product})
    : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Map<String, dynamic>? productData;
  bool loading = true;
  int quantity = 1;
  List<dynamic> relatedItems = [];
  int? selectedBatchIndex;
  double selectedPrice = 0.0;

  Map<String, dynamic> productInfo = {
    "price": "N/A",
    "currency": "INR",
    "weightPerUnit": null,
    "unit": "unit",
    "availableCount": 0,
  };

  Future<void> fetchSimilarProducts(String category) async {
    try {
      final url = Uri.parse("$SERVER_URL/bap/search");
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "productName": "",
          "category": category,
          "lat": 23.2599,
          "lon": 79.0882,
          "radius": 1000,
        }),
      );

      final json = jsonDecode(res.body);
      final catalog = json["catalog"]?["message"]?["catalog"] ?? {};
      final items = catalog["items"] ?? [];

      setState(() {
        relatedItems = items;
      });
    } catch (e) {
      debugPrint("❌ Error fetching similar products: $e");
    }
  }

  Future<void> fetchProductDetails() async {
    try {
      final url = Uri.parse("$SERVER_URL/bap/select");
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "items": [
            {"id": widget.itemId},
          ],
        }),
      );

      final json = jsonDecode(res.body);

      if (json["bpp_response"]?["message"]?["catalog"] != null) {
        final catalog = json["bpp_response"]["message"]["catalog"];
        final provider = catalog["providers"][0];
        final mainItem = provider["items"][0];

        if ((mainItem["batches"] as List).isNotEmpty) {
          final firstBatch = mainItem["batches"][0];
          productInfo = {
            "price": firstBatch["price"]?["value"] ?? "N/A",
            "currency": firstBatch["price"]?["currency"] ?? "INR",
            "weightPerUnit":
                firstBatch["quantity"]?["unitized"]?["measure"]?["weight_per_unit"],
            "unit":
                firstBatch["quantity"]?["unitized"]?["measure"]?["unit"] ??
                "unit",
            "availableCount":
                firstBatch["quantity"]?["available"]?["count"] ?? 0,
          };
        }

        setState(() {
          productData = catalog;
        });

        await fetchSimilarProducts(mainItem["category_id"]);
      }
    } catch (e) {
      debugPrint("❌ Error fetching product: $e");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void handleAddToCart(Map<String, dynamic> item) async {
    try {
      if (item["unit_price"] == 0) {
        debugPrint("⚠️ Missing Price - Please select a batch.");
        return;
      }

      final url = Uri.parse("http://192.168.39.249:5000/cart/add");
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(item),
      );

      if (res.statusCode == 200) {
        debugPrint("✅ Cart added successfully: ${res.body}");
      } else {
        debugPrint("❌ Failed to add to cart: ${res.body}");
      }
    } catch (e) {
      debugPrint("⚠️ Error in API call: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (productData == null || productData!["providers"] == null) {
      return const Scaffold(
        body: Center(child: Text("⚠️ No product data available")),
      );
    }

    final provider = productData!["providers"][0];
    final item = provider["items"][0];
    final batches = item["batches"] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(item["descriptor"]?["name"] ?? "Product Details"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                item["descriptor"]?["image"] ??
                    "https://via.placeholder.com/150",
                height: 200,
              ),
            ),
            const SizedBox(height: 10),

            // Provider
            Text(
              "Fulfilled by ${provider["descriptor"]?["name"] ?? "Unknown"}",
              style: const TextStyle(color: Colors.green, fontSize: 12),
            ),
            const SizedBox(height: 5),

            // Product Name
            Text(
              item["descriptor"]?["name"] ?? "Unnamed Product",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Price & Stock
            Text(
              "₹${productInfo["price"]} per ${productInfo["unit"]}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(
              "${productInfo["availableCount"]} available",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Quantity Selector
            Row(
              children: [
                const Text(
                  "Quantity: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity = (quantity > 1) ? quantity - 1 : 1;
                    });
                  },
                  icon: const Icon(Icons.remove_circle, color: Colors.green),
                ),
                Text(
                  "$quantity",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Batches
            if (batches.isNotEmpty) ...[
              const Text(
                "Available Batches",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < batches.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBatchIndex = i;
                      selectedPrice =
                          double.tryParse(batches[i]["price"]["value"]) ?? 0.0;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedBatchIndex == i
                            ? Colors.green
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: selectedBatchIndex == i
                          ? Colors.green.shade50
                          : Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹${batches[i]["price"]["value"]}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          "Stock: ${batches[i]["quantity"]["available"]["count"] ?? 0} units",
                        ),
                      ],
                    ),
                  ),
                ),
            ],

            const SizedBox(height: 20),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  handleAddToCart({
                    "user_id": "a985baac-9028-4dc1-bbd9-a6f3aae49ef5",
                    "bpp_id": productData?["bpp_id"] ?? "agri.bpp",
                    "bpp_product_id": item["id"],
                    "provider_id": provider["id"],
                    "provider_name": provider["descriptor"]["name"],
                    "item_name": item["descriptor"]["name"],
                    "quantity": quantity,
                    "unit_price": selectedPrice,
                    "image_url": item["descriptor"]["image"] ?? "",
                    "category": item["category_id"],
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "🛒 Add to Cart",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Similar Products (Placeholder)
            if (relatedItems.isNotEmpty) ...[
              const Text(
                "Similar Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: relatedItems
                    .map(
                      (prod) => ListTile(
                        leading: Image.network(
                          prod["descriptor"]?["image"] ??
                              "https://via.placeholder.com/50",
                          width: 50,
                          height: 50,
                        ),
                        title: Text(prod["descriptor"]?["name"] ?? "Unknown"),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
