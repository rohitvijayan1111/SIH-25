import 'package:flutter/material.dart';
import '../utils/constantdata.dart';
import '../models/bid.dart';

class BidCard extends StatelessWidget {
  final Bid bid;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onCounterOffer;
  final VoidCallback onViewDetails;

  const BidCard({
    Key? key,
    required this.bid,
    required this.onAccept,
    required this.onReject,
    required this.onCounterOffer,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: Column(
        children: [
          // Farmer Header
          Container(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
                // Farmer Avatar
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppConstants.primaryBlue.withOpacity(0.1),
                  child: Text(
                    bid.farmerName.substring(0, 2).toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Farmer Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            bid.farmerName,
                            style: const TextStyle(
                              fontSize: AppConstants.subtitleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (bid.farmerRating >= 4.5) ...[
                            const Icon(
                              Icons.verified,
                              size: 16,
                              color: AppConstants.primaryGreen,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        bid.farmerLocation,
                        style: TextStyle(
                          fontSize: AppConstants.captionFontSize + 1,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.amber[700]),
                          const SizedBox(width: 2),
                          Text(
                            '${bid.farmerRating}',
                            style: const TextStyle(
                              fontSize: AppConstants.captionFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${bid.farmerReviewCount} reviews)',
                            style: TextStyle(
                              fontSize: AppConstants.captionFontSize - 1,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            bid.distanceDisplay,
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
                // Bid Status
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: bid.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: bid.statusColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    bid.statusDisplay,
                    style: TextStyle(
                      color: bid.statusColor,
                      fontSize: AppConstants.captionFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bid Details
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBidDetail(
                      'Available',
                      AppUtils.formatWeight(bid.quantityAvailable),
                      Icons.scale,
                      AppConstants.primaryBlue,
                    ),
                    _buildBidDetail(
                      'Bid Time',
                      AppUtils.getTimeAgo(bid.bidDate),
                      Icons.access_time,
                      AppConstants.darkGrey,
                    ),
                    _buildBidDetail(
                      'Delivery',
                      bid.deliveryTimeLeft,
                      Icons.local_shipping,
                      AppConstants.primaryGreen,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Price Section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryGreen.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppConstants.primaryGreen.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bid Price',
                            style: TextStyle(
                              fontSize: AppConstants.captionFontSize,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${AppUtils.formatCurrency(bid.pricePerKg)}/kg',
                            style: const TextStyle(
                              fontSize: AppConstants.titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: AppConstants.captionFontSize,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            AppUtils.formatCurrency(bid.totalAmount),
                            style: const TextStyle(
                              fontSize: AppConstants.subtitleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Certifications
                if (bid.certifications.isNotEmpty) ...[
                  Row(
                    children: [
                      const Icon(
                        Icons.verified_outlined,
                        size: 16,
                        color: AppConstants.primaryGreen,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Wrap(
                          spacing: 6,
                          children: bid.certifications.map((cert) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppConstants.primaryGreen.withOpacity(
                                  0.1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppConstants.primaryGreen.withOpacity(
                                    0.3,
                                  ),
                                ),
                              ),
                              child: Text(
                                cert,
                                style: const TextStyle(
                                  fontSize: AppConstants.captionFontSize - 1,
                                  color: AppConstants.primaryGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],

                // Notes
                if (bid.notes != null) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.blue.withOpacity(0.2)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.note,
                          size: 14,
                          color: AppConstants.primaryBlue,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            bid.notes!,
                            style: const TextStyle(
                              fontSize: AppConstants.captionFontSize,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),

          // Action Buttons
          Container(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onAccept,
                    icon: const Icon(Icons.check, size: 16),
                    label: const Text('Accept'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onCounterOffer,
                    icon: const Icon(Icons.reply, size: 16),
                    label: const Text('Counter-offer'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppConstants.primaryBlue,
                      side: const BorderSide(color: AppConstants.primaryBlue),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: onReject,
                  icon: const Icon(Icons.close, color: AppConstants.errorRed),
                  style: IconButton.styleFrom(
                    backgroundColor: AppConstants.errorRed.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),

          // Open negotiation chat button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            child: TextButton.icon(
              onPressed: onViewDetails,
              icon: const Icon(
                Icons.chat,
                size: 16,
                color: AppConstants.primaryBlue,
              ),
              label: const Text(
                'Open negotiation chat',
                style: TextStyle(
                  color: AppConstants.primaryBlue,
                  fontSize: AppConstants.captionFontSize + 1,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildBidDetail(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: AppConstants.bodyFontSize - 1,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: AppConstants.captionFontSize - 1,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
