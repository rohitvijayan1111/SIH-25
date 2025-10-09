import 'package:flutter/material.dart';

class BatchDetailsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(title: (const Text("Batch Details"))),
      body: SafeArea(
        child: Column(
          children: [
            // const Center(child: const Text("This is the new Screen")),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: const BoxDecoration(color: Colors.green),
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    onTap: () {
                      Navigator.of(context).maybePop();
                    },
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Batch Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [BoxShadow(color: Color(0x14000000))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(),
                                  color: Colors.grey[600],
                                ),
                                child: const Text(
                                  '🌱',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Batch #B-2024-001',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Organic Certification',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          _InfoItem(label: "Farmer Name:", value: "Raj Kumar"),
                          _InfoItem(
                            label: "Date Created:",
                            value: "March 15,2025",
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Status',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF69707A),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4E9B3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                child: Text(
                                  "Pending",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFD7A700),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 32),
                          Text(
                            'Attached Certificates',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF243528),
                            ),
                          ),

                          SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 22,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F6F7),
                            ),
                            child: const Center(
                              child: Text(
                                'No certificates attached yet',
                                style: TextStyle(
                                  color: Color(0xFFABABAB),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF44B564),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                "+ Attach Certificates",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  _InfoItem({required this.label, required this.value});

  Widget build(BuildContext contex) {
    return (Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: (Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Color(0xFF69707A)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF1D3020),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      )),
    ));
  }
}
