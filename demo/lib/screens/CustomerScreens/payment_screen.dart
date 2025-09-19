import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedMethod;

  // To manage expansion
  bool cardExpanded = true;
  bool netBankingExpanded = false;
  bool upiExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Payment",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Debit / Credit Card section
              ExpansionTile(
                initiallyExpanded: cardExpanded,
                onExpansionChanged: (expanded) {
                  setState(() {
                    cardExpanded = expanded;
                    if (expanded) {
                      selectedMethod = "Credit / Debit Card";
                      netBankingExpanded = false;
                      upiExpanded = false;
                    }
                  });
                },
                leading: const Icon(Icons.credit_card),
                title: const Text(
                  "Debit / Credit Card",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Card Number",
                      hintText: "1234-5678-9876-4321",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "CVV/CVC No.",
                            hintText: "XXX",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Valid Thru",
                            hintText: "MM/YYYY",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Send OTP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (val) {},
                      ),
                      const Text("Save details for future"),
                    ],
                  ),
                ],
              ),

              // Net Banking
              ExpansionTile(
                initiallyExpanded: netBankingExpanded,
                onExpansionChanged: (expanded) {
                  setState(() {
                    netBankingExpanded = expanded;
                    if (expanded) {
                      selectedMethod = "Net Banking";
                      cardExpanded = false;
                      upiExpanded = false;
                    }
                  });
                },
                leading: const Icon(Icons.account_balance),
                title: const Text(
                  "Net Banking",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                children: const [
                  ListTile(title: Text("SBI")),
                  ListTile(title: Text("HDFC")),
                  ListTile(title: Text("ICICI")),
                  ListTile(title: Text("Axis Bank")),
                ],
              ),

              // UPI
              ExpansionTile(
                initiallyExpanded: upiExpanded,
                onExpansionChanged: (expanded) {
                  setState(() {
                    upiExpanded = expanded;
                    if (expanded) {
                      selectedMethod = "UPI";
                      cardExpanded = false;
                      netBankingExpanded = false;
                    }
                  });
                },
                leading: const Icon(Icons.currency_rupee),
                title: const Text(
                  "UPI",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "UPI ID",
                      hintText: "example@upi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Verify UPI",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Place Order button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF77C043),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.pop(context, selectedMethod ?? "Apple Pay");
                },
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
