import 'package:flutter/material.dart';
import 'payment_screen.dart';
import 'success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? selectedPaymentMethod;
  String? selectedPaymentIcon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  const Text(
                    "Checkout",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
              const SizedBox(height: 20),

              // Delivery Date
              // sectionTile(
              //   label: "Delivery Date",
              //   title: "Thursday, October 12",
              //   subtitle: "10:00 AM",
              // ),

              // Delivery Address
              sectionTile(
                label: "Delivery Address",
                title: "Home",
                subtitle: "43 Bourke Street, Delhi",
              ),

              // Payment Section - Updated
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ),
                  );

                  if (result != null && result is Map<String, String>) {
                    setState(() {
                      selectedPaymentMethod = result['method'];
                      selectedPaymentIcon = result['icon'];
                    });
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // Payment icon or + button
                          if (selectedPaymentMethod != null &&
                              selectedPaymentIcon != null)
                            Container(
                              width: 40,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.orange.shade200,
                                ),
                              ),
                              child: Icon(
                                _getPaymentIcon(selectedPaymentIcon!),
                                color: Colors.orange.shade600,
                                size: 16,
                              ),
                            )
                          else
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.orange.shade300,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.orange.shade600,
                                size: 16,
                              ),
                            ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              selectedPaymentMethod ?? "Choose Payment Method",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selectedPaymentMethod != null
                                    ? Colors.black
                                    : Colors.grey.shade600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          const Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Order Summary
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // children: [
                  // const Text(
                  //   "Order",
                  //   style: TextStyle(
                  //     fontSize: 13,
                  //     color: Colors.grey,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                  // const SizedBox(height: 6),
                  // const Text(
                  //   "Today",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // orderRow("Mustard oranges x 1", "₹59"),
                  // orderRow("Organic Carrots x 1", "₹60"),
                  // orderRow("Organic Apple x 1", "₹120"),
                  // orderRow("Delivery Fee", "₹25"),
                  // const Divider(),
                  // orderRow("Total", "₹264", bold: true),
                  // ],
                ),
              ),

              // Coupon
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Code Redeemed",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "20% Off",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Place Order Button
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: selectedPaymentMethod != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SuccessScreen(),
                          ),
                        );
                      }
                    : null,
                child: const Center(
                  child: Text(
                    "Place Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getPaymentIcon(String iconType) {
    switch (iconType) {
      case 'card':
        return Icons.credit_card;
      case 'bank':
        return Icons.account_balance;
      case 'upi':
        return Icons.account_balance_wallet;
      default:
        return Icons.payment;
    }
  }

  Widget sectionTile({
    required String label,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget orderRow(String item, String price, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: CheckoutScreen(),
// //     );
// //   }
// // }

// class _Address {
//   final String title;
//   final String subtitle;

//   _Address(this.title, this.subtitle);
// }

// class PaymentMethod {
//   final String name;
//   final String icon;

//   PaymentMethod({required this.name, required this.icon});
// }

// class PaymentScreen extends StatelessWidget {
//   const PaymentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<PaymentMethod> methods = [
//       PaymentMethod(name: "Credit Card", icon: 'card'),
//       PaymentMethod(name: "Bank Transfer", icon: 'bank'),
//       PaymentMethod(name: "UPI / Wallets", icon: 'upi'),
//       PaymentMethod(name: "Cash on Delivery", icon: 'cash'),
//     ];

//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Payment Method")),
//       body: ListView.builder(
//         itemCount: methods.length,
//         itemBuilder: (context, index) {
//           final method = methods[index];
//           return ListTile(
//             leading: Icon(_getPaymentIcon(method.icon)),
//             title: Text(method.name),
//             onTap: () {
//               Navigator.pop(context, {
//                 'method': method.name,
//                 'icon': method.icon,
//               });
//             },
//           );
//         },
//       ),
//     );
//   }

//   IconData _getPaymentIcon(String iconType) {
//     switch (iconType) {
//       case 'card':
//         return Icons.credit_card;
//       case 'bank':
//         return Icons.account_balance;
//       case 'upi':
//         return Icons.account_balance_wallet;
//       case 'cash':
//         return Icons.money;
//       default:
//         return Icons.payment;
//     }
//   }
// }

// class SuccessScreen extends StatelessWidget {
//   const SuccessScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.check_circle_outline,
//               color: Colors.orange,
//               size: 100,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Order Placed Successfully!",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.orange,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Your order has been confirmed and is on its way.",
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).popUntil((route) => route.isFirst);
//               },
//               child: const Text("Back to Home"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   String? selectedPaymentMethod;
//   String? selectedPaymentIcon;
//   final List<_Address> _addresses = [
//     _Address("Home", "43 Bourke Street, Chennai"),
//     _Address("Office", "123 Main Street, Central"),
//   ];
//   _Address? _selectedAddress;
//   final _addressController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _selectedAddress = _addresses.first;
//   }

//   @override
//   void dispose() {
//     _addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(Icons.arrow_back, color: Colors.black),
//                   ),
//                   const Text(
//                     "Checkout",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 24),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Delivery Date
//               _sectionTile(
//                 label: "Delivery Date",
//                 title: "Today",
//                 subtitle: "Monday, 23 Sep 2025",
//               ),
//               const SizedBox(height: 10),

//               // Delivery Address
//               _buildAddressSection(),

//               // Payment Section
//               GestureDetector(
//                 onTap: () async {
//                   final result = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const PaymentScreen(),
//                     ),
//                   );
//                   if (result != null && result is Map<String, String>) {
//                     setState(() {
//                       selectedPaymentMethod = result['method'];
//                       selectedPaymentIcon = result['icon'];
//                     });
//                   }
//                 },
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(color: Colors.grey, width: 0.5),
//                     ),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Payment",
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           // Payment icon or + button
//                           if (selectedPaymentMethod != null &&
//                               selectedPaymentIcon != null)
//                             Container(
//                               width: 40,
//                               height: 25,
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade50,
//                                 borderRadius: BorderRadius.circular(6),
//                                 border: Border.all(
//                                   color: Colors.orange.shade200,
//                                 ),
//                               ),
//                               child: Icon(
//                                 _getPaymentIcon(selectedPaymentIcon!),
//                                 color: Colors.orange.shade600,
//                                 size: 16,
//                               ),
//                             )
//                           else
//                             Container(
//                               width: 30,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.shade100,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: Colors.orange.shade300,
//                                 ),
//                               ),
//                               child: Icon(
//                                 Icons.add,
//                                 color: Colors.orange.shade600,
//                                 size: 16,
//                               ),
//                             ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               selectedPaymentMethod ?? "Choose Payment Method",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: selectedPaymentMethod != null
//                                     ? Colors.black
//                                     : Colors.grey.shade600,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const Icon(
//                             Icons.chevron_right,
//                             color: Colors.grey,
//                             size: 20,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Order Summary
//               _sectionTile(
//                 label: "Order Summary",
//                 title: "2 items",
//                 subtitle: "Subtotal: \$10.00\nShipping: \$5.00\nTotal: \$15.00",
//               ),
//               const SizedBox(height: 20),

//               // Coupon
//               Container(
//                 margin: const EdgeInsets.only(top: 10),
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Code Redeemed",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.purple,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Text(
//                         "20% Off",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Place Order Button
//               const SizedBox(height: 25),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF77C043),
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (selectedPaymentMethod != null) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SuccessScreen(),
//                         ),
//                       );
//                     }
//                   },
//                   child: const Center(
//                     child: Text(
//                       "Place Order",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressSection() {
//     return Container(
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Delivery Address",
//             style: TextStyle(
//               fontSize: 13,
//               color: Colors.grey,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           const SizedBox(height: 6),
//           DropdownButton<_Address?>(
//             value: _selectedAddress,
//             isExpanded: true,
//             icon: const Icon(Icons.chevron_right, color: Colors.grey),
//             underline: const SizedBox.shrink(),
//             onChanged: (_Address? newValue) {
//               if (newValue == null) {
//                 _showAddAddressDialog();
//               } else {
//                 setState(() {
//                   _selectedAddress = newValue;
//                 });
//               }
//             },
//             items: [
//               ..._addresses.map((_Address address) {
//                 return DropdownMenuItem<_Address?>(
//                   value: address,
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           address.title,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Text(
//                           address.subtitle,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.black54,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 2,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//               const DropdownMenuItem<_Address?>(
//                 value: null,
//                 child: Row(
//                   children: [
//                     Icon(Icons.add_circle, color: Colors.orange),
//                     SizedBox(width: 8),
//                     Text(
//                       "Add New Address",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.orange,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddAddressDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Add New Address"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _addressController,
//                 decoration: const InputDecoration(
//                   labelText: "Enter Address",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.map_outlined),
//                 label: const Text("Choose from Map"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   _showMapDialog();
//                 },
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 _addressController.clear();
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (_addressController.text.isNotEmpty) {
//                   setState(() {
//                     final newAddressObject = _Address(
//                       "New Address",
//                       _addressController.text,
//                     );
//                     _addresses.add(newAddressObject);
//                     _selectedAddress = newAddressObject;
//                   });
//                   _addressController.clear();
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: const Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showMapDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Choose from Map"),
//           content: SizedBox(
//             height: 250,
//             width: double.maxFinite,
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(
//                     color: Colors.grey.shade200,
//                     child: const Center(
//                       child: Text(
//                         "Map View Placeholder",
//                         style: TextStyle(color: Colors.black54),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     _addressController.text =
//                         "123 Mock Street, Map City, 12345";
//                     Navigator.of(context).pop();
//                     _showAddAddressDialog();
//                   },
//                   child: const Text("Confirm Location"),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   IconData _getPaymentIcon(String iconType) {
//     switch (iconType) {
//       case 'card':
//         return Icons.credit_card;
//       case 'bank':
//         return Icons.account_balance;
//       case 'upi':
//         return Icons.account_balance_wallet;
//       default:
//         return Icons.payment;
//     }
//   }

//   Widget _sectionTile({
//     required String label,
//     required String title,
//     required String subtitle,
//   }) {
//     return Container(
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 13,
//               color: Colors.grey,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Text(
//                       subtitle,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black54,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//               const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
