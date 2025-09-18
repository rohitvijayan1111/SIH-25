import 'package:flutter/material.dart';

class ProcurementDetails extends StatelessWidget {
  const ProcurementDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final double windowHeight = MediaQuery.of(context).size.height;

    // Dummy procurement data (replace with your model or API data)
    final Map<String, dynamic> item = {
      "date": "05/03/2024",
      "farmerName": "Sunita Singh",
      "farmerMobile": "8493021573",
      "cropName": "Wheat",
      "variety": "High Yield",
      "cropPhoto": "assets/images/crop.png",
      "deliveryPersonName": "Ramesh Kumar",
      "deliveryPersonMobile": "9876543210",
      "tractorNo": "TN-12-3456",
      "vehiclePhoto": "assets/images/tractor.png",
    };

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                color: const Color(0xFFB2FFB7),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 24),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      item['farmerName'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),

              // Main card
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date & Edit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Date: ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(item['date'],
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF2B9846)),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2B9846),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),

                    const Divider(thickness: 1, color: Colors.grey),

                    // Farmer Details
                    const Text(
                      "Farmer Details",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    infoRow("Farmer Name", item['farmerName']),
                    infoRow("Farmer No.", item['farmerMobile']),
                    infoRow("Crop Name", item['cropName']),

                    const Divider(thickness: 1, color: Colors.grey),

                    // Crop Details
                    const Text(
                      "Crop Details",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    infoRow("Crop Name", item['cropName']),
                    infoRow("Variety", item['variety']),
                    const Text(
                      "Crop Photo",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Image.asset(
                      item['cropPhoto'],
                      height: windowHeight * 0.25,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),

                    const Divider(thickness: 1, color: Colors.grey),

                    // Delivery Person
                    const Text(
                      "Delivery Person Details",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    infoRow("Delivery Person Name", item['deliveryPersonName']),
                    infoRow(
                        "Delivery Person Mobile", item['deliveryPersonMobile']),
                    infoRow("Vehicle No.", item['tractorNo']),

                    const Text(
                      "Vehicle Photo",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Image.asset(
                      item['vehiclePhoto'],
                      height: windowHeight * 0.25,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              // Complete Button
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B9846),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Complete the form",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Info Row
  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
