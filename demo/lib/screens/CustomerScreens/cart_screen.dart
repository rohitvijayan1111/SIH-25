// import 'package:flutter/material.dart';
// import 'checkout_screen.dart'; // ✅ import your checkout screen

// // Cart Item Model - Represents each product in cart
// class CartItem {
//   final String id;
//   final String name;
//   final String category;
//   final String image;
//   final double price;
//   int quantity;

//   CartItem({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.image,
//     required this.price,
//     required this.quantity,
//   });
// }

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   // Sample cart items data (normally this comes from a database/API)
//   List<CartItem> cartItems = [
//     CartItem(
//       id: '1',
//       name: 'Mustard Greens',
//       category: 'Vegetables',
//       image: '🥬', // Using emoji as placeholder
//       price: 59.0,
//       quantity: 1,
//     ),
//     CartItem(
//       id: '2',
//       name: 'Organic Carrots',
//       category: 'Vegetables',
//       image: '🥕',
//       price: 60.0,
//       quantity: 1,
//     ),
//     CartItem(
//       id: '3',
//       name: 'Organic Apple',
//       category: 'Fruits',
//       image: '🍎',
//       price: 120.0,
//       quantity: 1,
//     ),
//   ];

//   // Variables for delivery and pickup selection
//   bool isDeliverySelected = true; // True = delivery, False = pickup
//   double deliveryFee = 25.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Background color of entire screen
//       backgroundColor: Colors.white,

//       // Top app bar
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.close, color: Colors.black),
//         ),
//         title: const Text(
//           'Shopping Cart',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: () {
//               print('Edit tapped');
//             },
//             child: const Text(
//               'Edit',
//               style: TextStyle(color: Colors.black, fontSize: 16),
//             ),
//           ),
//         ],
//       ),

//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];
//                 return _buildCartItemCard(item, index);
//               },
//             ),
//           ),
//           _buildBottomSection(),
//         ],
//       ),
//     );
//   }

