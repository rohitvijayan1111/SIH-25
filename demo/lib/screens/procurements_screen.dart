<<<<<<< HEAD
// TODO Implement this library.
=======
import 'package:demo/screens/completed_procurement_details.dart';
>>>>>>> 89f70c0f0ca5889202553f4504723363d59b1deb
import 'package:flutter/material.dart';

class ProcurementsScreen extends StatefulWidget {
  const ProcurementsScreen({super.key});

  @override
  State<ProcurementsScreen> createState() => _ProcurementsScreenState();
}

class _ProcurementsScreenState extends State<ProcurementsScreen> {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Page')),
      body: const Center(
        child: Text('This is the Voice Page', style: TextStyle(fontSize: 18)),
=======
  String selectedTab = "progressing";
  String selectedDays = "Last 60 days";
  List<String> selectedCrops = ["Wheat"];
  List<String> selectedFarmers = ["Rahul Kumar"];

  bool isFilterModalOpen = false;
  bool isFarmerModalOpen = false;

  // dummy list like your data.procurementList
  final List<Map<String, dynamic>> procurementList = [
    {"id": 1, "name": "Wheat Procurement", "isCompleted": false},
    {"id": 2, "name": "Bajra Procurement", "isCompleted": true},
    {"id": 3, "name": "Sugarcane Procurement", "isCompleted": false},
  ];

  List<Map<String, dynamic>> get filteredList {
    return procurementList
        .where((item) =>
            item["isCompleted"] == (selectedTab == "completed" ? true : false))
        .toList();
  }

  void clearFilter() {
    setState(() {
      selectedDays = "";
      selectedCrops = [];
      selectedFarmers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Procurements"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Tabs
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => selectedTab = "progressing"),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTab == "progressing"
                              ? Colors.green
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      "Progressing",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedTab == "progressing"
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => selectedTab = "completed"),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTab == "completed"
                              ? Colors.green
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      "Completed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedTab == "completed"
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Search + Filter row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => isFarmerModalOpen = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Text("Search Farmers"),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => setState(() => isFilterModalOpen = true),
                  child: Row(
                    children: const [
                      Icon(Icons.filter_list, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("Filters", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // List Section
          Expanded(
  child: selectedTab == "completed"
      ? CompletedProcurementDetails(isEmbedded: true) // 👈 embed mode
      : ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            final item = filteredList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade200,
                  child: Text(item["id"].toString()),
                ),
                title: Text(item["name"]),
                subtitle:
                    Text(item["isCompleted"] ? "Completed" : "In Progress"),
              ),
            );
          },
        ),
),

        ],
      ),

      // Floating Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Navigate to Create Procurement")),
          );
        },
        child: const Icon(Icons.add, size: 30),
      ),

      // Modals
      bottomSheet: isFilterModalOpen
          ? _buildFilterModal(context)
          : isFarmerModalOpen
              ? _buildFarmerModal(context)
              : null,
    );
  }

  Widget _buildFilterModal(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 300,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Filters",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: ["Last 30 days", "Last 60 days", "Last 3 months"]
                .map((d) => ChoiceChip(
                      label: Text(d),
                      selected: selectedDays == d,
                      onSelected: (_) => setState(() => selectedDays = d),
                      selectedColor: Colors.green.shade100,
                    ))
                .toList(),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    clearFilter();
                    setState(() => isFilterModalOpen = false);
                  },
                  child: const Text("Clear"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () => setState(() => isFilterModalOpen = false),
                  child: const Text("Apply"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFarmerModal(BuildContext context) {
    final farmers = ["Rahul Kumar", "Sachin Kumar", "Rajat Kumar", "Suraj"];
    return Container(
      color: Colors.white,
      height: 300,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("Select Farmer",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: farmers.length,
              itemBuilder: (context, index) {
                final farmer = farmers[index];
                final isSelected = selectedFarmers.contains(farmer);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(farmer[0],
                        style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(farmer),
                  trailing: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: Colors.green,
                  ),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedFarmers.remove(farmer);
                      } else {
                        selectedFarmers.add(farmer);
                      }
                    });
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    clearFilter();
                    setState(() => isFarmerModalOpen = false);
                  },
                  child: const Text("Clear"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () => setState(() => isFarmerModalOpen = false),
                  child: const Text("Apply"),
                ),
              ),
            ],
          ),
        ],
>>>>>>> 89f70c0f0ca5889202553f4504723363d59b1deb
      ),
    );
  }
}
