// File: lib/screens/middleman/home_screen.dart
// Purpose: Main home screen with service cards for middleman dashboard

import 'package:flutter/material.dart';
import 'utils/constantdata.dart';
import './widgets/common/service_card.dart';
import './procurement/procurement_screen.dart';
import './dashboard/business_dashboard.dart';
import './dashboard/inventory_screen.dart';

class MiddlemanHomeScreen extends StatelessWidget {
  const MiddlemanHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning!',
              style: TextStyle(
                color: Colors.black87,
                fontSize: AppConstants.bodyFontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Middleman Dashboard',
              style: TextStyle(
                color: Colors.grey,
                fontSize: AppConstants.captionFontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle notifications
              _showNotifications(context);
            },
            icon: Stack(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.black87,
                  size: 24,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppConstants.errorRed,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.defaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats Section
            _buildQuickStats(context),

            const SizedBox(height: AppConstants.largePadding),

            // Main Service Cards
            ServiceCard(
              title: 'Upload Produce',
              subtitle: 'Everyday Essentials',
              icons: const [
                Icons.upload,
                Icons.local_shipping,
                Icons.inventory_2,
              ],
              rightText: 'No min. order value',
              gradient: AppConstants.purpleGradient,
              onTap: () {
                // Navigate to upload produce screen
                _showComingSoon(context, 'Upload Produce');
              },
            ),

            ServiceCard(
              title: 'Browse Products',
              subtitle: 'Fruits & Veggies',
              icons: const [Icons.circle, Icons.circle, Icons.circle],
              rightText: 'Lowest prices',
              gradient: AppConstants.blueGradient,
              onTap: () {
                // Navigate to browse products screen
                _showComingSoon(context, 'Browse Products');
              },
            ),

            ServiceCard(
              title: 'Farmer Services',
              subtitle: 'Lowest Prices Ever',
              icons: const [
                Icons.local_shipping,
                Icons.shopping_cart,
                Icons.diamond,
              ],
              rightText: 'Minimum order value ₹599',
              gradient: AppConstants.greenGradient,
              onTap: () {
                // Navigate to farmer services screen
                _showComingSoon(context, 'Farmer Services');
              },
            ),

            const SizedBox(height: AppConstants.largePadding),

            // Quick Actions Section
            _buildQuickActions(context),

            const SizedBox(height: AppConstants.largePadding),

            // Recent Activity Section
            _buildRecentActivity(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            'Active\\nProcurements',
            '8',
            Icons.assignment,
            AppConstants.primaryBlue,
          ),
          _buildStatItem(
            'Total\\nInventory',
            '2.4t',
            Icons.inventory_2,
            AppConstants.primaryGreen,
          ),
          _buildStatItem(
            'This Month\\nRevenue',
            '₹5.6L',
            Icons.trending_up,
            AppConstants.warningOrange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppConstants.subtitleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppConstants.captionFontSize - 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
          ),
          child: Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: AppConstants.subtitleFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
          ),
          child: Row(
            children: [
              _buildActionCard(
                'Create Procurement',
                Icons.add_shopping_cart,
                AppConstants.primaryBlue,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProcurementScreen(initialTab: 1),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _buildActionCard(
                'View Bids',
                Icons.gavel,
                AppConstants.primaryGreen,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProcurementScreen(initialTab: 2),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _buildActionCard(
                'Check Inventory',
                Icons.inventory_2,
                AppConstants.warningOrange,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InventoryScreen(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _buildActionCard(
                'Business Analytics',
                Icons.analytics,
                AppConstants.purple,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BusinessDashboard(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppConstants.captionFontSize,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: AppConstants.subtitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProcurementScreen(),
                    ),
                  );
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActivityItem(
                'New bid received for Tomatoes',
                'Raj Kumar - ₹22/kg',
                '2 hours ago',
                Icons.gavel,
                AppConstants.primaryGreen,
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Procurement completed',
                'Wheat - 300kg delivered',
                '1 day ago',
                Icons.check_circle,
                AppConstants.primaryBlue,
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Low stock alert',
                'Potatoes - Only 50kg remaining',
                '2 days ago',
                Icons.warning,
                AppConstants.warningOrange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    String title,
    String subtitle,
    String time,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppConstants.bodyFontSize - 1,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Text(
        time,
        style: TextStyle(
          fontSize: AppConstants.captionFontSize - 1,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: AppConstants.subtitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            ListTile(
              leading: const Icon(
                Icons.gavel,
                color: AppConstants.primaryGreen,
              ),
              title: const Text('New bid received'),
              subtitle: const Text('Raj Kumar bid ₹22/kg for tomatoes'),
              trailing: const Text('2h'),
            ),
            ListTile(
              leading: const Icon(
                Icons.warning,
                color: AppConstants.warningOrange,
              ),
              title: const Text('Low stock alert'),
              subtitle: const Text('Potatoes running low - 50kg left'),
              trailing: const Text('4h'),
            ),
            ListTile(
              leading: const Icon(
                Icons.trending_up,
                color: AppConstants.primaryBlue,
              ),
              title: const Text('Price increase'),
              subtitle: const Text('Tomato prices up by 15%'),
              trailing: const Text('6h'),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(feature),
        content: Text('$feature feature is coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