//   Widget _buildCartItemCard(CartItem item, int index) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: Colors.grey,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: Text(item.image, style: const TextStyle(fontSize: 30)),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.category,
//                   style: const TextStyle(
//                     color: Colors.green,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   item.name,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Qty: ${item.quantity}',
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 '₹${item.price.toInt()}',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (item.quantity > 1) {
//                           item.quantity--;
//                         }
//                       });
//                     },
//                     child: Container(
//                       width: 32,
//                       height: 32,
//                       decoration: BoxDecoration(
//                         color: Colors.grey,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(Icons.remove,
//                           size: 16, color: Colors.black),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Text(
//                     '${item.quantity}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         item.quantity++;
//                       });
//                     },
//                     child: Container(
//                       width: 32,
//                       height: 32,
//                       decoration: const BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                       ),
//                       child:
//                           const Icon(Icons.add, size: 16, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomSection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             offset: Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _buildCouponSection(),
//           const SizedBox(height: 16),
//           _buildDeliveryOptions(),
//           const SizedBox(height: 16),
//           _buildPriceBreakdown(),
//           const SizedBox(height: 20),
//           _buildCheckoutButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildCouponSection() {
//     return Row(
//       children: [
//         const Text(
//           'Coupon code',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         const Spacer(),
//         GestureDetector(
//           onTap: () {
//             print('Coupon tapped');
//           },
//           child: const Text(
//             'Your code',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDeliveryOptions() {
//     return Row(
//       children: [
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               setState(() {
//                 isDeliverySelected = false;
//               });
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               decoration: BoxDecoration(
//                 color: !isDeliverySelected ? Colors.green : Colors.grey,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: !isDeliverySelected ? Colors.green : Colors.grey,
//                 ),
//               ),
//               child: Text(
//                 'Pickup',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: !isDeliverySelected ? Colors.white : Colors.grey,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               setState(() {
//                 isDeliverySelected = true;
//               });
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               decoration: BoxDecoration(
//                 color: isDeliverySelected ? Colors.green : Colors.grey,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: isDeliverySelected ? Colors.green : Colors.grey,
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Delivery',
//                     style: TextStyle(
//                       color: isDeliverySelected ? Colors.white : Colors.grey,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   if (isDeliverySelected) ...[
//                     const SizedBox(width: 8),
//                     Container(
//                       width: 20,
//                       height: 20,
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(Icons.check,
//                           size: 14, color: Colors.green),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPriceBreakdown() {
//     double subtotal = cartItems.fold(
//       0,
//       (sum, item) => sum + (item.price * item.quantity),
//     );
//     double currentDeliveryFee = isDeliverySelected ? deliveryFee : 0;
//     double total = subtotal + currentDeliveryFee;

//     return Column(
//       children: [
//         if (isDeliverySelected)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Delivery fee', style: TextStyle(fontSize: 16)),
//                 Text(
//                   '₹${currentDeliveryFee.toInt()}',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Total Price',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '₹${total.toInt()}',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 4),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${cartItems.length} items',
//                 style: const TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//               const Text(
//                 'Include taxes',
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ✅ Updated Checkout button
//   Widget _buildCheckoutButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const CheckoutScreen()),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: const Text(
//           'Checkout',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../global.dart';
import 'models/product_model.dart'; // ✅ import product data
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final int value; // same as HomeScreen's valuet

  const CartScreen({super.key, this.value = 0});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int valuet;
  List<Product> products = [];
  bool isDeliverySelected = true;

  @override
  void initState() {
    super.initState();
    valuet = widget.value;
    products = valuet == 0
        ? ProductData.getAllProducts()
        : ProductData.getAllServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: _buildCartItems(),
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }

  List<Widget> _buildCartItems() {
    List<Widget> widgets = [];

    gcart.forEach((productId, batches) {
      final product = products.firstWhere(
        (p) => p.id == productId,
        orElse: () => Product.empty(),
      );

      batches.forEach((batchId, values) {
        int unitPrice = values[0];
        int itemCount = values[1];
        int logisticProvider = values[2];
        int deliveryChargePerUnit = values[3];

        widgets.add(
          _buildCartItemCard(
            product,
            batchId,
            unitPrice,
            itemCount,
            logisticProvider,
            deliveryChargePerUnit,
          ),
        );
      });
    });

    return widgets;
  }

  Widget _buildCartItemCard(
    Product product,
    String batchId,
    int unitPrice,
    int itemCount,
    int logisticProvider,
    int deliveryChargePerUnit,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              image: product.imageUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: product.imageUrl.isEmpty
                ? const Icon(Icons.shopping_bag, size: 30)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Batch: $batchId | Qty: $itemCount",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹${unitPrice * itemCount}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (itemCount > 1) {
                          gcart[product.id]![batchId]![1]--;
                        }
                      });
                    },
                    child: _circleBtn(Icons.remove, Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$itemCount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        gcart[product.id]![batchId]![1]++;
                      });
                    },
                    child: _circleBtn(
                      Icons.add,
                      Colors.green,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(
    IconData icon,
    Color color, {
    Color iconColor = Colors.black,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 16, color: iconColor),
    );
  }

  Widget _buildBottomSection() {
    double subtotal = 0;
    double deliveryFee = 0;
    int totalItems = 0;

    gcart.forEach((productId, batches) {
      batches.forEach((batchId, values) {
        int unitPrice = values[0];
        int itemCount = values[1];
        int deliveryChargePerUnit = values[3];

        subtotal += unitPrice * itemCount;
        if (isDeliverySelected) {
          deliveryFee += deliveryChargePerUnit * itemCount;
        }
        totalItems += itemCount;
      });
    });

    double total = subtotal + deliveryFee;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDeliveryOptions(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(fontSize: 16)),
              Text(
                '₹${subtotal.toInt()}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          if (isDeliverySelected)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery fee', style: TextStyle(fontSize: 16)),
                Text(
                  '₹${deliveryFee.toInt()}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          const Divider(height: 20, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹${total.toInt()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$totalItems items',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Text(
                'Include taxes',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isDeliverySelected = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: !isDeliverySelected ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Pickup',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: !isDeliverySelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isDeliverySelected = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isDeliverySelected ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Delivery',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDeliverySelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CheckoutScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
