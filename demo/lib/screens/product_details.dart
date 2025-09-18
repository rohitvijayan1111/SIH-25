import 'package:flutter/material.dart';
import '../components/similar_products.dart';
// import 'similar_products.dart';

class ProductDetails extends StatelessWidget {
  final dynamic product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final name = product['descriptor']?['name'] ?? 'Unknown Item';
    final imageUrl =
        (product['descriptor']?['images'] != null &&
            product['descriptor']['images'].isNotEmpty)
        ? product['descriptor']['images'][0]
        : null;
    final qty = product['quantity']?['available']?['count'] ?? '-';
    final unit = product['quantity']?['unitized']?['measure']?['unit'] ?? '';
    final price = (product['batches']?[0]?['price']?['value'] ?? '-') ?? '-';

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: imageUrl != null
                  ? Image.network(imageUrl, height: 200)
                  : const Icon(Icons.shopping_bag, size: 120),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Available: $qty $unit"),
            Text("Price: ₹$price / $unit"),
            const SizedBox(height: 20),

            const Divider(),
            const Text(
              "Similar Products",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            SimilarProducts(
              product: product,
            ), // Call your SimilarProducts widget
          ],
        ),
      ),
    );
  }
}
