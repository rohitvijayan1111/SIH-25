import 'dart:io';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';

class CreateProcurementScreen extends StatefulWidget {
  const CreateProcurementScreen({super.key});

  @override
  State<CreateProcurementScreen> createState() =>
      _CreateProcurementScreenState();
}

class _CreateProcurementScreenState extends State<CreateProcurementScreen> {
  bool sameAsFarmer = false;

  // Controllers for input fields
  final TextEditingController farmerNameCtrl = TextEditingController();
  final TextEditingController farmerPhoneCtrl = TextEditingController();
  final TextEditingController cropNameCtrl = TextEditingController();
  final TextEditingController varietyNameCtrl = TextEditingController();
  final TextEditingController deliveryNameCtrl = TextEditingController();
  final TextEditingController deliveryPhoneCtrl = TextEditingController();
  final TextEditingController tractorNoCtrl = TextEditingController();

  File? cropImage;
  File? tractorImage;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(bool isCrop) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery); // or camera
    if (pickedFile != null) {
      setState(() {
        if (isCrop) {
          cropImage = File(pickedFile.path);
        } else {
          tractorImage = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
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
                    const Text(
                      "Add New Procurement",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),

              // Scrollable form
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Farmer Details",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      inputField(controller: farmerNameCtrl, label: "Farmer Name"),
                      inputField(controller: farmerPhoneCtrl, label: "Phone No."),

                      const SizedBox(height: 12),
                      const Text("Crop Details",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      inputField(controller: cropNameCtrl, label: "Crop Name"),
                      inputField(controller: varietyNameCtrl, label: "Variety Name"),

                      const SizedBox(height: 8),
                      const Text("Upload or Click Crop Photo",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => pickImage(true),
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: cropImage == null
                              ? const Center(child: Icon(Icons.camera_alt, size: 36))
                              : Image.file(cropImage!, fit: BoxFit.cover),
                        ),
                      ),

                      const SizedBox(height: 12),
                      const Text("Delivery Person Details",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),

                      if (!sameAsFarmer) ...[
                        inputField(controller: deliveryNameCtrl, label: "Name"),
                        inputField(controller: deliveryPhoneCtrl, label: "Mobile No."),
                        inputField(controller: tractorNoCtrl, label: "Tractor No."),

                        const SizedBox(height: 8),
                        const Text("Upload or Click Tractor Photo",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () => pickImage(false),
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: tractorImage == null
                                ? const Center(child: Icon(Icons.camera_alt, size: 36))
                                : Image.file(tractorImage!, fit: BoxFit.cover),
                          ),
                        ),
                      ],
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Save Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: const Color(0xFFecfcf4),
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B9846),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  final data = {
                    "farmerName": farmerNameCtrl.text,
                    "farmerPhone": farmerPhoneCtrl.text,
                    "cropName": cropNameCtrl.text,
                    "varietyName": varietyNameCtrl.text,
                    "deliveryName": deliveryNameCtrl.text,
                    "deliveryPhone": deliveryPhoneCtrl.text,
                    "tractorNo": tractorNoCtrl.text,
                    "cropImage": cropImage?.path,
                    "tractorImage": tractorImage?.path,
                  };
                  Navigator.pop(context, data); // send back to ProcurementsScreen
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputField(
      {required TextEditingController controller, String label = ""}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFD9D9D9), width: 2),
          ),
        ),
      ),
    );
  }
}
