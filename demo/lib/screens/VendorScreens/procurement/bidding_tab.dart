import 'package:flutter/material.dart';
import '../utils/constantdata.dart';
import '../utils/sample_data.dart';
import '../models/procurement.dart';
import '../bidding/bidding_detail_screen.dart';

class BiddingTab extends StatefulWidget {
  const BiddingTab({Key? key}) : super(key: key);

  @override
  State<BiddingTab> createState() => _BiddingTabState();
}

class _BiddingTabState extends State<BiddingTab> {
  List<Procurement> _procurementsWithBids = [];

  @override
  void initState() {
    super.initState();
    _loadProcurementsWithBids();
  }

  void _loadProcurementsWithBids() {
    setState(() {
      _procurementsWithBids = SampleData.procurements
          .where((p) => p.bids.isNotEmpty)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: _procurementsWithBids.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  itemCount: _procurementsWithBids.length,
                  itemBuilder: (context, index) {
                    final procurement = _procurementsWithBids[index];
                    return _buildProcurementBidCard(procurement);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final totalBids = _procurementsWithBids.fold(
      0,
      (sum, p) => sum + p.bids.length,
    );

    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppConstants.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.gavel,
              color: AppConstants.primaryGreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Active Bidding',
                  style: TextStyle(
                    fontSize: AppConstants.subtitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '$totalBids bids on ${_procurementsWithBids.length} procurements',
                  style: TextStyle(
                    fontSize: AppConstants.captionFontSize + 1,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppConstants.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '$totalBids Bids',
              style: const TextStyle(
                color: AppConstants.primaryGreen,
                fontSize: AppConstants.captionFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcurementBidCard(Procurement procurement) {
    final bids = SampleData.getBidsForProcurement(procurement.id);
    final bestBid = bids.isNotEmpty
        ? bids.reduce((a, b) => a.pricePerKg < b.pricePerKg ? a : b)
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: Column(
        children: [
          // Procurement Header
          Container(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            decoration: BoxDecoration(
              color: AppConstants.primaryBlue.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConstants.cardBorderRadius),
                topRight: Radius.circular(AppConstants.cardBorderRadius),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${procurement.productName} - ${procurement.variety}',
                        style: const TextStyle(
                          fontSize: AppConstants.subtitleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${AppUtils.formatWeight(procurement.quantityRequired)} required • Max ${AppUtils.formatCurrency(procurement.maxPricePerKg)}/kg',
                        style: TextStyle(
                          fontSize: AppConstants.captionFontSize + 1,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.primaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${bids.length} bids',
                        style: const TextStyle(
                          color: AppConstants.primaryGreen,
                          fontSize: AppConstants.captionFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${procurement.daysLeft} days left',
                      style: TextStyle(
                        fontSize: AppConstants.captionFontSize,
                        color: procurement.daysLeft > 0
                            ? AppConstants.primaryGreen
                            : AppConstants.errorRed,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Best Bid Summary
          if (bestBid != null) ...[
            Container(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppConstants.primaryGreen.withOpacity(0.1),
                    child: const Icon(
                      Icons.star,
                      color: AppConstants.primaryGreen,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Best Bid: ${bestBid.farmerName}',
                          style: const TextStyle(
                            fontSize: AppConstants.bodyFontSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${AppUtils.formatCurrency(bestBid.pricePerKg)}/kg',
                              style: const TextStyle(
                                fontSize: AppConstants.subtitleFontSize,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.primaryGreen,
                              ),
                            ),
                            const SizedBox(width: 8),
                            ...bestBid.certifications
                                .take(2)
                                .map(
                                  (cert) => Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      cert,
                                      style: const TextStyle(
                                        fontSize:
                                            AppConstants.captionFontSize - 1,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: AppConstants.warningOrange,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${bestBid.farmerRating}',
                            style: const TextStyle(
                              fontSize: AppConstants.captionFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        bestBid.distanceDisplay,
                        style: TextStyle(
                          fontSize: AppConstants.captionFontSize,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],

          // Action Buttons
          Container(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
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
                    label: const Text('View All Bids'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    _showQuickActions(context, procurement);
                  },
                  icon: const Icon(Icons.more_horiz, size: 16),
                  label: const Text('Actions'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.darkGrey,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.gavel, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No Active Bids',
            style: TextStyle(
              fontSize: AppConstants.subtitleFontSize,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bids will appear here when farmers respond to your procurement requests',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConstants.bodyFontSize,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showQuickActions(BuildContext context, Procurement procurement) {
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
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: AppConstants.subtitleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: AppConstants.primaryGreen,
              ),
              title: const Text('Accept Best Bid'),
              onTap: () {
                Navigator.pop(context);
                _acceptBestBid(procurement);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.access_time,
                color: AppConstants.warningOrange,
              ),
              title: const Text('Extend Deadline'),
              onTap: () {
                Navigator.pop(context);
                _showExtendDeadline(procurement);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel, color: AppConstants.errorRed),
              title: const Text('Cancel Procurement'),
              onTap: () {
                Navigator.pop(context);
                _showCancelConfirmation(procurement);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _acceptBestBid(Procurement procurement) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Best bid accepted! Farmer has been notified.'),
        backgroundColor: AppConstants.primaryGreen,
      ),
    );
  }

  void _showExtendDeadline(Procurement procurement) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Extend deadline functionality coming soon!'),
        backgroundColor: AppConstants.warningOrange,
      ),
    );
  }

  void _showCancelConfirmation(Procurement procurement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Procurement'),
        content: Text(
          'Are you sure you want to cancel "${procurement.productName}" procurement? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Active'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Procurement cancelled'),
                  backgroundColor: AppConstants.errorRed,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
