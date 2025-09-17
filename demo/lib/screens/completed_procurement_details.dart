import 'package:flutter/material.dart';

class CompletedProcurementDetails extends StatelessWidget {
  final bool isEmbedded; // ✅ to control if used inside tab or standalone

  CompletedProcurementDetails({super.key, this.isEmbedded = true});

  // Dynamic content inside widget, cannot be const
  final Map<String, dynamic> completedProcurementData = {
    "date": "05/03/2024",
    "farmerDetails": {
      "farmerName": "Sunita Singh",
      "mobNo": "8493021573",
      "address": "Sector 14, Lucknow",
    },
    "cropDetails": {
      "batchNo": "#3942",
      "cropName": "Barley",
      "variety": "846251",
      "quantity": "282 Quintal",
      "pricePerQuintal": "85924",
      "totalAmount": "392801",
      "paymentStatus": "Completed",
      "cropPhoto": "https://picsum.photos/400/250?crop", // sample
    },
    "receiptPhoto": "receipt_placeholder.jpg",
    "deliveryPersonDetails": {
      "name": "Sunita Singh",
      "mobNo": "8493021573",
      "tractorNo": "UP32 XY 1234",
      "tractorPhoto": "https://picsum.photos/400/250?tractor", // sample
    },
  };

  @override
  Widget build(BuildContext context) {
    final item = completedProcurementData;
    final windowHeight = MediaQuery.of(context).size.height;

    final content = SingleChildScrollView(
      child: Column(
        children: [
          // Header (only if not embedded)
          if (!isEmbedded)
            Container(
              color: const Color(0xFFB2FFB7),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 24),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    item["farmerDetails"]["farmerName"],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),

          // Card Content
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date + Edit button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date: ${item["date"]}",
                        style: const TextStyle(color: Colors.grey)),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2B9846)),
                      ),
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2B9846)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Text("Farmer Details",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                buildDetailRow(
                    "Farmer Name", item["farmerDetails"]["farmerName"]),
                buildDetailRow("Farmer No.", item["farmerDetails"]["mobNo"]),
                buildDetailRow("Address", item["farmerDetails"]["address"]),
                divider(),

                const Text("Crop Details",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                buildDetailRow("Batch No.", item["cropDetails"]["batchNo"]),
                buildDetailRow("Crop Name", item["cropDetails"]["cropName"]),
                buildDetailRow("Variety", item["cropDetails"]["variety"]),
                buildDetailRow("Quantity", item["cropDetails"]["quantity"]),
                buildDetailRow("Price per Quintal",
                    item["cropDetails"]["pricePerQuintal"]),
                buildDetailRow(
                    "Total Amount", item["cropDetails"]["totalAmount"]),
                buildDetailRow("Payment Status",
                    item["cropDetails"]["paymentStatus"]),

                const SizedBox(height: 8),
                const Text("Crop Photo",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item["cropDetails"]["cropPhoto"],
                    height: windowHeight * 0.25,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                divider(),
                const Text("Delivery Person Details",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                buildDetailRow("Delivery Person Name",
                    item["deliveryPersonDetails"]["name"]),
                buildDetailRow("Delivery Person Mobile",
                    item["deliveryPersonDetails"]["mobNo"]),
                buildDetailRow("Vehicle No.",
                    item["deliveryPersonDetails"]["tractorNo"]),

                const SizedBox(height: 8),
                const Text("Vehicle Photo",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item["deliveryPersonDetails"]["tractorPhoto"],
                    height: windowHeight * 0.25,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),

          // Complete form button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B9846),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: const Center(
                child: Text(
                  "Complete the form",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ),
          )
        ],
      ),
    );

    // ✅ Use dynamic widget, no const
    return isEmbedded
        ? content
        : SafeArea(child: Scaffold(body: content));
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade300,
    );
  }
}
