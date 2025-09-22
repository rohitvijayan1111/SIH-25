import 'package:flutter/material.dart';

class ProductHistoryPage extends StatefulWidget {
  const ProductHistoryPage({Key? key}) : super(key: key);

  @override
  State<ProductHistoryPage> createState() => _ProductHistoryPageState();
}

class _ProductHistoryPageState extends State<ProductHistoryPage> {
  // Track expansion for each section
  final Map<String, bool> expanded = {
    "origin": false,
    "processing": false,
    "handling": false,
    "current": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product History"),
        backgroundColor: Colors.green.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              // Add QR re-scan logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Product Info Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Tomato – Batch #12345",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 6),
                          Text("QR-ID: TOM-2025-12345",
                              style: TextStyle(color: Colors.grey)),
                          Text("Category: Vegetable",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Timeline Steps
            buildStepCard(
              title: "Origin / Farmer",
              subtitle: "Green Valley Farm, Punjab",
              date: "15 Dec 2025",
              icon: Icons.agriculture,
              chipColor: Colors.green,
              chipLabel: "Harvested",
              keyName: "origin",
              details: [
                "Farmer: Rajesh Kumar",
                "Soil Type: Alluvial",
                "Fertilizer: Organic compost",
                "Harvested on: 15 Dec 2025",
              ],
            ),

            buildStepCard(
              title: "Level 1 Processing",
              subtitle: "AgriCenter Delhi",
              date: "16 Dec 2025",
              icon: Icons.factory,
              chipColor: Colors.orange,
              chipLabel: "Processed",
              keyName: "processing",
              details: [
                "Washing Method: Hydro wash",
                "Sorting Grade: A",
                "Packaging: Eco-friendly crates",
              ],
            ),

            buildStepCard(
              title: "Level 2 Handling",
              subtitle: "Warehouse, Delhi",
              date: "18 Dec 2025",
              icon: Icons.local_shipping,
              chipColor: Colors.blue,
              chipLabel: "In Transit",
              keyName: "handling",
              details: [
                "Transport Mode: Refrigerated Truck",
                "Temperature Maintained: 5°C",
                "Arrival at Warehouse: 18 Dec 2025",
              ],
            ),

            buildStepCard(
              title: "Current State",
              subtitle: "Fresh Market, Mumbai",
              date: "20 Dec 2025",
              icon: Icons.store,
              chipColor: Colors.purple,
              chipLabel: "Available",
              keyName: "current",
              details: [
                "Shelf Location: Aisle 4, Section B",
                "Stock Left: 120 kg",
                "Best Before: 05 Jan 2026",
              ],
            ),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // download QR report logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 123, 217, 127),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.download),
              label: const Text("Download QR Report"),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget to build each step card with expandable details
  Widget buildStepCard({
    required String title,
    required String subtitle,
    required String date,
    required IconData icon,
    required Color chipColor,
    required String chipLabel,
    required String keyName,
    required List<String> details,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: chipColor.withOpacity(0.2),
                  child: Icon(icon, color: chipColor, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(subtitle,
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade600)),
                      Text(date,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade500)),
                    ],
                  ),
                ),
                Chip(
                  label: Text(chipLabel,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600)),
                  backgroundColor: chipColor.withOpacity(0.15),
                  labelStyle: TextStyle(color: chipColor),
                )
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  expanded[keyName] = !(expanded[keyName] ?? false);
                });
              },
              child: Text(
                expanded[keyName] == true ? "Hide Details ▲" : "View Details ▼",
                style: TextStyle(
                    color: chipColor, fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
            if (expanded[keyName] == true) ...[
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: details
                    .map((d) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle,
                                  color: Colors.green, size: 16),
                              const SizedBox(width: 6),
                              Expanded(
                                  child: Text(d,
                                      style: const TextStyle(fontSize: 13))),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
