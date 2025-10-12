import 'package:flutter/material.dart';
import '../../models/purchase.dart';
import '../../services/purchase_service.dart';

class PurchaseDetailScreen extends StatefulWidget {
  final String purchaseId;

  const PurchaseDetailScreen({Key? key, required this.purchaseId})
    : super(key: key);

  @override
  _PurchaseDetailScreenState createState() => _PurchaseDetailScreenState();
}

class _PurchaseDetailScreenState extends State<PurchaseDetailScreen> {
  Purchase? purchase;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadPurchaseDetails();
  }

  Future<void> loadPurchaseDetails() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final fetchedPurchase = await PurchaseService.getPurchaseById(
        widget.purchaseId,
      );
      setState(() {
        purchase = fetchedPurchase;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Details'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: loadPurchaseDetails),
        ],
      ),
      body: isLoading
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
                    onPressed: loadPurchaseDetails,
                    child: Text('Retry'),
                  ),
                ],
              ),
            )
          : purchase == null
          ? Center(child: Text('Purchase not found'))
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Purchase Header Card
                  _buildHeaderCard(),
                  SizedBox(height: 16),

                  // Farmer Information Card
                  _buildFarmerCard(),
                  SizedBox(height: 16),

                  // Product Information Card
                  _buildProductCard(),
                  SizedBox(height: 16),

                  // Purchase Details Card
                  _buildPurchaseDetailsCard(),
                  SizedBox(height: 16),

                  // Status Information Card
                  _buildStatusCard(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              purchase!.purchaseCode,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Total Amount: ${purchase!.currency} ${purchase!.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Purchase Date: ${_formatDateTime(purchase!.purchaseDate)}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmerCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Farmer Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
            _buildInfoRow('Name', purchase!.farmerName ?? 'Unknown'),
            _buildInfoRow('Phone', purchase!.farmerPhone ?? 'N/A'),
            _buildInfoRow('Location', purchase!.farmerLocation ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.inventory, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Product Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
            _buildInfoRow('Product Name', purchase!.productName ?? 'Unknown'),
            _buildInfoRow('Type', purchase!.productType ?? 'N/A'),
            _buildInfoRow('Description', purchase!.productDescription ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseDetailsCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_cart, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Purchase Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
            _buildInfoRow('Quantity', '${purchase!.quantityKg} kg'),
            _buildInfoRow(
              'Price per kg',
              '${purchase!.currency} ${purchase!.pricePerKg.toStringAsFixed(2)}',
            ),
            _buildInfoRow(
              'Total Price',
              '${purchase!.currency} ${purchase!.totalPrice.toStringAsFixed(2)}',
            ),
            _buildInfoRow('Payment Mode', purchase!.paymentMode ?? 'N/A'),
            _buildInfoRow('Batch ID', purchase!.batchId ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Status Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Text(
                  'Payment Status: ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                _StatusChip(
                  label: purchase!.paymentStatus,
                  color: _getPaymentStatusColor(purchase!.paymentStatus),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Delivery Status: ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                _StatusChip(
                  label: purchase!.deliveryStatus,
                  color: _getDeliveryStatusColor(purchase!.deliveryStatus),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoRow('Updated At', _formatDateTime(purchase!.updatedAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(fontSize: 16))),
        ],
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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
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
