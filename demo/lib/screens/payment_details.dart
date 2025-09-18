import 'package:flutter/material.dart';
import 'payment_screen.dart';

class PaymentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> paymentDetails;

  const PaymentDetailsScreen({super.key, required this.paymentDetails});

  @override
  Widget build(BuildContext context) {
    final transactions =
        (paymentDetails['transactions'] as List<dynamic>? ?? []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Header
            Container(
              color: const Color(0xFFB2FFB7),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Payment Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    // ✅ Amount Summary
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildRow(
                            "Total Amount",
                            "₹${paymentDetails['totalAmount']}",
                          ),
                          _buildRow(
                            "Paid Amount",
                            "₹${paymentDetails['paidAmount']}",
                          ),
                          _buildRow(
                            "Due Amount",
                            "₹${paymentDetails['dueAmount']}",
                          ),
                        ],
                      ),
                    ),

                    // ✅ Transactions
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Transactions",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final tx =
                                  transactions[index] as Map<String, dynamic>;
                              return ListTile(
                                title: Text("Pay By ${tx['method']}"),
                                subtitle: Text(tx['date'] ?? ''),
                                trailing: Text("₹${tx['amount']}"),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // ✅ Proceed to Payment
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PaymentScreen(order: paymentDetails),
                          ),
                        );
                      },
                      child: const Text(
                        "Proceed to Payment",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 15)),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
