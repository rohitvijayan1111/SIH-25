import 'package:flutter/material.dart';

class BatchModel {
  final String imagePath;
  final String title;
  final String batchID;
  final String harvestDate;
  final String quantity;
  final String farmer;
  final String price;
  final bool verified;
  final bool needsVerification;

  BatchModel({
    required this.imagePath,
    required this.title,
    required this.batchID,
    required this.harvestDate,
    required this.quantity,
    required this.farmer,
    required this.price,
    required this.verified,
    required this.needsVerification,
  });
}

class BundleCreationScreen extends StatefulWidget {
  const BundleCreationScreen({super.key});

  @override
  State<BundleCreationScreen> createState() => _BundleCreationScreenState();
}

class _BundleCreationScreenState extends State<BundleCreationScreen> {
  final List<BatchModel> _batches = [
    BatchModel(
      imagePath: "assets/FarmerUIAssets/images/premium-basmati-rice.jpg",
      title: "Premium Basmati Rice",
      batchID: "#R001",
      harvestDate: "Dec 15, 2024",
      quantity: "50kg",
      farmer: "Rajesh Kumar",
      price: "₹2,500",
      verified: true,
      needsVerification: false,
    ),
    BatchModel(
      imagePath: "assets/FarmerUIAssets/images/organic-basmati-rice.jpg",
      title: "Organic Basmati Rice",
      batchID: "#R002",
      harvestDate: "Dec 14, 2024",
      quantity: "75kg",
      farmer: "Priya Sharma",
      price: "₹3,750",
      verified: true,
      needsVerification: false,
    ),
    BatchModel(
      imagePath: "assets/FarmerUIAssets/images/traditional-basmati-rice.jpg",
      title: "Traditional Basmati Rice",
      batchID: "#R003",
      harvestDate: "Dec 13, 2024",
      quantity: "60kg",
      farmer: "Amit Singh",
      price: "₹3,000",
      verified: true,
      needsVerification: false,
    ),
    BatchModel(
      imagePath: "assets/FarmerUIAssets/images/long-grain-basmati-rice.jpeg",
      title: "Long Grain Rice",
      batchID: "#R004",
      harvestDate: "Dec 12, 2024",
      quantity: "40kg",
      farmer: "Sunita Devi",
      price: "₹2,000",
      verified: false,
      needsVerification: true,
    ),
  ];

