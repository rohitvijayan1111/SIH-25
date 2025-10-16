import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;
  final VoidCallback onReorder;
  final VoidCallback onReportIssue;

  const OrderCard({
    Key? key,
    required this.order,
    required this.onTap,
    required this.onReorder,
    required this.onReportIssue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey!), // ← Fixed color reference
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: order.status.statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          order.shortOrderId,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    // Icon(
                    //   Icons.chevron_right,
                    //   color: Colors.grey,
                    // ), // ← Fixed color
                  ],
                ),

                const SizedBox(height: 8),

                // Order Date
                Text(
                  order.formattedDate,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ), // ← Fixed color
                ),

                const SizedBox(height: 12),

                // Order Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Items: ${order.itemCount}',
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     color: Colors.grey,
                        //   ), // ← Fixed color
                        // ),
                        const SizedBox(height: 4),
                        Text(
                          '\₹${order.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: order.status.statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        order.status.displayName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: order.status.statusColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onReportIssue,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: BorderSide(color: Colors.red!), // ← Fixed color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Report Issue'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onReorder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, // ← Fixed color
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Re-order'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
