import 'package:demo/screens/payment_details.dart'; // ✅ Import your payment details screen
import 'package:flutter/material.dart';

class LogisticsDetailsPage extends StatefulWidget {
  const LogisticsDetailsPage({super.key});

  @override
  State<LogisticsDetailsPage> createState() => _LogisticsDetailsPageState();
}

class _LogisticsDetailsPageState extends State<LogisticsDetailsPage> {
  String selectedDelivery = "Standard Delivery";
  String? selectedDate;
  String selectedTimeSlot = "12:00 - 15:00";

  // 🔹 Delivery charges based on option
  double get deliveryCharge {
    switch (selectedDelivery) {
      case "Express Delivery":
        return 12.99;
      case "Same-Day Delivery":
        return 19.99;
      default:
        return 5.99;
    }
  }

  // 🔹 Example: base product price
  final double productPrice = 24.99;

  double get totalAmount => productPrice + deliveryCharge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logistics Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Change Address clicked")),
                    );
                  },
                  child: const Text("Change"),
                ),
              ],
            ),
            const Text("John Anderson"),
            const Text("1234 Oak Street, Apt 5B"),
            const Text("San Francisco, CA 94012"),
            const Text("+1 (555) 123-4567"),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Add New Address clicked")),
                );
              },
              child: const Text("Add New Address"),
            ),
            const Divider(height: 30),

            // Delivery Options
            const Text(
              "Delivery Options",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            deliveryOption("Standard Delivery", "3-5 business days", 5.99),
            deliveryOption("Express Delivery", "1-2 business days", 12.99),
            deliveryOption("Same-Day Delivery", "Within 4-6 hours", 19.99),
            const Divider(height: 30),

            // Schedule Delivery
            const Text(
              "Schedule Delivery",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: selectedDate ?? "Select Date",
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate =
                        "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                  });
                }
              },
            ),
            if (selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text("Selected Date: $selectedDate",
                    style: const TextStyle(color: Colors.green)),
              ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                timeSlotButton("9:00 - 12:00"),
                timeSlotButton("12:00 - 15:00"),
                timeSlotButton("15:00 - 18:00"),
                timeSlotButton("18:00 - 21:00"),
              ],
            ),
            const Divider(height: 30),

            // Order Summary
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Premium Organic Apples"),
            const Text("Batch No: BA2024001"),
            const Text("Qty: 5 Kg"),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Product Price"),
                Text("\$${productPrice.toStringAsFixed(2)}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Delivery Charge"),
                Text("\$${deliveryCharge.toStringAsFixed(2)}"),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "\$${totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Proceed Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  // Navigate to PaymentDetailsScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentDetailsScreen(
                        paymentDetails: {
                          "totalAmount": totalAmount,
                          "paidAmount": 0,
                          "dueAmount": totalAmount,
                          "transactions": [],
                        },
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget deliveryOption(String title, String subtitle, double price) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedDelivery = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
              color: selectedDelivery == title ? Colors.green : Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              title.contains("Standard")
                  ? Icons.local_shipping
                  : title.contains("Express")
                      ? Icons.local_shipping_outlined
                      : Icons.flash_on,
              color: Colors.blue,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Text("\$${price.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }

  Widget timeSlotButton(String slot) {
    return ChoiceChip(
      label: Text(slot),
      selected: selectedTimeSlot == slot,
      onSelected: (value) {
        setState(() {
          selectedTimeSlot = slot;
        });
      },
    );
  }
}
