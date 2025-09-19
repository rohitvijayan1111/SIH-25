import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Payment",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              paymentOption("Credit / Debit Card"),
              paymentOption("UPI"),
              paymentOption("Net Banking"),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF77C043),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.pop(context, selectedMethod ?? "Apple Pay");
                },
                child: const Center(
                  child: Text("Update Now",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentOption(String method) {
    return RadioListTile<String>(
      title: Text(method),
      value: method,
      groupValue: selectedMethod,
      onChanged: (value) {
        setState(() {
          selectedMethod = value;
        });
      },
    );
  }
}
