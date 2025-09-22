// File: lib/screens/middleman/procurement/active_requests_tab.dart
// Purpose: Display and manage active procurement requests

import 'package:flutter/material.dart';
import '../utils/constantdata.dart';
import '../utils/sample_data.dart';
import '../models/procurement.dart';
import '../bidding/bidding_detail_screen.dart';

class ActiveRequestsTab extends StatefulWidget {
  const ActiveRequestsTab({Key? key}) : super(key: key);

  @override
  State<ActiveRequestsTab> createState() => _ActiveRequestsTabState();
}

class _ActiveRequestsTabState extends State<ActiveRequestsTab> {
  List<Procurement> _procurements = [];
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadProcurements();
  }

  void _loadProcurements() {
    setState(() {
      _procurements = SampleData.procurements;
    });
  }

  List<Procurement> get _filteredProcurements {
    if (_selectedFilter == 'All') return _procurements;

    switch (_selectedFilter) {
      case 'Active':
        return _procurements
            .where((p) => p.status == ProcurementStatus.active)
            .toList();
      case 'In Progress':
        return _procurements
            .where((p) => p.status == ProcurementStatus.inProgress)
            .toList();
      case 'Completed':
        return _procurements
            .where((p) => p.status == ProcurementStatus.completed)
            .toList();
      default:
        return _procurements;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterSection(),
        _buildStatsSection(),
        Expanded(
          child: _filteredProcurements.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  itemCount: _filteredProcurements.length,
                  itemBuilder: (context, index) {
                    final procurement = _filteredProcurements[index];
                    return _buildProcurementCard(procurement);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    final filters = ['All', 'Active', 'In Progress', 'Completed'];

    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            final isSelected = _selectedFilter == filter;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppConstants.primaryBlue : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppConstants.primaryBlue
                        : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: AppConstants.captionFontSize + 1,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    final activeProcurements = _procurements
        .where((p) => p.status == ProcurementStatus.active)
        .length;
    final inProgressProcurements = _procurements
        .where((p) => p.status == ProcurementStatus.inProgress)
        .length;
    final totalBids = _procurements.fold(0, (sum, p) => sum + p.bids.length);

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
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            'Active',
            activeProcurements.toString(),
            AppConstants.primaryBlue,
          ),
          _buildStatItem(
            'In Progress',
            inProgressProcurements.toString(),
            AppConstants.warningOrange,
          ),
          _buildStatItem(
            'Total Bids',
            totalBids.toString(),
            AppConstants.primaryGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: AppConstants.subtitleFontSize,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: AppConstants.captionFontSize,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildProcurementCard(Procurement procurement) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${procurement.productName} - ${procurement.variety}',
                    style: const TextStyle(
                      fontSize: AppConstants.subtitleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: procurement.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: procurement.statusColor.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    procurement.statusDisplay,
                    style: TextStyle(
                      color: procurement.statusColor,
                      fontSize: AppConstants.captionFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.scale, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${AppUtils.formatWeight(procurement.quantityRequired)}',
                  style: TextStyle(
                    fontSize: AppConstants.bodyFontSize - 1,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.currency_rupee, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'Max ${AppUtils.formatCurrency(procurement.maxPricePerKg)}/kg',
                  style: TextStyle(
                    fontSize: AppConstants.bodyFontSize - 1,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    procurement.deliveryLocation,
                    style: TextStyle(
                      fontSize: AppConstants.bodyFontSize - 1,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Text(
                  procurement.daysLeft > 0
                      ? '${procurement.daysLeft} days left'
                      : 'Deadline passed',
                  style: TextStyle(
                    fontSize: AppConstants.captionFontSize,
                    color: procurement.daysLeft > 0
                        ? AppConstants.primaryGreen
                        : AppConstants.errorRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (procurement.bids.isNotEmpty) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BiddingDetailScreen(
                              procurementId: procurement.id,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.visibility, size: 16),
                      label: Text('View Bids (${procurement.bids.length})'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No bids received yet'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.hourglass_empty, size: 16),
                      label: const Text('No Bids Yet'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppConstants.darkGrey,
                        side: BorderSide(color: Colors.grey[300]!),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    _handleProcurementAction(procurement, value);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'duplicate',
                      child: Row(
                        children: [
                          Icon(Icons.copy, size: 16),
                          SizedBox(width: 8),
                          Text('Duplicate'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No ${_selectedFilter.toLowerCase()} procurements',
            style: TextStyle(
              fontSize: AppConstants.subtitleFontSize,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first procurement request',
            style: TextStyle(
              fontSize: AppConstants.bodyFontSize,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _handleProcurementAction(Procurement procurement, String action) {
    switch (action) {
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit functionality coming soon!')),
        );
        break;
      case 'duplicate':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Procurement duplicated!')),
        );
        break;
      case 'delete':
        _showDeleteConfirmation(procurement);
        break;
    }
  }

  void _showDeleteConfirmation(Procurement procurement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Procurement'),
        content: Text(
          'Are you sure you want to delete "${procurement.productName}" procurement?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Procurement deleted!')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
