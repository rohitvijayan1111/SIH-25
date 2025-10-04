import 'package:flutter/material.dart';

class FarmerProfileScreen extends StatelessWidget {
  const FarmerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Farmer Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 76, 175, 80),
                Color(0xFF66BB6A),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(64, 76, 175, 80),
                blurRadius: 0,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          "assets/CustomerUIAssets/images/Farmer_image.png",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Rajesh Kumar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                  size: 18,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Age 45 · Khora Village",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "Member since March 2022",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const _SectionHeader(title: "Overview"),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  _StatCard(
                    title: "Total Contribution",
                    value: "₹45,230",
                    subText: "+12%",
                    icon: Icons.savings_outlined,
                    iconColor: Colors.orange,
                  ),
                  _StatCard(
                    title: "Active Batches",
                    value: "23",
                    subText: "+8%",
                    icon: Icons.inventory_outlined,
                    iconColor: Colors.blue,
                  ),
                  _StatCard(
                    title: "Quality Score",
                    value: "4.8",
                    subText: "★",
                    icon: Icons.star,
                    iconColor: Colors.amber,
                  ),
                  _StatCard(
                    title: "Earnings This Month",
                    value: "₹8,940",
                    subText: "+15%",
                    icon: Icons.attach_money,
                    iconColor: Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const _SectionHeader(title: "Recent Contributions", action: "View All"),
            const SizedBox(height: 12),
            const _ContributionTile(
              image: "assets/CustomerUIAssets/images/Wheat.png",
              title: "Wheat - Grade A",
              quantity: "250 kg delivered",
              status: "Approved",
              statusColor: Colors.green,
              rating: 5.0,
              time: "2 days ago",
            ),
            const _ContributionTile(
              image: "assets/CustomerUIAssets/images/Rice.png",
              title: "Rice - Premium",
              quantity: "180 kg delivered",
              status: "Processing",
              statusColor: Colors.orange,
              rating: 4.2,
              time: "5 days ago",
            ),
            const SizedBox(height: 20),
            const _SectionHeader(title: "Performance Overview"),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _PerformanceStat(title: "Contribution", value: "85%"),
                    _PerformanceStat(title: "Quality", value: "92%"),
                    _PerformanceStat(title: "Timeliness", value: "78%"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const _SectionHeader(title: "Recent Activity"),
            const SizedBox(height: 12),
            const _ActivityTile(
              icon: Icons.upload,
              title: "Uploaded wheat batch",
              subtitle: "2 hours ago",
              iconColor: Colors.green,
            ),
            const _ActivityTile(
              icon: Icons.currency_rupee,
              title: "Payment received ₹2,450",
              subtitle: "1 day ago",
              iconColor: Colors.blue,
            ),
            const _ActivityTile(
              icon: Icons.verified,
              title: "Quality certification updated",
              subtitle: "3 days ago",
              iconColor: Colors.orange,
            ),
            const SizedBox(height: 20),
            const _SectionHeader(title: "Documents"),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 12,
                children: const [
                  _DocumentTile(
                    icon: Icons.description,
                    label: "Land Papers",
                    status: "Verified",
                    color: Colors.blue,
                  ),
                  _DocumentTile(
                    icon: Icons.eco,
                    label: "Organic Cert",
                    status: "Verified",
                    color: Colors.green,
                  ),
                  _DocumentTile(
                    icon: Icons.badge,
                    label: "Govt ID",
                    status: "Verified",
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 76, 175, 80),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("View Full History"),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

//...The rest of your stateless widget classes remain unchanged as below.

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  const _SectionHeader({required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          if (action != null)
            Text(
              action!,
              style: const TextStyle(color: Colors.green, fontSize: 12),
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
      width: (MediaQuery.of(context).size.width - 40) / 2,
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
                radius: 16,
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const Spacer(),
              Text(
                subText,
                style: TextStyle(color: iconColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}

class _ContributionTile extends StatelessWidget {
  final String image;
  final String title;
  final String quantity;
  final String status;
  final Color statusColor;
  final double rating;
  final String time;

  const _ContributionTile({
    required this.image,
    required this.title,
    required this.quantity,
    required this.status,
    required this.statusColor,
    required this.rating,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(quantity, style: const TextStyle(fontSize: 12)),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 14),
              Text(
                rating.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _PerformanceStat extends StatelessWidget {
  final String title;
  final String value;
  const _PerformanceStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const _ActivityTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String status;
  final Color color;

  const _DocumentTile({
    required this.icon,
    required this.label,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 3,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
