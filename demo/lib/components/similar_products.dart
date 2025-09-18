import 'package:flutter/material.dart';

class SimilarProducts extends StatelessWidget {
  final List<dynamic> relatedItems;
  final Function(String) onProductTap;

  const SimilarProducts({
    Key? key,
    required this.relatedItems,
    required this.onProductTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (relatedItems.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Text(
            "Similar Products",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 260, // Height for product card list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: relatedItems.length,
            itemBuilder: (context, index) {
              final item = relatedItems[index];

              final providerName = item["providerName"] ??
                  item["provider"]?["descriptor"]?["name"] ??
                  "Unknown Seller";

              final imageUrl = item["image"] ??
                  (item["descriptor"]?["images"] != null &&
                          (item["descriptor"]["images"] as List).isNotEmpty
                      ? item["descriptor"]["images"][0]
                      : "https://via.placeholder.com/150");

              final priceValue = item["price"]?["value"] ?? "0.00";
              final currency = item["price"]?["currency"] ?? "INR";
              final unit =
                  item["quantity"]?["unitized"]?["measure"]?["unit"] ?? "";

              return GestureDetector(
                onTap: () => onProductTap(item["id"]),
                child: Container(
                  width: 170,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Product Name
                      Text(
                        item["descriptor"]?["name"] ?? "Unnamed Product",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Price
                      Text(
                        "₹$priceValue / $unit",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Seller Info
                      Text(
                        "Seller: $providerName",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
