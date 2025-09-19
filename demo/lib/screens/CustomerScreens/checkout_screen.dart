import 'package:flutter/material.dart';
import 'payment_screen.dart';
import 'success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? selectedPaymentMethod = "Apple Pay";

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
                  const Icon(Icons.arrow_back, color: Colors.black),
                  const Text("Checkout",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 24),
                ],
              ),
              const SizedBox(height: 20),

              // Delivery Date
              sectionTile(
                label: "Delivery Date",
                title: "Thursday, October 12",
                subtitle: "10:00 AM",
              ),

              // Delivery Address
              sectionTile(
                label: "Delivery Address",
                title: "Home",
                subtitle: "43 Bourke Street, Newbridge NSW 837 Raffles ...",
              ),

              // Payment
              GestureDetector(
                onTap: () async {
                  final method = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentScreen()),
                  );
                  if (method != null) {
                    setState(() {
                      selectedPaymentMethod = method;
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
                      const Text("Payment",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Image.network(
                            "https://img.icons8.com/ios-filled/50/apple-pay.png",
                            width: 40,
                            height: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            selectedPaymentMethod ?? "Choose Payment",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const Icon(Icons.chevron_right,
                              color: Colors.grey, size: 20),
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
                  children: [
                    const Text("Order",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(height: 6),
                    const Text("Today",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    orderRow("Mustard Greens x 1", "₹59"),
                    orderRow("Organic Carrots x 1", "₹60"),
                    orderRow("Organic Apple x 1", "₹120"),
                    orderRow("Delivery Fee", "₹25"),
                    const Divider(),
                    orderRow("Total", "₹264", bold: true),
                  ],
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
                    const Text("Code Redeemed",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text("20% Off",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                  ],
                ),
              ),

              // Place Order Button
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF77C043),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SuccessScreen()),
                  );
                },
                child: const Center(
                  child: Text("Place Order",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTile(
      {required String label, required String title, required String subtitle}) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w400)),
          const SizedBox(height: 6),
          Row(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(subtitle,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black54)),
                  ]),
              const Spacer(),
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
          Text(item,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(price,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
