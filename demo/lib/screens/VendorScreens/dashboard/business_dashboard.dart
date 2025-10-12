import 'package:flutter/material.dart';
import '../utils/constantdata.dart';
import '../widgets/common/metric_card.dart';

class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard({Key? key}) : super(key: key);

  @override
  State<BusinessDashboard> createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  String _selectedPeriod = 'Weekly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppConstants.primaryBlue,
        elevation: 0,
        title: const Row(
          children: [
            // Icon(Icons.analytics, color: AppConstants.white, size: 24),
            SizedBox(width: 8),
            Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (period) {
              setState(() {
                _selectedPeriod = period;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Weekly', child: Text('Weekly')),
              const PopupMenuItem(value: 'Monthly', child: Text('Monthly')),
              const PopupMenuItem(value: 'Quarterly', child: Text('Quarterly')),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppConstants.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedPeriod,
                    style: const TextStyle(
                      color: AppConstants.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppConstants.primaryBlue,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.smallPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Metrics
            _buildMainMetrics(),

            // const SizedBox(height: AppConstants.largePadding),

            // Market Trends Chart
            // _buildMarketTrends(),
            const SizedBox(height: AppConstants.smallPadding),

            // Active Alerts
            _buildActiveAlerts(),

            const SizedBox(height: AppConstants.smallPadding),

            // Quick Actions
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key Performance Metrics',
          style: TextStyle(
            fontSize: AppConstants.subtitleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: AppConstants.smallPadding),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                title: 'Monthly Purchases',
                value: '₹5.6L',
                icon: Icons.shopping_cart,
                color: AppConstants.primaryBlue,
                subtitle: '+15% from last month',
              ),
            ),
            const SizedBox(width: AppConstants.smallPadding),
            Expanded(
              child: MetricCard(
                title: 'Current Inventory',
                value: '2,450kg',
                icon: Icons.inventory_2,
                color: AppConstants.primaryGreen,
                subtitle: '85% capacity',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.smallPadding),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                title: 'Active Procurements',
                value: '8',
                icon: Icons.assignment,
                color: AppConstants.warningOrange,
                subtitle: '12 farmer responses',
              ),
            ),
            const SizedBox(width: AppConstants.defaultPadding),
            Expanded(
              child: MetricCard(
                title: 'Profit Margin',
                value: '18.5%',
                icon: Icons.trending_up,
                color: AppConstants.primaryGreen,
                subtitle: '+2.3% this week',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMarketTrends() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: AppConstants.primaryBlue,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Market Trends',
                style: TextStyle(
                  fontSize: AppConstants.subtitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppConstants.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _selectedPeriod,
                  style: const TextStyle(
                    color: AppConstants.primaryBlue,
                    fontSize: AppConstants.captionFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          // Chart Placeholder
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.show_chart, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 8),
                  Text(
                    'Market Trends Chart',
                    style: TextStyle(
                      fontSize: AppConstants.bodyFontSize,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tomato, Wheat, Potato price trends',
                    style: TextStyle(
                      fontSize: AppConstants.captionFontSize,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem('Mon', '28', Colors.blue),
              _buildLegendItem('Tue', '32', Colors.green),
              _buildLegendItem('Wed', '29', Colors.blue),
              _buildLegendItem('Thu', '35', Colors.green),
              _buildLegendItem('Fri', '31', Colors.blue),
              _buildLegendItem('Sat', '38', Colors.green),
              _buildLegendItem('Sun', '33', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String day, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppConstants.captionFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          day,
          style: TextStyle(
            fontSize: AppConstants.captionFontSize - 1,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildActiveAlerts() {
    return Container(
      // padding: const EdgeInsets.all(AppConstants.smallPadding),
      padding: const EdgeInsets.only(
        left: AppConstants.defaultPadding,
        right: AppConstants.defaultPadding,
        top: AppConstants.smallPadding,
        bottom: AppConstants.smallPadding,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.warning_amber,
                color: AppConstants.warningOrange,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Active Alerts',
                style: TextStyle(
                  fontSize: AppConstants.subtitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.smallPadding),
          AlertCard(
            title: 'Tomato prices rising',
            subtitle: 'Good time to sell',
            timeAgo: '2 hours ago',
            color: AppConstants.primaryGreen,
            icon: Icons.trending_up,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Alert details coming soon!')),
              );
            },
          ),
          AlertCard(
            title: 'New procurement responses',
            subtitle: '12 new responses',
            timeAgo: '4 hours ago',
            color: AppConstants.primaryBlue,
            icon: Icons.assignment,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigating to procurement...')),
              );
            },
          ),
          AlertCard(
            title: 'Inventory low stock warning',
            subtitle: 'Potatoes below minimum level',
            timeAgo: '6 hours ago',
            color: AppConstants.warningOrange,
            icon: Icons.inventory_2,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigating to inventory...')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.flash_on, color: AppConstants.warningOrange, size: 20),
              SizedBox(width: 8),
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: AppConstants.subtitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Creating new procurement...'),
                    backgroundColor: AppConstants.primaryBlue,
                  ),
                );
              },
              icon: const Icon(Icons.add, size: 20),
              label: const Text('Create Procurement'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Checking inventory...')),
                    );
                  },
                  icon: const Icon(Icons.inventory_2, size: 18),
                  label: const Text('Check Inventory'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.primaryGreen,
                    side: const BorderSide(color: AppConstants.primaryGreen),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Viewing market data...')),
                    );
                  },
                  icon: const Icon(Icons.trending_up, size: 18),
                  label: const Text('Market Data'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.warningOrange,
                    side: const BorderSide(color: AppConstants.warningOrange),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
