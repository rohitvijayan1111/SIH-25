import 'package:flutter/material.dart';

import '../components/similar_products.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: product.imageUrl.startsWith('http')
                    ? Image.network(
                        product.imageUrl,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        product.imageUrl,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Product Name
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            const SizedBox(height: 8),

            // Availability & Price
            Text(
              "Available: $qty $unit",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Text(
              "Price: ₹$price / $unit",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
              ),
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 1),
            const SizedBox(height: 12),

            // Similar Products Section
            Text(
              "Similar Products",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            const SizedBox(height: 12),

            SimilarProducts(product: product),
          ],
        ),
      ),
    );
  }
}
