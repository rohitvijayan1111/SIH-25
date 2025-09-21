import 'package:flutter/material.dart';

class CooperativeMembersScreen extends StatelessWidget {
  const CooperativeMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> members = [
      {
        "name": "Rajesh Kumar",
        "village": "Khorda Village",
        "amount": "₹2,340",
        "progress": 0.8,
        "crops": ["Wheat", "Corn"],
        "image": "assets/CustomerUIAssets/images/John.png", // TODO: Replace with asset
        "badge": "Top Contributor"
      },
      {
        "name": "Priya Sharma",
        "village": "Manpur Village",
        "amount": "₹3,120",
        "progress": 0.9,
        "crops": ["Tomato", "Cucumber"],
        "image": "assets/CustomerUIAssets/images/Sarah.png",
        "badge": "Most Active"
      },
      {
        "name": "Amit Patel",
        "village": "Ramnagar Village",
        "amount": "₹1,850",
        "progress": 0.6,
        "crops": ["Rice", "Carrot"],
        "image": "assets/CustomerUIAssets/images/David.png",
        "badge": "New Member"
      },
      {
        "name": "Sunita Devi",
        "village": "Rampur Village",
        "amount": "₹2,480",
        "progress": 1.0,
        "crops": ["Spinach", "Onion"],
        "image": "assets/CustomerUIAssets/images/Sunita.png",
        "badge": "Active"
      },
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
          title: const Text(
            "Cooperative Members",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),

        body: Column(
          children: [
            /// Search
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search farmers...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            /// Active Farmers count + filter tags
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text("247 Active Farmers",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  _buildChip("Top Contributor", Colors.green),
                  const SizedBox(width: 6),
                  _buildChip("Most Active", Colors.blue),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Tabs (All, Active, Top Contributors, New)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildTab("All", true),
                  _buildTab("Active", false),
                  _buildTab("Top Contributors", false),
                  _buildTab("New", false),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Sort by Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Text("Sort by:",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(width: 8),
                  Text("Name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Spacer(),
                  Icon(Icons.swap_vert, size: 16),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Members List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return _MemberCard(member: member);
                },
              ),
            ),
          ],
        ),

        /// Floating Button
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {},
          child: const Icon(Icons.add, color: Colors.white),
        ),

        /// Bottom Bar
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
            color: Colors.white,
          ),
          child: Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sms, color: Colors.green),
                label: const Text("Invite via SMS",
                    style: TextStyle(color: Colors.green)),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text("Export List",
                    style: TextStyle(color: Colors.black87)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 11)),
    );
  }

  Widget _buildTab(String text, bool active) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Colors.green : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// ---- Member Card Widget ----
class _MemberCard extends StatelessWidget {
  final Map<String, dynamic> member;

  const _MemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 6, spreadRadius: 2)
        ],
      ),
      child: Row(
        children: [
          /// Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(member["image"]),
            // TODO: Replace with static asset
          ),
          const SizedBox(width: 12),

          /// Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member["name"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(member["village"],
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Text("Monthly Contribution",
                    style:
                        TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: member["progress"],
                        color: Colors.green,
                        backgroundColor: Colors.grey.shade200,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(member["amount"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: (member["crops"] as List<String>).map((crop) {
                    return Chip(
                      label: Text(crop, style: const TextStyle(fontSize: 11)),
                      backgroundColor: Colors.green.withOpacity(0.1),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          /// Favorite / More icon
          IconButton(
            icon: const Icon(Icons.more_vert, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
