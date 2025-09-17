<<<<<<< HEAD
// TODO Implement this library.
import 'package:flutter/material.dart';

class CompletedProcurementDetails extends StatefulWidget {
  const CompletedProcurementDetails({super.key});
=======
import 'package:flutter/material.dart';

class CompletedProcurementDetails extends StatefulWidget {
  final bool isEmbedded; // control if used inside tab or standalone

  const CompletedProcurementDetails({super.key, this.isEmbedded = true});
>>>>>>> 89f70c0f0ca5889202553f4504723363d59b1deb

  @override
  State<CompletedProcurementDetails> createState() =>
      _CompletedProcurementDetailsState();
}

class _CompletedProcurementDetailsState
    extends State<CompletedProcurementDetails> {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Page')),
      body: const Center(
        child: Text('This is the Voice Page', style: TextStyle(fontSize: 18)),
      ),
    );
  }
=======
  late Map<String, dynamic> completedProcurementData;

  @override
  void initState() {
    super.initState();
    completedProcurementData = {
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
        "cropPhoto": "https://picsum.photos/400/250?crop",
      },
      "receiptPhoto": "receipt_placeholder.jpg",
      "deliveryPersonDetails": {
        "name": "Sunita Singh",
        "mobNo": "8493021573",
        "tractorNo": "UP32 XY 1234",
        "tractorPhoto": "https://picsum.photos/400/250?tractor",
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    final item = completedProcurementData;
    final windowHeight = MediaQuery.of(context).size.height;

    final content = SingleChildScrollView(
      child: Column(
        children: [
          // Header (only if not embedded)
          if (!widget.isEmbedded)
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
                      onPressed: () => editFarmerDetails(),
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
                buildDetailRow(
                    "Price per Quintal", item["cropDetails"]["pricePerQuintal"]),
                buildDetailRow(
                    "Total Amount", item["cropDetails"]["totalAmount"]),
                buildDetailRow(
                    "Payment Status", item["cropDetails"]["paymentStatus"]),

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
                buildDetailRow(
                    "Delivery Person Name", item["deliveryPersonDetails"]["name"]),
                buildDetailRow(
                    "Delivery Person Mobile", item["deliveryPersonDetails"]["mobNo"]),
                buildDetailRow(
                    "Vehicle No.", item["deliveryPersonDetails"]["tractorNo"]),

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

    return widget.isEmbedded ? content : SafeArea(child: Scaffold(body: content));
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

  void editFarmerDetails() {
    final farmer = completedProcurementData["farmerDetails"];
    final crop = completedProcurementData["cropDetails"];
    showDialog(
      context: context,
      builder: (_) {
        final nameController = TextEditingController(text: farmer["farmerName"]);
        final mobController = TextEditingController(text: farmer["mobNo"]);
        final addressController = TextEditingController(text: farmer["address"]);
        final cropNameController = TextEditingController(text: crop["cropName"]);
        final qtyController = TextEditingController(text: crop["quantity"]);
        return AlertDialog(
          title: const Text("Edit Details"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: "Farmer Name")),
                TextField(controller: mobController, decoration: const InputDecoration(labelText: "Farmer Mobile")),
                TextField(controller: addressController, decoration: const InputDecoration(labelText: "Address")),
                const SizedBox(height: 10),
                TextField(controller: cropNameController, decoration: const InputDecoration(labelText: "Crop Name")),
                TextField(controller: qtyController, decoration: const InputDecoration(labelText: "Quantity")),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  farmer["farmerName"] = nameController.text;
                  farmer["mobNo"] = mobController.text;
                  farmer["address"] = addressController.text;
                  crop["cropName"] = cropNameController.text;
                  crop["quantity"] = qtyController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
>>>>>>> 89f70c0f0ca5889202553f4504723363d59b1deb
}