  final List<int> _selected = [0, 1, 2]; // Default selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FFF6),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.home, color: Colors.grey),
              Icon(Icons.shopping_cart, color: Colors.green),
              Icon(Icons.person, color: Colors.grey),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Text(
                      "Create Bundle",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        "${_selected.length} selected",
                        style: const TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.close, color: Colors.grey, size: 18),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text("Rice"),
                      selected: true,
                      backgroundColor: Colors.green.shade50,
                      selectedColor: Colors.green,
                      onSelected: (v) {},
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text("This Week"),
                      selected: true,
                      backgroundColor: Colors.green.shade50,
                      selectedColor: Colors.green,
                      onSelected: (v) {},
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text("Grade A"),
                      selected: true,
                      backgroundColor: Colors.green.shade50,
                      selectedColor: Colors.green,
                      onSelected: (v) {},
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text("Verified"),
                      selected: true,
                      backgroundColor: Colors.green.shade50,
                      selectedColor: Colors.green,
                      onSelected: (v) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Toggle
              Row(
                children: [
                  const Text("Show eligible batches only",
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold)),
                  Switch(
                    value: true,
                    onChanged: (val) {},
                    activeColor: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Bundle Preview (Updated layout with images)
              _BundlePreview(
                batches: _batches,
              ),

              const SizedBox(height: 20),

              // Available Batches Label
              Row(
                children: [
                  Icon(Icons.layers, color: Colors.green),
                  const SizedBox(width: 6),
                  const Text("Available Batches",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                ],
              ),
              const SizedBox(height: 12),

              /// Batch Cards List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _batches.length,
                itemBuilder: (context, idx) {
                  final batch = _batches[idx];
                  final isSelected = _selected.contains(idx);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green.shade100,
                            blurRadius: 6,
                            spreadRadius: 2),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isSelected,
                          activeColor: Colors.green,
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                _selected.add(idx);
                              } else {
                                _selected.remove(idx);
                              }
                            });
                          },
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            batch.imagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(batch.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.green)),
                              const SizedBox(height: 2),
                              Text("Batch ID: ${batch.batchID}",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black54)),
                              Text("Harvested: ${batch.harvestDate}",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black54)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("${batch.quantity} available  ",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black87)),
                                  Expanded(
                                    child: Text(batch.farmer,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black87),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(batch.price,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.green)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  batch.verified
                                      ? const Icon(Icons.verified,
                                          color: Colors.green, size: 18)
                                      : Container(),
                                  batch.needsVerification
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 1),
                                          margin: const EdgeInsets.only(left: 4),
                                          decoration: BoxDecoration(
                                              color: Colors.yellow.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: const Text(
                                            "Needs Verification",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 11),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                          color: Colors.green,
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// Bottom Action Section
              const _BottomActionSection(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated Bundle Preview with image cards row and info cards below
class _BundlePreview extends StatelessWidget {
  final List<BatchModel> batches;
  const _BundlePreview({required this.batches, super.key});

  @override
  Widget build(BuildContext context) {
    // Limit to first 3 batches for preview
    final previewBatches = batches.take(3).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade100,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.layers, color: Colors.green),
              const SizedBox(width: 6),
              const Text(
                "Bundle Preview",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: previewBatches.map((batch) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          batch.imagePath,
                          height: 50,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${batch.title} \n${batch.quantity}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              _InfoCard(title: "185kg", subtitle: "Total Weight"),
              _InfoCard(title: "3", subtitle: "Farmers"),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              _InfoCard(title: "₹9,250", subtitle: "Bundle Price"),
              _InfoCard(title: "₹11,100", subtitle: "Retail Value"),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const _InfoCard({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.green)),
            const SizedBox(height: 2),
            Text(subtitle,
                style: const TextStyle(fontSize: 11, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

class _BottomActionSection extends StatelessWidget {
  const _BottomActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.green.shade100, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 48),
            ),
            icon: const Icon(Icons.layers, color: Colors.white),
            label: const Text("Merge & Create Bundle"),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: () {}, child: const Text("Save as Draft")),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {}, child: const Text("Preview QR & Label")),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            title: Row(
              children: [
                Icon(Icons.layers, color: Colors.green),
                const SizedBox(width: 6),
                const Text("Bundle Details",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ],
            ),
            children: const [
              SizedBox(height: 6),
              _BundleDetailsInput(),
            ],
          ),
        ],
      ),
    );
  }
}

class _BundleDetailsInput extends StatelessWidget {
  const _BundleDetailsInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Bundle Name"),
        const SizedBox(height: 4),
        TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Premium Basmati Mix - Dec 2024'),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text("Weight (kg)"),
                  const SizedBox(height: 4),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: '185'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  const Text("Price (₹)"),
                  const SizedBox(height: 4),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: '9250'),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text("Packaging Type"),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: "Jute Sack",
          items: const [
            DropdownMenuItem(value: "Jute Sack", child: Text("Jute Sack")),
            DropdownMenuItem(value: "Plastic Bag", child: Text("Plastic Bag")),
            DropdownMenuItem(value: "Carton", child: Text("Carton")),
          ],
          onChanged: (val) {},
        ),
        const SizedBox(height: 12),
        CheckboxListTile(
          value: false,
          onChanged: (v) {},
          title: const Text("List on ONDC"),
          activeColor: Colors.green,
        ),
        CheckboxListTile(
          value: true,
          onChanged: (v) {},
          title: const Text("Dispatch to Distributor",
              style: TextStyle(color: Colors.blue)),
          activeColor: Colors.green,
        ),
        CheckboxListTile(
          value: false,
          onChanged: (v) {},
          title: const Text("Mark for Wholesale"),
          activeColor: Colors.green,
        ),
      ],
    );
  }
}
