import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productName;

  const ProductDetailsScreen({super.key, required this.productName});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  String selectedUnit = "100g";

  // Static product data
  Map<String, dynamic> getProductData(String name) {
    switch (name.toLowerCase()) {
      case "tomato":
        return {
          "title": "Tomato",
          "price": "₹40/kg",
          "unitOptions": ["100g", "250g", "500g", "1kg"],
          "description":
              "Fresh and juicy tomatoes, perfect for salads, curries, and sauces. Rich in vitamins A and C.",
          "image":
              "https://cdn.pixabay.com/photo/2015/03/14/15/11/tomatoes-673375_1280.jpg",
        };
      case "papaya":
        return {
          "title": "Papaya",
          "price": "₹60/kg",
          "unitOptions": ["500g", "1kg"],
          "description":
              "Sweet and tropical papaya, a rich source of Vitamin C and antioxidants. Great for digestion.",
          "image":
              "https://cdn.pixabay.com/photo/2017/03/27/14/56/papaya-2188445_1280.jpg",
        };
      case "banana":
        return {
          "title": "Banana",
          "price": "₹50/dozen",
          "unitOptions": ["6 pcs", "12 pcs"],
          "description":
              "Ripe and sweet bananas, full of potassium and fiber. Perfect for snacks and smoothies.",
          "image":
              "https://cdn.pixabay.com/photo/2018/01/16/07/48/bananas-3084082_1280.jpg",
        };
      case "carrot":
        return {
          "title": "Carrot",
          "price": "₹30/500g",
          "unitOptions": ["250g", "500g", "1kg"],
          "description":
              "Fresh, crunchy carrots, packed with beta-carotene, fiber, and nutrients. Great for salads or cooking.",
          "image":
              "https://cdn.pixabay.com/photo/2018/01/12/09/24/carrots-3071216_1280.jpg",
        };
      default:
        return {
          "title": "Unknown",
          "price": "₹0",
          "unitOptions": ["100g"],
          "description": "No description available.",
          "image": "",
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = getProductData(widget.productName);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Image.network(
              product["image"],
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            // Title & Price
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product["title"],
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(product["price"],
                      style: const TextStyle(
                          fontSize: 18, color: Colors.green)),
                  const SizedBox(height: 16),

                  // Unit Options
                  Wrap(
                    spacing: 8,
                    children: (product["unitOptions"] as List<String>)
                        .map(
                          (unit) => ChoiceChip(
                            label: Text(unit),
                            selected: selectedUnit == unit,
                            onSelected: (selected) {
                              setState(() {
                                selectedUnit = unit;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  const Text("Description",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(product["description"],
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey[700])),

                  const SizedBox(height: 20),

                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Product Quantity",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                          ),
                          Text(quantity.toString(),
                              style: const TextStyle(fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "${product["title"]} added to cart ($quantity $selectedUnit)"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        "Add to Cart",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
