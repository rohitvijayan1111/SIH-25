import 'package:flutter/material.dart';
import '../utils/constantdata.dart';
import '../utils/sample_data.dart';
import '../models/procurement.dart';

import '../models/bid.dart';
import 'bid_card.dart';

class BiddingDetailScreen extends StatefulWidget {
  final String procurementId;

  const BiddingDetailScreen({Key? key, required this.procurementId})
    : super(key: key);

  @override
  State<BiddingDetailScreen> createState() => _BiddingDetailScreenState();
}

class _BiddingDetailScreenState extends State<BiddingDetailScreen> {
  Procurement? _procurement;
  List<Bid> _bids = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _procurement = SampleData.getProcurementById(widget.procurementId);
      _bids = SampleData.getBidsForProcurement(widget.procurementId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_procurement == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Bidding Details'),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: const Center(child: Text('Procurement not found')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Bidding: ${_procurement!.productName} - ${AppUtils.formatWeight(_procurement!.quantityRequired)}',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'close',
                child: Row(
                  children: [
                    Icon(Icons.close, size: 18),
                    SizedBox(width: 8),
                    Text('Close Bidding'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'extend',
                child: Row(
                  children: [
                    Icon(Icons.access_time, size: 18),
                    SizedBox(width: 8),
                    Text('Extend Deadline'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProcurementHeader(),
          _buildBidsHeader(),
          Expanded(
            child: _bids.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    itemCount: _bids.length,
                    itemBuilder: (context, index) {
                      final bid = _bids[index];
                      return BidCard(
                        bid: bid,
                        onAccept: () => _acceptBid(bid),
                        onReject: () => _rejectBid(bid),
                        onCounterOffer: () => _showCounterOffer(bid),
                        onViewDetails: () => _showBidDetails(bid),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcurementHeader() {
    return Container(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _procurement!.statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.assignment,
                  color: _procurement!.statusColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_procurement!.productName} - ${_procurement!.variety}',
                      style: const TextStyle(
                        fontSize: AppConstants.subtitleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Required: ${AppUtils.formatWeight(_procurement!.quantityRequired)} • Max: ${AppUtils.formatCurrency(_procurement!.maxPricePerKg)}/kg',
                      style: TextStyle(
                        fontSize: AppConstants.captionFontSize + 1,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _procurement!.statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _procurement!.statusColor.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  _procurement!.statusDisplay,
                  style: TextStyle(
                    color: _procurement!.statusColor,
                    fontSize: AppConstants.captionFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                _procurement!.deliveryLocation,
                style: TextStyle(
                  fontSize: AppConstants.bodyFontSize - 1,
                  color: Colors.grey[700],
                ),
              ),
              const Spacer(),
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                _procurement!.daysLeft > 0
                    ? '${_procurement!.daysLeft} days left'
                    : 'Deadline passed',
                style: TextStyle(
                  fontSize: AppConstants.bodyFontSize - 1,
                  color: _procurement!.daysLeft > 0
                      ? AppConstants.primaryGreen
                      : AppConstants.errorRed,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (_procurement!.specialRequirements != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, size: 16, color: Colors.amber),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _procurement!.specialRequirements!,
                      style: const TextStyle(
                        fontSize: AppConstants.captionFontSize + 1,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBidsHeader() {
    if (_bids.isEmpty) return const SizedBox.shrink();

    final avgPrice =
        _bids.fold(0.0, (sum, bid) => sum + bid.pricePerKg) / _bids.length;
    final lowestBid = _bids.reduce(
      (a, b) => a.pricePerKg < b.pricePerKg ? a : b,
    );
    final highestRated = _bids.reduce(
      (a, b) => a.farmerRating > b.farmerRating ? a : b,
    );

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.gavel,
                color: AppConstants.primaryGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${_bids.length} Farmer Bids',
                style: const TextStyle(
                  fontSize: AppConstants.subtitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                '2 days left',
                style: TextStyle(
                  fontSize: AppConstants.captionFontSize,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildBidStat(
                  'Lowest Bid',
                  '${AppUtils.formatCurrency(lowestBid.pricePerKg)}/kg',
                  lowestBid.farmerName,
                  AppConstants.primaryGreen,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildBidStat(
                  'Average',
                  '${AppUtils.formatCurrency(avgPrice)}/kg',
                  '${_bids.length} farmers',
                  AppConstants.primaryBlue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildBidStat(
                  'Top Rated',
                  '⭐ ${highestRated.farmerRating}',
                  highestRated.farmerName,
                  AppConstants.warningOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBidStat(
    String label,
    String value,
    String subtitle,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: AppConstants.captionFontSize,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: AppConstants.captionFontSize - 1,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No Bids Yet',
            style: TextStyle(
              fontSize: AppConstants.subtitleFontSize,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Farmers haven\'t submitted bids for this procurement yet',
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

  void _acceptBid(Bid bid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Accept Bid'),
        content: Text(
          'Accept bid from ${bid.farmerName} at ${AppUtils.formatCurrency(bid.pricePerKg)}/kg for ${AppUtils.formatWeight(bid.quantityAvailable)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Bid accepted! ${bid.farmerName} has been notified.',
                  ),
                  backgroundColor: AppConstants.primaryGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryGreen,
            ),
            child: const Text('Accept'),
          ),
        ],
      ),
    );
  }

  void _rejectBid(Bid bid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Bid'),
        content: Text('Reject bid from ${bid.farmerName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Bid from ${bid.farmerName} rejected.'),
                  backgroundColor: AppConstants.errorRed,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _showCounterOffer(Bid bid) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Counter Offer to ${bid.farmerName}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current bid: ${AppUtils.formatCurrency(bid.pricePerKg)}/kg'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Your counter offer (₹/kg)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Counter offer sent to ${bid.farmerName}'),
                  backgroundColor: AppConstants.primaryBlue,
                ),
              );
            },
            child: const Text('Send Counter Offer'),
          ),
        ],
      ),
    );
  }

  void _showBidDetails(Bid bid) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bid Details - ${bid.farmerName}',
                style: const TextStyle(
                  fontSize: AppConstants.titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Farmer Name', bid.farmerName),
              _buildDetailRow('Location', bid.farmerLocation),
              _buildDetailRow(
                'Rating',
                '⭐ ${bid.farmerRating} (${bid.farmerReviewCount} reviews)',
              ),
              _buildDetailRow(
                'Price per kg',
                AppUtils.formatCurrency(bid.pricePerKg),
              ),
              _buildDetailRow(
                'Available Quantity',
                AppUtils.formatWeight(bid.quantityAvailable),
              ),
              _buildDetailRow(
                'Total Amount',
                AppUtils.formatCurrency(bid.totalAmount),
              ),
              _buildDetailRow('Distance', bid.distanceDisplay),
              _buildDetailRow('Transport Method', bid.transportMethod),
              _buildDetailRow(
                'Delivery Date',
                AppUtils.formatDate(bid.deliveryDate),
              ),
              _buildDetailRow(
                'Bid Submitted',
                AppUtils.getTimeAgo(bid.bidDate),
              ),
              if (bid.certifications.isNotEmpty)
                _buildDetailRow(
                  'Certifications',
                  bid.certifications.join(', '),
                ),
              if (bid.notes != null) _buildDetailRow('Notes', bid.notes!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: AppConstants.bodyFontSize - 1,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: AppConstants.bodyFontSize - 1,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'close':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bidding closed for this procurement'),
            backgroundColor: AppConstants.warningOrange,
          ),
        );
        break;
      case 'extend':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deadline extended by 2 days'),
            backgroundColor: AppConstants.primaryBlue,
          ),
        );
        break;
    }
  }
}
