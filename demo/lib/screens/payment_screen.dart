import 'package:flutter/material.dart';
import 'payment_completion_screen.dart';

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

    // 👉 Navigate directly to success screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentCompletionScreen(
          amount: widget.order['totalAmount'].toString(),
          method: paymentType,
          dateTime: DateTime.now().toString(),
        ),
      ),
    );

    setState(() => loading = false);
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
        ),
        child: Row(
          children: [
            Expanded(child: Text("$emoji $label")),
            if (isSelected)
              const Text("✓",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("💳 Choose Payment Method",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF065F46))),
              const SizedBox(height: 20),
              _buildOption("COD", "Cash on Delivery (COD)", "🧺"),
              _buildOption("ONLINE", "Online Payment", "🌱"),
              const Spacer(),
              ElevatedButton(
                onPressed: loading ? null : handlePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      loading ? Colors.green[300] : Colors.green[600],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  loading ? "Processing..." : "Proceed",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
