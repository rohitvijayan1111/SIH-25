import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// View Cart Screen
/// Displays farmers/suppliers in the cart with their details and item counts
/// Allows users to manage their cart and proceed with orders
class ViewCartScreen extends StatefulWidget {
  const ViewCartScreen({super.key});

  @override
  State<ViewCartScreen> createState() => _ViewCartScreenState();
}

class _ViewCartScreenState extends State<ViewCartScreen> {
  List<dynamic> cartData = [];
  bool loading = true;

  // Replace with your actual URL
  final String serverUrl = "http://your-server-url.com";

  Future<void> fetchCartData() async {
    try {
      final response = await http.get(
        Uri.parse("$serverUrl/cart/view/a985baac-9028-4dc1-bbd9-a6f3aae49ef5"),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          cartData = jsonData["cart"] ?? [];
        });
      } else {
        _showError("Failed to load cart data.");
      }
    } catch (err) {
      debugPrint("❌ Failed to fetch cart: $err");
      _showError("Failed to load cart data.");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Colors.green),
              SizedBox(height: 12),
              Text("Loading your cart..."),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4), // green-50
      body: Column(
        children: [
          // 🟢 Header (common for both states)
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ⬅️ Back Button + Title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "My Cart",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                // 🏷️ Item Count (Only show if cart has items)
                if (cartData.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade500,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "${cartData.fold<int>(0, (acc, curr) {
                        final provider = curr as Map<String, dynamic>;
                        final items = provider['items'] as List<dynamic>? ?? [];
                        return acc + items.length;
                      })} items",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
              ],
            ),
          ),

          // 📦 Body content (Empty / Non-Empty)
          Expanded(
            child: cartData.isEmpty
                ? _buildEmptyCart(context)
                : _buildCartList(context),
          ),
        ],
      ),
    );
  }

  /// Empty cart widget
  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🛒 Circular Icon
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: const Text("🛒🌿", style: TextStyle(fontSize: 48)),
          ),
          const SizedBox(height: 24),

          const Text(
            "Your Cart Feels Light",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          const Text(
            "Add some fresh products to get started",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 28),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 4,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/home");
            },
            child: const Text(
              "Browse Products",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  /// Non-empty cart widget
  Widget _buildCartList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cartData.length,
      itemBuilder: (context, index) {
        final provider = cartData[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              "/providerItems",
              arguments: provider,
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.green.shade100),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon Area
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text("🧑‍🌾",
                      style:
                          TextStyle(fontSize: 20, color: Colors.green)),
                ),
                const SizedBox(width: 16),

                // Provider Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider["provider_name"] ?? "Unknown",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text("📍", style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              provider["provider_address"] ?? "",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // Item Count & Arrow
                Row(
                  children: [
                    Text(
                      "${provider["items"]?.length ?? 0}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green),
                    ),
                    const SizedBox(width: 4),
                    const Text("→",
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Cart Item Model
/// Represents a farmer/supplier item in the cart
class CartItem {
  final String id;
  final String farmerName;
  final String location;
  int itemCount;
  final String profileImage;

  CartItem({
    required this.id,
    required this.farmerName,
    required this.location,
    required this.itemCount,
    required this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmerName': farmerName,
      'location': location,
      'itemCount': itemCount,
      'profileImage': profileImage,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      farmerName: json['farmerName'],
      location: json['location'],
      itemCount: json['itemCount'],
      profileImage: json['profileImage'],
    );
  }
}
