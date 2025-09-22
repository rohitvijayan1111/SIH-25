import 'package:demo/screens/CustomerScreens/agent.dart'; // make sure the path is correct
import 'package:flutter/material.dart';

class UploadProduceScreen extends StatelessWidget {
  const UploadProduceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header with mic button
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context); // Navigate back
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Expanded(
                    child: Text(
                      "Upload Produce",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // ✅ Round mic button
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.withOpacity(0.1),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.mic, color: Colors.green),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AgentsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Upload Box
              GestureDetector(
                onTap: () {
                  // TODO: Implement camera or gallery picker
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade100),
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.camera_alt, color: Colors.green, size: 36),
                      SizedBox(height: 8),
                      Text(
                        "Tap to capture or pick photo\nYour crop photo is required",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Crop Type Dropdown
              _LabeledField(
                label: "Crop Type",
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: const [
                    DropdownMenuItem(value: "Rice", child: Text("Rice")),
                    DropdownMenuItem(value: "Wheat", child: Text("Wheat")),
                    DropdownMenuItem(value: "Tomato", child: Text("Tomato")),
                  ],
                  onChanged: (val) {},
                ),
              ),
              const SizedBox(height: 16),

              /// Quantity
              _LabeledField(
                label: "Quantity",
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter quantity",
                    suffixText: "kg",
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Quality Grade
              _LabeledField(
                label: "Quality Grade",
                child: Row(
                  children: List.generate(
                    5,
                    (index) =>
                        const Icon(Icons.star, color: Colors.amber, size: 28),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Harvest Date
              _LabeledField(
                label: "Harvest Date",
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "mm/dd/yyyy",
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// GPS Location
              _LabeledField(
                label: "GPS Location",
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    border: Border.all(color: Colors.green.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Auto-detected\nFarm location, Dhaka",
                          style: TextStyle(color: Colors.black87, fontSize: 13),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green[100],
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Optional Notes
              _LabeledField(
                label: "Optional Notes",
                child: TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add any additional information...",
                  ),
                ),
              ),
              const SizedBox(height: 24),

              /// Recent Uploads
              const Text(
                "Recent Uploads",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              const _UploadTile(
                image: "assets/CustomerUIAssets/images/Rice.png",
                title: "Rice - 50kg",
                time: "2 hours ago",
                status: "Pending",
                statusColor: Colors.orange,
              ),
              const _UploadTile(
                image: "assets/CustomerUIAssets/images/tomato.jpg",
                title: "Tomato - 25kg",
                time: "1 day ago",
                status: "Verified",
                statusColor: Colors.green,
              ),
              const _UploadTile(
                image: "assets/CustomerUIAssets/images/Wheat.png",
                title: "Wheat - 75kg",
                time: "3 days ago",
                status: "Review",
                statusColor: Colors.blue,
              ),
              const SizedBox(height: 24),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Add upload functionality
                  },
                  child: const Text(
                    "+ Add Produce",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  onPressed: () {
                    // TODO: Save draft functionality
                  },
                  child: const Text("Save as Draft"),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

/// --- Helper Widgets ---
class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _UploadTile extends StatelessWidget {
  final String image;
  final String title;
  final String time;
  final String status;
  final Color statusColor;

  const _UploadTile({
    required this.image,
    required this.title,
    required this.time,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
