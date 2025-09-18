import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerifyProductsScreen extends StatefulWidget {
  final Map<String, dynamic> bppResponse;
  const VerifyProductsScreen({Key? key, required this.bppResponse})
    : super(key: key);

  @override
  State<VerifyProductsScreen> createState() => _VerifyProductsScreenState();
}

class _VerifyProductsScreenState extends State<VerifyProductsScreen> {
  Map<String, dynamic>? selectedDelivery;
  List<dynamic> logisticsOptions = [];

  @override
  void initState() {
    super.initState();
    callBapLogistics();
  }

  Map<String, dynamic> get order => widget.bppResponse['message']['order'];
  List<dynamic> get items => order['items'] ?? [];
  Map<String, dynamic> get provider => order['provider'] ?? {};
  Map<String, dynamic> get quote => order['quote'] ?? {};
  Map<String, dynamic> get fulfillment => order['fulfillment'] ?? {};

  Future<void> callBapLogistics() async {
    try {
      final payload = {
        'start': {
          'gps': fulfillment['start']?['location']?['gps'] ?? "13.0827,80.2707",
          'address':
              fulfillment['start']?['location']?['address'] ??
              "Warehouse, Chennai",
        },
        'end': {
          'gps': fulfillment['end']?['location']?['gps'] ?? "12.9716,77.5946",
          'address':
              fulfillment['end']?['location']?['address'] ??
              "Customer Address, Bangalore",
        },
        'weight_kg': 5,
      };

      final response = await http.post(
        Uri.parse('YOUR_SERVER_URL/logistic/search'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          logisticsOptions = data['message']?['catalog']?['providers'] ?? [];
        });
      } else {
        print('Logistics API error: ${response.body}');
      }
    } catch (e) {
      print('❌ Logistics API Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (order.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            '❌ Invalid order data',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text(provider['descriptor']?['name'] ?? 'Unknown Provider'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Provider Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider['descriptor']?['name'] ?? 'Unknown Provider',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "📍 ${fulfillment['start']?['location']?['address'] ?? 'No address'}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[800],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Fulfillment Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.shade100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🚚 Fulfillment Info',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Type: ${fulfillment['type'] ?? 'N/A'}'),
                        Text(
                          '📍 Pickup: ${fulfillment['start']?['location']?['address'] ?? 'N/A'}',
                        ),
                        Text(
                          '🏁 Delivery: ${fulfillment['end']?['location']?['address'] ?? 'N/A'}',
                        ),
                        Text(
                          '⏳ ETA: ${fulfillment['estimated_delivery'] != null ? fulfillment['estimated_delivery'] : 'N/A'}',
                        ),
                      ],
                    ),
                  ),

                  // Verified Products
                  const Text(
                    '🧾 Verified Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...items.map((item) {
                    final qty = item['quantity']?['count'] ?? 1;
                    final unit =
                        item['quantity']?['unitized']?['measure']?['unit'] ??
                        '';
                    final unitPrice = double.parse(
                      item['price']?['value']?.toString() ?? '0',
                    );
                    final subtotal = (unitPrice * qty).toStringAsFixed(2);
                    final isOrganic = item['tags']?[0]?['value'] == 'true';
                    final imageUrl =
                        item['descriptor']?['images']?[0] ??
                        'https://via.placeholder.com/60';

                    return Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.shade100),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (isOrganic)
                                Positioned(
                                  top: -2,
                                  right: -2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Organic',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['descriptor']?['name'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Qty: $qty $unit',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Unit Price: ₹$unitPrice',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  'Subtotal: ₹$subtotal',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  // Price Summary
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green.shade100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '💰 Price Summary',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...((quote['breakup'] ?? []) as List<dynamic>).map((
                          entry,
                        ) {
                          final price = double.parse(
                            entry['price']?['value']?.toString() ?? '0',
                          );
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry['title'] ?? ''),
                              Text('₹$price'),
                            ],
                          );
                        }),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '₹${double.parse(quote['price']?['value']?.toString() ?? '0')}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Logistics Options
                  if (logisticsOptions.isNotEmpty) ...[
                    const Text(
                      '🚚 Delivery Options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...logisticsOptions.map((provider) {
                      final providerId = provider['id'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...((provider['items'] ?? []) as List<dynamic>).map((
                            option,
                          ) {
                            final isSelected =
                                selectedDelivery != null &&
                                selectedDelivery!['providerId'] == providerId &&
                                selectedDelivery!['itemId'] == option['id'];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDelivery = {
                                    'providerId': providerId,
                                    'providerName':
                                        provider['descriptor']?['name'],
                                    'itemId': option['id'],
                                    'itemName': option['descriptor']?['name'],
                                    'price': option['price']?['value'],
                                    'eta': option['time']?['duration'],
                                  };
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.green[100]
                                      : Colors.green[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.green
                                        : Colors.green.shade200,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option['descriptor']?['name'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Price: ₹${option['price']?['value'] ?? 0}',
                                        ),
                                        Text(
                                          'ETA: ${option['time']?['duration'] ?? ''}',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                  ],
                ],
              ),
            ),
          ),

          // Fixed Bottom CTA
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[100],
                border: Border(top: BorderSide(color: Colors.green.shade200)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: selectedDelivery != null
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/paymentScreen',
                          arguments: {'order': order},
                        );
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please select a delivery option before proceeding.',
                            ),
                          ),
                        );
                      },
                child: const Text(
                  '✅ Proceed to Payment',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
