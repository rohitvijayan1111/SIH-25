import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentType = "Debit / Credit Card";
  String? selectedBank;
  String? selectedApp;
  bool isCardExpanded = false;
  bool isBankingExpanded = false;
  bool isUpiExpanded = false;

  // Controllers for form fields
  final cardNumberController = TextEditingController();
  final cvvController = TextEditingController();
  final validThruController = TextEditingController();
  final fullNameController = TextEditingController();
  final upiController = TextEditingController();

  bool saveDetailsForFuture = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "Payment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Payment Method",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Debit/Credit Card Section
            _buildPaymentOption(
              title: "Debit / Credit Card",
              icon: Icons.credit_card,
              iconColor: Colors.blue,
              isSelected: selectedPaymentType == "Debit / Credit Card",
              isExpanded: isCardExpanded,
              onTap: () {
                setState(() {
                  selectedPaymentType = "Debit / Credit Card";
                  isCardExpanded = !isCardExpanded;
                  isBankingExpanded = false;
                  isUpiExpanded = false;
                });
              },
              children: isCardExpanded ? _buildCardForm() : [],
            ),

            const SizedBox(height: 12),

            // Net Banking Section
            _buildPaymentOption(
              title: "Net Banking",
              icon: Icons.account_balance,
              iconColor: Colors.orange,
              isSelected: selectedPaymentType == "Net Banking",
              isExpanded: isBankingExpanded,
              onTap: () {
                setState(() {
                  selectedPaymentType = "Net Banking";
                  isBankingExpanded = !isBankingExpanded;
                  isCardExpanded = false;
                  isUpiExpanded = false;
                });
              },
              children: isBankingExpanded ? _buildBankingOptions() : [],
            ),

            const SizedBox(height: 12),

            // UPI Section
            _buildPaymentOption(
              title: "UPI",
              icon: Icons.account_balance_wallet,
              iconColor: Colors.orange,
              isSelected: selectedPaymentType == "UPI",
              isExpanded: isUpiExpanded,
              onTap: () {
                setState(() {
                  selectedPaymentType = "UPI";
                  isUpiExpanded = !isUpiExpanded;
                  isCardExpanded = false;
                  isBankingExpanded = false;
                });
              },
              children: isUpiExpanded ? _buildUpiOptions() : [],
            ),

            const SizedBox(height: 30),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: const Color(0xFF77C043),
                  backgroundColor: Colors.orange.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _canProceed()
                    ? () {
                        // Return the selected payment method to checkout screen
                        Navigator.pop(context, {
                          'method': _getSelectedPaymentText(),
                          'icon': _getSelectedPaymentIcon(),
                        });
                      }
                    : null,
                child: const Text(
                  "Continue",
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
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required IconData icon,
    required Color iconColor,
    required bool isSelected,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.orange.shade300 : Colors.orange.shade200,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.orange.shade700
                            : Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded && children.isNotEmpty) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: children),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildCardForm() {
    return [
      TextField(
        controller: cardNumberController,
        decoration: InputDecoration(
          labelText: "Card Number",
          hintText: "Enter card number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.orange, width: 1),
          ),
          prefixIcon: const Icon(Icons.credit_card, color: Colors.grey),
        ),
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: cvvController,
              decoration: InputDecoration(
                labelText: "CVV/CVC No.",
                hintText: "XXX",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: validThruController,
              decoration: InputDecoration(
                labelText: "Valid Thru",
                hintText: "MM/YY",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                ),
              ),
              keyboardType: TextInputType.datetime,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      TextField(
        controller: fullNameController,
        decoration: InputDecoration(
          labelText: "Full Name",
          hintText: "Enter full name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          prefixIcon: const Icon(Icons.person, color: Colors.grey),
        ),
      ),
      const SizedBox(height: 16),
      Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade600,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            // Handle Send OTP
          },
          child: const Text(
            "Send OTP",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Checkbox(
            value: saveDetailsForFuture,
            onChanged: (value) {
              setState(() {
                saveDetailsForFuture = value ?? false;
              });
            },
            activeColor: Colors.orange,
          ),
          const Text("Save details for future"),
        ],
      ),
    ];
  }

  List<Widget> _buildBankingOptions() {
    final banks = ["SBI", "HDFC", "ICICI", "Axis Bank"];
    return [
      const Text(
        "Select Bank from the List",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        value: selectedBank,
        decoration: InputDecoration(
          labelText: "Select Bank",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        items: banks.map((bank) {
          return DropdownMenuItem(value: bank, child: Text(bank));
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedBank = value;
          });
        },
      ),
      const SizedBox(height: 16),
      Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedBank != null
                ? Colors.orange.shade600
                : Colors.grey.shade400,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: selectedBank != null
              ? () {
                  // Handle bank selection proceed
                }
              : null,
          child: const Text(
            "Proceed",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildUpiOptions() {
    return [
      const Text(
        "Choose App",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      const SizedBox(height: 16),

      // First row: Google Pay, PhonePe
      Row(
        children: [
          Expanded(
            child: buildUpiAppButton(
              logoUrl:
                  'https://img.icons8.com/?size=100&id=am4ltuIYDpQ5&format=png&color=000000',
              label: 'Google Pay',
              isSelected: selectedApp == 'gpay',
              onTap: () => setState(() => selectedApp = 'gpay'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: buildUpiAppButton(
              logoUrl:
                  'https://img.icons8.com/?size=100&id=OYtBxIlJwMGA&format=png&color=000000',
              label: 'PhonePe',
              isSelected: selectedApp == 'phonepe',
              onTap: () => setState(() => selectedApp = 'phonepe'),
            ),
          ),
        ],
      ),

      const SizedBox(height: 12),

      // Second row: Paytm, Amazon Pay
      Row(
        children: [
          Expanded(
            child: buildUpiAppButton(
              logoUrl:
                  'https://img.icons8.com/?size=100&id=68067&format=png&color=000000',
              label: 'Paytm',
              isSelected: selectedApp == 'paytm',
              onTap: () => setState(() => selectedApp = 'paytm'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: buildUpiAppButton(
              logoUrl:
                  'https://img.icons8.com/?size=100&id=2nt5XhjL7jBK&format=png&color=000000',
              label: 'Amazon Pay',
              isSelected: selectedApp == 'amazon',
              onTap: () => setState(() => selectedApp = 'amazon'),
            ),
          ),
        ],
      ),

      const SizedBox(height: 20),

      // Divider with "Or"
      Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade300)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("Or", style: TextStyle(color: Colors.grey)),
          ),
          Expanded(child: Divider(color: Colors.grey.shade300)),
        ],
      ),

      const SizedBox(height: 16),

      // UPI ID field
      const Text(
        "Enter UPI ID",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: upiController,
              decoration: InputDecoration(
                hintText: "name@upi",
                prefixIcon: const Icon(Icons.account_balance_wallet),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: (upiController.text.contains('@'))
                ? () {
                    /* verify */
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: (upiController.text.contains('@'))
                  ? Colors.orange
                  : Colors.grey,
            ),
            child: const Text("Verify"),
          ),
        ],
      ),
    ];
  }

  Widget buildUpiAppButton({
    required String logoUrl,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade50 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Image.network(logoUrl, fit: BoxFit.contain),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.orange : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canProceed() {
    switch (selectedPaymentType) {
      case "Debit / Credit Card":
        return cardNumberController.text.isNotEmpty &&
            cvvController.text.isNotEmpty &&
            validThruController.text.isNotEmpty &&
            fullNameController.text.isNotEmpty;
      case "Net Banking":
        return selectedBank != null;
      case "UPI":
        return selectedApp != null || upiController.text.isNotEmpty;
      default:
        return false;
    }
  }

  String _getSelectedPaymentText() {
    switch (selectedPaymentType) {
      case "Debit / Credit Card":
        return "Card ending ${cardNumberController.text.length >= 4 ? cardNumberController.text.substring(cardNumberController.text.length - 4) : 'XXXX'}";
      case "Net Banking":
        return selectedBank ?? "Net Banking";
      case "UPI":
        return selectedApp ?? upiController.text.split('@')[0];
      default:
        return selectedPaymentType ?? "";
    }
  }

  String _getSelectedPaymentIcon() {
    switch (selectedPaymentType) {
      case "Debit / Credit Card":
        return "card";
      case "Net Banking":
        return "bank";
      case "UPI":
        return "upi";
      default:
        return "payment";
    }
  }
}
