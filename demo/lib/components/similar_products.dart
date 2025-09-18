import 'package:flutter/material.dart';

class SimilarProducts extends StatelessWidget {
  final dynamic product;

  const SimilarProducts({super.key, required this.product});

  Future<List<Map<String, dynamic>>> fetchSimilarProducts() async {
    // 🔹 Here you can call your API to get similar products
    // For now using dummy data
    await Future.delayed(const Duration(seconds: 1));
    return [
      {"name": "Similar Product 1", "price": "100"},
      {"name": "Similar Product 2", "price": "120"},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchSimilarProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text("No similar products found.");
        }

        final similarProducts = snapshot.data!;
        return Column(
          children: similarProducts.map((prod) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: Text(prod['name']),
                subtitle: Text("Price: ₹${prod['price']}"),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
