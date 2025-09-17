import 'package:flutter/material.dart';
import 'payment_completion_screen.dart'; // ensure this file exists

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> order;

  const PaymentScreen({super.key, required this.order});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String paymentType = "COD";
  bool loading = false;

  Future<void> handlePayment() async {
    if (loading) return;
    setState(() => loading = true);

    // 👇 Navigate and wait for result
    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PaymentCompletionScreen(
      amount: "1679",
      method: paymentType == "COD" ? "Cash" : "Online",
      dateTime: "September 1, 2025 at 9:45 PM",
    ),
  ),
);


    // Reset loading when user comes back
    if (mounted) {
      setState(() => loading = false);
    }
  }

  Widget _buildOption(String type, String label, String emoji) {
    final isSelected = paymentType == type;
    return GestureDetector(
      onTap: () => setState(() => paymentType = type),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[100] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
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
            Expanded(
              child: Text(
                "$emoji $label",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Text(
                "✓",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4), // bg-green-50
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "💳 Choose Payment Method",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF065F46), // green-800
                ),
              ),
              const SizedBox(height: 20),

              // COD Option
              _buildOption("COD", "Cash on Delivery (COD)", "🧺"),

              // Online Option
              _buildOption("ONLINE", "Online Payment", "🌱"),

              const Spacer(),

              // Proceed Button
              ElevatedButton(
                onPressed: loading ? null : handlePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      loading ? Colors.green[300] : Colors.green[600],
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  loading ? "Processing..." : "Proceed",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
