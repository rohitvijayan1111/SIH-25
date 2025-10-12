// screens/purchase_detail_screen.dart

import 'package:flutter/material.dart';
import '../../models/purchase.dart';
import '../../services/purchase_service.dart';
import '../../models/purchase.dart';

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

  // Editable fields
  late TextEditingController quantityController;
  late TextEditingController priceController;
  String selectedPaymentMode = 'UPI';
  DateTime selectedDeliveryDate = DateTime.now().add(Duration(days: 7));

  // Track changes
  bool hasChanges = false;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController();
    priceController = TextEditingController();
    loadPurchaseDetails();
  }

  @override
  void dispose() {
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
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

      // printToConsole(fetchedPurchase.toString());
      setState(() {
        purchase = fetchedPurchase;
        // Initialize controllers with current data
        quantityController.text = fetchedPurchase.quantityKg.toStringAsFixed(0);
        priceController.text = fetchedPurchase.pricePerKg.toStringAsFixed(2);
        selectedPaymentMode = fetchedPurchase.paymentMode ?? 'UPI';
        isLoading = false;
      });

      // Add listeners to track changes
      quantityController.addListener(_onFieldChanged);
      priceController.addListener(_onFieldChanged);
    } catch (e) {
      setState(() {
        error = "Couldn't fetch";
        isLoading = false;
      });
    }
  }

  void _onFieldChanged() {
    if (purchase == null) return;

    bool quantityChanged =
        quantityController.text != purchase!.quantityKg.toStringAsFixed(0);
    bool priceChanged =
        priceController.text != purchase!.pricePerKg.toStringAsFixed(2);
    bool paymentModeChanged =
        selectedPaymentMode != (purchase!.paymentMode ?? 'UPI');

    setState(() {
      hasChanges = quantityChanged || priceChanged || paymentModeChanged;
    });
  }

  Future<void> updatePurchase() async {
    if (purchase == null || !hasChanges) return;

    setState(() {
      isSaving = true;
    });

    try {
      double newQuantity =
          double.tryParse(quantityController.text) ?? purchase!.quantityKg;
      double newPrice =
          double.tryParse(priceController.text) ?? purchase!.pricePerKg;

      Map<String, dynamic> updateData = {
        'quantity_kg': newQuantity,
        'price_per_kg': newPrice,
        'payment_mode': selectedPaymentMode,
      };

      bool success = await PurchaseService.updatePurchase(
        purchase!.id,
        updateData,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Purchase updated successfully'),
            backgroundColor: Colors.green,
          ),
        );

        setState(() {
          hasChanges = false;
        });

        // Reload the purchase to get updated data
        await loadPurchaseDetails();
      } else {
        throw Exception('Update failed');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Couldn't update purchase"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  Future<void> deletePurchase() async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text(
          'Are you sure you want to delete this purchase? This action cannot be undone.',
        ),
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
      setState(() {
        isLoading = true;
      });

      try {
        bool success = await PurchaseService.deletePurchase(purchase!.id);
        if (success) {
          Navigator.pop(context, true); // Return true to indicate deletion
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Purchase deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Couldn't delete purchase"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (hasChanges) {
              _showUnsavedChangesDialog();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Purchase Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (purchase != null &&
              purchase!.paymentStatus.toUpperCase() == 'PENDING')
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.black),
              onPressed: loadPurchaseDetails,
            ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == 'delete') {
                deletePurchase();
              } else if (value == 'duplicate') {
                // Handle duplicate functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Duplicate feature coming soon')),
                );
              }
            },
            itemBuilder: (context) => [
              if (purchase != null &&
                  purchase!.paymentStatus.toUpperCase() == 'PENDING')
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red, size: 16),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              PopupMenuItem(
                value: 'duplicate',
                child: Row(
                  children: [
                    Icon(Icons.copy, color: Colors.grey, size: 16),
                    SizedBox(width: 8),
                    Text('Duplicate'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (hasChanges) {
            bool? shouldPop = await _showUnsavedChangesDialog();
            return shouldPop ?? false;
          }
          return true;
        },
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFF1E40AF)))
            : error != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text("Couldn't fetch"),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: loadPurchaseDetails,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E40AF),
                      ),
                      child: Text(
                        'Retry',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            : purchase == null
            ? Center(child: Text('Purchase not found'))
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Header - Dynamic
                      _buildProductHeader(),
                      SizedBox(height: 24),

                      // Purchase Information - Editable
                      _buildPurchaseInformation(),
                      SizedBox(height: 24),

                      // Seller Information - Dynamic
                      _buildSellerInformation(),
                      SizedBox(height: 24),

                      // Batch Characteristics - Dynamic
                      _buildBatchCharacteristics(),
                      SizedBox(height: 24),

                      // Delivery Tracking - Dynamic
                      _buildDeliveryTracking(),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: purchase != null ? _buildBottomActions() : null,
    );
  }

  Widget _buildProductHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getStatusColor(
                    purchase!.deliveryStatus,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getProductIcon(purchase!.productType),
                  color: _getStatusColor(purchase!.deliveryStatus),
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      purchase!.productName ?? 'Unknown Product',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      purchase!.purchaseCode,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          purchase!.deliveryStatus,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getStatusDisplayText(purchase!.deliveryStatus),
                        style: TextStyle(
                          fontSize: 10,
                          color: _getStatusColor(purchase!.deliveryStatus),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${_formatPrice(purchase!.totalPrice)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E40AF),
                    ),
                  ),
                  Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseInformation() {
    bool isEditable = purchase!.paymentStatus.toUpperCase() == 'PENDING';

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Purchase Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              if (isEditable)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Editable',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),

          // Quantity Editor
          Text(
            'Quantity (kg)',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              if (isEditable) ...[
                IconButton(
                  icon: Icon(Icons.remove, size: 18),
                  onPressed: () {
                    double currentQty =
                        double.tryParse(quantityController.text) ?? 0;
                    if (currentQty > 1) {
                      quantityController.text = (currentQty - 1)
                          .toStringAsFixed(0);
                      _onFieldChanged();
                    }
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: quantityController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onChanged: (value) => _onFieldChanged(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, size: 18),
                  onPressed: () {
                    double currentQty =
                        double.tryParse(quantityController.text) ?? 0;
                    quantityController.text = (currentQty + 1).toStringAsFixed(
                      0,
                    );
                    _onFieldChanged();
                  },
                ),
              ] else ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade50,
                  ),
                  child: Text(
                    '${purchase!.quantityKg.toStringAsFixed(0)} kg',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
              SizedBox(width: 8),
              if (isEditable)
                Text(
                  'Total: ₹${_calculateTotal()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1E40AF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),

          // Price per KG Editor
          Text(
            'Price per KG (₹)',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: priceController,
            enabled: isEditable,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixText: '₹ ',
              filled: !isEditable,
              fillColor: Colors.grey.shade50,
            ),
            onChanged: (value) => _onFieldChanged(),
          ),
          SizedBox(height: 16),

          // Payment Mode Selector
          Text(
            'Payment Mode',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedPaymentMode,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: !isEditable,
              fillColor: Colors.grey.shade50,
            ),
            items: ['UPI', 'Cash', 'Bank Transfer', 'Check'].map((String mode) {
              return DropdownMenuItem<String>(value: mode, child: Text(mode));
            }).toList(),
            onChanged: isEditable
                ? (value) {
                    setState(() {
                      selectedPaymentMode = value ?? 'UPI';
                    });
                    _onFieldChanged();
                  }
                : null,
          ),
          SizedBox(height: 16),

          // Summary Row
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF1E40AF).withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Purchase Date:',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  _formatDate(purchase!.purchaseDate),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerInformation() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seller Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFF1E40AF).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    (purchase!.farmerName?.isNotEmpty == true)
                        ? purchase!.farmerName![0].toUpperCase()
                        : 'F',
                    style: TextStyle(
                      color: Color(0xFF1E40AF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      purchase!.farmerName ?? 'Unknown Farmer',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (purchase!.farmerPhone != null)
                      Text(
                        purchase!.farmerPhone!,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
              if (purchase!.farmerPhone != null)
                IconButton(
                  icon: Icon(Icons.phone, color: Color(0xFF1E40AF), size: 20),
                  onPressed: () {
                    // Handle phone call
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Calling ${purchase!.farmerPhone}'),
                      ),
                    );
                  },
                ),
            ],
          ),
          if (purchase!.farmerLocation != null) ...[
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    purchase!.farmerLocation!,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBatchCharacteristics() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Batch Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Batch ID',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      purchase!.batchId ?? 'N/A',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Type',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      purchase!.productType ?? 'N/A',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (purchase!.productDescription != null) ...[
            SizedBox(height: 12),
            Text(
              'Description',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
            SizedBox(height: 4),
            Text(
              purchase!.productDescription!,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDeliveryTracking() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatusInfo(
                  'Payment Status',
                  purchase!.paymentStatus,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildStatusInfo(
                  'Delivery Status',
                  purchase!.deliveryStatus,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last Updated:',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                Text(
                  _formatDateTime(purchase!.updatedAt),
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusInfo(String label, String status) {
    Color color = _getStatusColor(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            _getStatusDisplayText(status),
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    bool canEdit = purchase!.paymentStatus.toUpperCase() == 'PENDING';

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          if (canEdit) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  deletePurchase();
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
          ],
          Expanded(
            child: ElevatedButton(
              onPressed: (hasChanges && !isSaving) ? updatePurchase : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: hasChanges ? Color(0xFF1E40AF) : Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: isSaving
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      hasChanges ? 'Save Changes' : 'No Changes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showUnsavedChangesDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Unsaved Changes'),
        content: Text(
          'You have unsaved changes. Do you want to save them before leaving?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Discard'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
              await updatePurchase();
              Navigator.of(context).pop();
            },
            child: Text('Save', style: TextStyle(color: Color(0xFF1E40AF))),
          ),
        ],
      ),
    );
  }

  String _calculateTotal() {
    double quantity = double.tryParse(quantityController.text) ?? 0;
    double price = double.tryParse(priceController.text) ?? 0;
    return (quantity * price).toStringAsFixed(2);
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'DELIVERED':
      case 'PAID':
        return Colors.green;
      case 'IN_TRANSIT':
      case 'PROCESSING':
      case 'PENDING':
        return Colors.orange;
      case 'DELAYED':
      case 'FAILED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getProductIcon(String? productType) {
    switch (productType?.toLowerCase()) {
      case 'fruit':
        return Icons.apple;
      case 'vegetable':
        return Icons.eco;
      case 'grain':
        return Icons.grass;
      default:
        return Icons.inventory;
    }
  }

  String _getStatusDisplayText(String status) {
    return status
        .replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatPrice(double price) {
    if (price >= 100000) {
      return '${(price / 100000).toStringAsFixed(1)}L';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(1)}K';
    }
    return price.toStringAsFixed(0);
  }

  String _formatDate(DateTime date) {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_formatDate(dateTime)} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
