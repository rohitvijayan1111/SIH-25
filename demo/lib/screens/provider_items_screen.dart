import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderItemsScreen extends StatefulWidget {
  final Map<String, dynamic> provider;
  const ProviderItemsScreen({Key? key, required this.provider})
      : super(key: key);

  @override
  State<ProviderItemsScreen> createState() => _ProviderItemsScreenState();
}

class _ProviderItemsScreenState extends State<ProviderItemsScreen> {
  late Map<String, dynamic> provider;
  final shippingCost = 40;

  @override
  void initState() {
    super.initState();
    provider = widget.provider;
  }

  double get totalMRP {
    return (provider['items'] as List<dynamic>)
        .fold(0.0, (sum, item) => sum + (item['total_price'] ?? 0));
  }

  Future<void> handleInit() async {
    try {
      final response = await http.post(
        Uri.parse('YOUR_SERVER_URL/bap/init'),
        headers: {
          'Content-Type': 'application/json',
          'x-transaction-id': 'txn-${DateTime.now().millisecondsSinceEpoch}',
        },
        body: jsonEncode({
          'provider_id': provider['provider_id'],
          'items': (provider['items'] as List<dynamic>).map((item) {
            return {
              'id': item['bpp_product_id'],
              'quantity': item['quantity'],
              'fulfillment_id': item['fulfillment_id']
            };
          }).toList(),
          'delivery_address': {
            'gps': '23.0225,72.5714',
            'address': 'Plot 12, SG Road, Ahmedabad, Gujarat'
          }
        }),
      );

      if (response.statusCode == 200) {
        final bppResponse = jsonDecode(response.body)['bpp_response'];
        // Navigate to next screen (replace with your route)
        Navigator.pushNamed(context, '/verifyProducts',
            arguments: {'bpp_response': bppResponse});
      } else {
        throw Exception('Failed to verify products');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to verify products. Please try again.')),
      );
    }
  }

  void updateCartQuantity(Map<String, dynamic> item, int newQty) async {
    try {
      final response = await http.put(
        Uri.parse('YOUR_SERVER_URL/cart/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': 'a985baac-9028-4dc1-bbd9-a6f3aae49ef5',
          'bpp_product_id': item['bpp_product_id'],
          'provider_id': provider['provider_id'],
          'quantity': newQty
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> updatedItems;
        if (newQty == 0) {
          updatedItems = (provider['items'] as List<dynamic>)
              .where((i) => i['bpp_product_id'] != item['bpp_product_id'])
              .toList();
        } else {
          updatedItems = (provider['items'] as List<dynamic>).map((i) {
            if (i['bpp_product_id'] == item['bpp_product_id']) {
              i['quantity'] = newQty;
              i['total_price'] = double.parse(
                  (newQty * (i['unit_price'] ?? 0)).toStringAsFixed(2));
            }
            return i;
          }).toList();
        }
        setState(() {
          provider['items'] = updatedItems;
        });
      } else {
        print('Failed to update cart: ${response.body}');
      }
    } catch (e) {
      print('Error updating quantity: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = provider['items'] as List<dynamic>;
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text(provider['provider_name']),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Provider Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider['provider_name'],
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "📍 ${provider['provider_address']}",
                          style: TextStyle(fontSize: 14, color: Colors.green[800]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Product List
                  ...items.map((item) {
                    final isOrganic = (item['tags'] as List<dynamic>?)
                            ?.any((t) => t['key'] == 'organic' && t['value'] == 'true') ??
                        false;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green.shade100),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  item['image_url'] ??
                                      'https://via.placeholder.com/60',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (isOrganic)
                                Positioned(
                                  top: -4,
                                  right: -4,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Organic',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),

                          // Product Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['item_name'],
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),

                                // Quantity Controls
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => updateCartQuantity(
                                          item, item['quantity'] - 1),
                                      icon: const Icon(Icons.remove_circle_outline),
                                    ),
                                    Text(
                                      '${item['quantity']}',
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      onPressed: () => updateCartQuantity(
                                          item, item['quantity'] + 1),
                                      icon: const Icon(Icons.add_circle_outline),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // Price Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Unit Price: ₹${item['unit_price']}',
                                        style: TextStyle(
                                            color: Colors.green[700], fontSize: 12)),
                                    Text('₹${item['total_price']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 16)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // Sticky Footer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '₹${totalMRP + shippingCost}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: handleInit,
                    child: const Center(
                        child: Text(
                      '✅ Verify Products & Continue',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
