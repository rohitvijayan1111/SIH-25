import 'package:flutter/material.dart';
import '../../services/purchase_service.dart';
import 'purchase_detail_screen.dart';
import '../../models/purchase.dart';
import '../VendorScreens/utils/constantdata.dart';

class PurchaseListScreen extends StatefulWidget {
  @override
  _PurchaseListScreenState createState() => _PurchaseListScreenState();
}

class _PurchaseListScreenState extends State<PurchaseListScreen> {
  List<Purchase> purchases = [];
  bool isLoading = true;
  String? error;

  // Filter variables
  String? selectedPaymentStatus;
  String? selectedDeliveryStatus;

  @override
  void initState() {
    super.initState();
    loadPurchases();
  }

  Future<void> loadPurchases() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final fetchedPurchases = await PurchaseService.getPurchases(
        paymentStatus: selectedPaymentStatus,
        deliveryStatus: selectedDeliveryStatus,
      );
      setState(() {
        purchases = fetchedPurchases;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> deletePurchase(String purchaseId) async {
    // Show confirmation dialog

    print(purchaseId);
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this purchase?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        bool success = await PurchaseService.deletePurchase(purchaseId);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Purchase deleted successfully')),
          );
          loadPurchases(); // Refresh the list
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete purchase: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Purchases',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppConstants.primaryBlue,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: loadPurchases),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Payment Status',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedPaymentStatus,
                    items: [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(
                        value: 'PENDING',
                        child: Text('Pending'),
                      ),
                      DropdownMenuItem(value: 'PAID', child: Text('Paid')),
                      DropdownMenuItem(value: 'FAILED', child: Text('Failed')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentStatus = value;
                      });
                      loadPurchases();
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Delivery Status',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedDeliveryStatus,
                    items: [
                      DropdownMenuItem(value: null, child: Text('All')),
                      DropdownMenuItem(
                        value: 'PENDING',
                        child: Text('Pending'),
                      ),
                      DropdownMenuItem(
                        value: 'DELIVERED',
                        child: Text('Delivered'),
                      ),
                      DropdownMenuItem(
                        value: 'CANCELLED',
                        child: Text('Cancelled'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedDeliveryStatus = value;
                      });
                      loadPurchases();
                    },
                  ),
                ),
              ],
            ),
          ),

          // Content Section
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text('Error: $error'),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: loadPurchases,
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : purchases.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No purchases found'),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: purchases.length,
                    itemBuilder: (context, index) {
                      final purchase = purchases[index];
                      return PurchaseCard(
                        purchase: purchase,
                        onView: () {
                          // Navigate to purchase details
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PurchaseDetailScreen(purchaseId: purchase.id),
                            ),
                          );
                        },
                        onDelete: () => deletePurchase(purchase.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class PurchaseCard extends StatelessWidget {
  final Purchase purchase;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const PurchaseCard({
    Key? key,
    required this.purchase,
    required this.onView,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with purchase code and actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    purchase.purchaseCode,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryBlue,
                    ),
                  ),
                ),
                Row(
                  children: [
                    // View/Eye icon
                    IconButton(
                      icon: Icon(Icons.visibility, color: Colors.blue),
                      onPressed: onView,
                      tooltip: 'View Details',
                    ),
                    // Delete icon (only show for pending purchases)
                    if (purchase.paymentStatus == 'PENDING')
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: onDelete,
                        tooltip: 'Delete Purchase',
                      ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 8),

            // Purchase information
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Farmer: ${purchase.farmerName ?? 'Unknown'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Product: ${purchase.productName ?? 'Unknown'}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Quantity: ${purchase.quantityKg} kg',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${purchase.currency} ${purchase.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '@ ${purchase.pricePerKg}/kg',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12),

            // Status chips
            Row(
              children: [
                // _StatusChip(
                //   label: purchase.paymentStatus,
                //   color: _getPaymentStatusColor(purchase.paymentStatus),
                // ),
                Text("Delivery Status:"),
                SizedBox(width: 8),
                _StatusChip(
                  label: purchase.deliveryStatus,
                  color: _getDeliveryStatusColor(purchase.deliveryStatus),
                ),
                Spacer(),
                Text(
                  _formatDate(purchase.purchaseDate),
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getPaymentStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PAID':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'FAILED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getDeliveryStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'DELIVERED':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


