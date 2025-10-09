import 'package:flutter/material.dart';

class AttachCertificatePage extends StatefulWidget {
  const AttachCertificatePage({Key? key}) : super(key: key);

  State<AttachCertificatePage> createState() => _AttachCertificatePageState();
}

class _AttachCertificatePageState extends State<AttachCertificatePage> {
  final TextEditingController issuerController = TextEditingController();
  final TextEditingController farmerController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  void dispose() {
    issuerController.dispose();
    linkController.dispose();
    farmerController.dispose();
    super.dispose();
  }

  void attachPressed() {}

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Attach Certificate"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(14),

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.green[100],
                    child: Icon(
                      Icons.verified_rounded,
                      color: Colors.green[600],
                      size: 42,
                    ),
                  ),
                  SizedBox(height: 12),
                  const Text(
                    "Attach Certificate",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),
                  const Text(
                    "Add the Details below",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),

                  SizedBox(height: 12),

                  // Text("Issuer Name"),
                  TextField(
                    controller: issuerController,
                    decoration: InputDecoration(
                      labelText: 'Issuer Name',
                      prefixIcon: Icon(Icons.business_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 14),
                  SizedBox(height: 14),
                  TextField(
                    controller: farmerController,
                    decoration: InputDecoration(
                      labelText: 'Farmer Name',
                      prefixIcon: Icon(Icons.person_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 14),
                  TextField(
                    controller: linkController,
                    decoration: InputDecoration(
                      labelText: 'Certificate Link',
                      prefixIcon: Icon(Icons.link_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.attachment_rounded),
                      label: const Text(
                        'Attach Certificate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      onPressed: () => {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        iconColor: Colors.white,

                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.blue[50],
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[700]),
                  SizedBox(width: 14),

                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                        children: [
                          TextSpan(
                            text: 'Certificate Requirements\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                          TextSpan(
                            text:
                                'Please ensure the certificate link is valid and accessible. The issuer name should match the official certification body.',
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Icon(Icons.info_outline),
                  // Text("Disclaimer"),

                  // Text(
                  //   "Disclaimer the data provided is to be verified to be legit and it cannor be chnages once it is submitted. So please Upload wiht care",
                  //   style: TextStyle(fontSize: 16),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
