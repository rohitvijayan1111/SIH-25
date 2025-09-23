import 'package:flutter/material.dart';
import './upload_produce_coop.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Container(
                color: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      iconSize: 20, // Smaller icon to fit height
                      padding:
                          EdgeInsets.zero, // Remove default internal padding
                      constraints:
                          BoxConstraints(), // Remove min size constraints
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 4),

                    /// App Logo
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.green[100],
                      child: const Icon(Icons.eco, color: Colors.green),
                      // TODO: Replace with your asset image
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Green Valley Co-op",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "248 Members · \$125,400 Pooled",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    /// Top Icons
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_outlined),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.settings_outlined),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Tabs (Dashboard, Farmers, Produce, Financials)
              Container(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: const [
                    _TabItem(title: "Dashboard", isActive: true),
                    _TabItem(title: "Farmers"),
                    _TabItem(title: "Produce"),
                    _TabItem(title: "Financials"),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// Stats Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: const [
                    _StatCard(
                      title: "Total Produce (kg)",
                      value: "24.5K",
                      subText: "+12%",
                      icon: Icons.inventory_2_outlined,
                      iconColor: Colors.green,
                    ),
                    _StatCard(
                      title: "Active Farmers",
                      value: "248",
                      subText: "+8",
                      icon: Icons.people_alt_outlined,
                      iconColor: Colors.blue,
                    ),
                    _StatCard(
                      title: "Revenue This Month",
                      value: "\$89.2K",
                      subText: "+24%",
                      icon: Icons.attach_money,
                      iconColor: Colors.orange,
                    ),
                    _StatCard(
                      title: "Pending Orders",
                      value: "34",
                      subText: "12",
                      icon: Icons.pending_actions,
                      iconColor: Colors.deepOrange,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Quick Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Quick Actions",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _QuickActionButton(
                          label: 'Scan QR',
                          color: Colors.teal.shade600, // Rich teal
                          icon: Icons.qr_code_scanner,
                        ),
                        //
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).push(
                        //       MaterialPageRoute(
                        //         builder: (_) => UploadProduceScreen(),
                        //       ),
                        //     );
                        //   },
                        //   child: _QuickActionButton(
                        //     label: 'Add Batch',
                        //     color: Colors.teal.shade300,
                        //     icon: Icons.add_box_outlined,
                        //   ),
                        // ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => UploadProduceScreen(),
                                ),
                              );
                            },
                            child: _QuickActionButton(
                              label: 'Add Batch',
                              color: Colors.teal.shade300,
                              icon: Icons.add_box_outlined,
                            ),
                          ),
                        ),
                        _QuickActionButton(
                          label: 'Export',
                          color: Colors.amber.shade600, // Warm amber
                          icon: Icons.upload_file,
                        ),
                        _QuickActionButton(
                          label: 'Add Farmer',
                          color: Colors.deepPurple.shade400, // Subtle purple
                          icon: Icons.person_add_alt,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Farmer Locations
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Farmer Locations",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                        image: const DecorationImage(
                          image: AssetImage(
                            "assets/CustomerUIAssets/images/Farmer_location.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "248 Active Locations\nTap to view details",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Recent Activity
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recent Activity",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _ActivityTile(
                      name: "John Martinez uploaded 150kg tomatoes",
                      time: "2 hours ago · Grade A · Verified",
                      imagePath:
                          "assets/CustomerUIAssets/images/John.png", // 👉 Replace with John's image
                    ),
                    _ActivityTile(
                      name: "Sarah Chen sold batch #BC-2024-001",
                      time: "4 hours ago · \$2,400 · Completed",
                      imagePath:
                          "assets/CustomerUIAssets/images/Sarah.png", // 👉 Replace with Sarah's image
                    ),
                    _ActivityTile(
                      name: "David Kim joined the cooperative",
                      time: "1 day ago · Verification pending",
                      imagePath:
                          "assets/CustomerUIAssets/images/David.png", // 👉 Replace with David's image
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80), // space for bottom nav
            ],
          ),
        ),
      ),
    );
  }
}

/// ---- Widgets ----

class _TabItem extends StatelessWidget {
  final String title;
  final bool isActive;
  const _TabItem({required this.title, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.green : Colors.grey[600],
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 20,
              color: Colors.green,
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subText;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subText,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 36) / 2,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor),
              ),
              const Spacer(),
              Text(
                subText,
                style: TextStyle(color: iconColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _QuickActionButton({
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 48) / 2,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, color: color),
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String name;
  final String time;
  final String imagePath; // 👉 now using image instead of icon

  const _ActivityTile({
    required this.name,
    required this.time,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath), // 👉 load static image
      ),
      title: Text(name, style: const TextStyle(fontSize: 14)),
      subtitle: Text(
        time,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
    );
  }
}
