import 'package:flutter/material.dart';
import 'new_coops_screen.dart';
import 'coop_dashboard.dart';

const Color themeColor = Color.fromARGB(255, 76, 175, 80);

class MyCoopsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
    'My Co-ops',
    style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 22,
      fontWeight: FontWeight.bold, // Bold text
      color: Colors.white,         // White color
    ),
    textAlign: TextAlign.center,   // Center align inside its box
  ),
        actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
      ),
      body: ListView(
        children: [
          CoopTile(
            title: 'Green Valley Co-op',
            description: 'Sustainable farming practices for a greener tomorrow',
            members: 124,
            icon: Icons.eco,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
          ),
          CoopTile(
            title: 'Agri Co-op',
            description: 'Traditional agriculture with modern techniques',
            members: 89,
            icon: Icons.spa,
            onTap: () {}, // No navigation or action
          ),
          CoopTile(
            title: 'FreshHarvest Co-op',
            description: 'Farm-to-table fresh produce community',
            members: 156,
            icon: Icons.local_grocery_store,
            onTap: () {},
          ),
          CoopTile(
            title: 'Village Unity Co-op',
            description: 'Building stronger rural communities together',
            members: 203,
            icon: Icons.home_work,
            onTap: () {},
          ),
          CoopTile(
            title: 'EcoFarmers Co-op',
            description: 'Organic farming for environmental sustainability',
            members: 97,
            icon: Icons.agriculture,
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewCoopScreen()),
          );
        },
        backgroundColor: themeColor,
        child: Icon(Icons.add),
      ),
    );
  }
}

class CoopTile extends StatelessWidget {
  final String title, description;
  final int members;
  final IconData icon;
  final VoidCallback onTap;

  CoopTile({
    required this.title,
    required this.description,
    required this.members,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: themeColor.withOpacity(0.2),
        child: Icon(icon, color: themeColor),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          SizedBox(height: 4),
          Text(
            '$members members',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
