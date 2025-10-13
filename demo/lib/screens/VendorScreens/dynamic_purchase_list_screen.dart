import 'package:flutter/material.dart';
import '../../models/purchase.dart';
import '../../services/purchase_service.dart';
import 'dynamic_purchase_detail_screen.dart';
import './utils/constantdata.dart';

class PurchaseListScreen extends StatefulWidget {
  @override
  _PurchaseListScreenState createState() => _PurchaseListScreenState();
}

class _PurchaseListScreenState extends State<PurchaseListScreen> {
  List<Purchase> purchases = [];
  List<Purchase> filteredPurchases = [];
  bool isLoading = true;
  String? error;
  bool isSelectMode = false;
  List<String> selectedPurchases = [];

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
        filteredPurchases = fetchedPurchases;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = "Couldn't fetch";
        isLoading = false;
      });
    }
  }

  void toggleSelectMode() {
    setState(() {
      isSelectMode = !isSelectMode;
      if (!isSelectMode) {
        selectedPurchases.clear();
      }
    });
  }

  void toggleSelection(String purchaseId) {
    setState(() {
      if (selectedPurchases.contains(purchaseId)) {
        selectedPurchases.remove(purchaseId);
      } else {
        selectedPurchases.add(purchaseId);
      }
    });
  }

  Future<void> deletePurchase(String purchaseId) async {
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
            SnackBar(
              content: Text('Purchase deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
          loadPurchases(); // Refresh the list
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Couldn't delete purchase"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> bulkDeletePurchases() async {
    try {
      List<Future<bool>> deleteFutures = selectedPurchases
          .map((id) => PurchaseService.deletePurchase(id))
          .toList();

      List<bool> results = await Future.wait(deleteFutures);
      int successCount = results.where((success) => success).length;

      if (successCount > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$successCount purchases deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          selectedPurchases.clear();
          isSelectMode = false;
        });
        loadPurchases(); // Refresh the list
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Couldn't delete purchases"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConstants.primaryBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        // leading: Icon(Icons.arrow_back),
        title: const Text(
          'Purchases',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: () {
              _showFilterDialog();
            },
          ),
          IconButton(icon: Icon(Icons.refresh), onPressed: loadPurchases),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'select') {
                toggleSelectMode();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'select', child: Text('Select')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards Row - Dynamic from actual data
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Total\nVolume',
                    '${_getTotalVolume()}',
                    '+2.5%',
                    Color(0xFF1E40AF),
                    Icons.trending_up,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    'Active\nLogistics',
                    '${_getActiveLogistics()}',
                    'In Transit',
                    Colors.orange,
                    Icons.local_shipping,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    'Pending\nPayments',
                    '${_getPendingPayments()}',
                    'Delayed',
                    Colors.red,
                    Icons.schedule,
                  ),
                ),
              ],
            ),
          ),

          // Action Row for bulk operations
          if (isSelectMode)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  Checkbox(
                    value:
                        selectedPurchases.length == filteredPurchases.length &&
                        filteredPurchases.isNotEmpty,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedPurchases = filteredPurchases
                              .map((p) => p.id)
                              .toList();
                        } else {
                          selectedPurchases.clear();
                        }
                      });
                    },
                    activeColor: Color(0xFF1E40AF),
                  ),
                  Text('Select All'),
                  Spacer(),
                  TextButton.icon(
                    icon: Icon(Icons.delete, color: Colors.red, size: 18),
                    label: Text(
                      'Delete Selected',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: selectedPurchases.isNotEmpty
                        ? () {
                            _showBulkDeleteConfirmation();
                          }
                        : null,
                  ),
                  SizedBox(width: 8),
                  Text('${selectedPurchases.length} purchases'),
                ],
              ),
            ),

          // Content Section - Dynamic from API
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xFF1E40AF)),
                  )
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
                          onPressed: loadPurchases,
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
                : filteredPurchases.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No purchases found'),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: loadPurchases,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1E40AF),
                          ),
                          child: Text(
                            'Refresh',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: loadPurchases,
                    color: Color(0xFF1E40AF),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredPurchases.length,
                      itemBuilder: (context, index) {
                        final purchase = filteredPurchases[index];
                        return _buildPurchaseCard(purchase);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              if (title.contains('Total'))
                Icon(Icons.trending_up, color: Colors.green, size: 16),
            ],
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              height: 1.2,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 10, color: color)),
        ],
      ),
    );
  }

  Widget _buildPurchaseCard(Purchase purchase) {
    bool isSelected = selectedPurchases.contains(purchase.id);

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Color(0xFF1E40AF) : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (isSelectMode) {
            toggleSelection(purchase.id);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PurchaseDetailScreen(purchaseId: purchase.id),
              ),
            ).then((_) {
              // Refresh list when returning from detail screen
              loadPurchases();
            });
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isSelectMode)
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Checkbox(
                        value: isSelected,
                        onChanged: (value) => toggleSelection(purchase.id),
                        activeColor: Color(0xFF1E40AF),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      purchase.productName ?? 'Unknown Product',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  if (!isSelectMode) ...[
                    IconButton(
                      icon: Icon(
                        Icons.visibility_outlined,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PurchaseDetailScreen(purchaseId: purchase.id),
                          ),
                        ).then((_) {
                          // Refresh list when returning from detail screen
                          loadPurchases();
                        });
                      },
                    ),
                    if (purchase.paymentStatus.toUpperCase() == 'PENDING')
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => deletePurchase(purchase.id),
                      ),
                  ],
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Source: ${purchase.farmerName ?? 'Unknown'}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          '${purchase.quantityKg.toStringAsFixed(0)} kg',
                          style: TextStyle(
                            fontSize: 14,
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
                          'Buy Price',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          '₹${_formatPrice(purchase.totalPrice)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Per KG',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          '₹${purchase.pricePerKg.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
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
                          'Delivery',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          _formatDate(purchase.purchaseDate),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  _buildStatusChip(purchase.deliveryStatus),
                  SizedBox(width: 8),
                  _buildStatusChip(purchase.paymentStatus, isPrimary: false),
                  Spacer(),
                  Text(
                    _formatDate(purchase.updatedAt),
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, {bool isPrimary = true}) {
    Color color;
    String displayText;

    if (isPrimary) {
      // Delivery status colors
      switch (status.toUpperCase()) {
        case 'DELIVERED':
          color = Colors.green;
          displayText = 'Delivered';
          break;
        case 'IN_TRANSIT':
          color = Colors.orange;
          displayText = 'In Transit';
          break;
        case 'PROCESSING':
          color = Color(0xFF1E40AF);
          displayText = 'Processing';
          break;
        case 'PENDING':
          color = Colors.orange;
          displayText = 'Pending';
          break;
        case 'DELAYED':
          color = Colors.red;
          displayText = 'Delayed';
          break;
        default:
          color = Colors.grey;
          displayText = status;
      }
    } else {
      // Payment status colors
      switch (status.toUpperCase()) {
        case 'PAID':
          color = Colors.green;
          displayText = 'Paid';
          break;
        case 'PENDING':
          color = Colors.orange;
          displayText = 'Pending Payment';
          break;
        case 'FAILED':
          color = Colors.red;
          displayText = 'Failed';
          break;
        default:
          color = Colors.grey;
          displayText = status;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 4),
          Text(
            displayText,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String? tempPaymentStatus = selectedPaymentStatus;
        String? tempDeliveryStatus = selectedDeliveryStatus;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Filter Purchases'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Payment Status'),
                    value: tempPaymentStatus,
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
                      setDialogState(() {
                        tempPaymentStatus = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Delivery Status'),
                    value: tempDeliveryStatus,
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
                        value: 'IN_TRANSIT',
                        child: Text('In Transit'),
                      ),
                      DropdownMenuItem(
                        value: 'CANCELLED',
                        child: Text('Cancelled'),
                      ),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        tempDeliveryStatus = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPaymentStatus = tempPaymentStatus;
                      selectedDeliveryStatus = tempDeliveryStatus;
                    });
                    Navigator.pop(context);
                    loadPurchases();
                  },
                  child: Text(
                    'Apply',
                    style: TextStyle(color: Color(0xFF1E40AF)),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showBulkDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text(
          'Are you sure you want to delete ${selectedPurchases.length} selected purchases?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bulkDeletePurchases();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
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

  // Dynamic calculations from actual data
  String _getTotalVolume() {
    if (purchases.isEmpty) return '0';
    double total = purchases.fold(0, (sum, p) => sum + p.quantityKg);
    if (total >= 1000) {
      return '${(total / 1000).toStringAsFixed(1)}K';
    }
    return total.toStringAsFixed(0);
  }

  int _getActiveLogistics() {
    return purchases
        .where(
          (p) =>
              p.deliveryStatus.toUpperCase() == 'IN_TRANSIT' ||
              p.deliveryStatus.toUpperCase() == 'PROCESSING',
        )
        .length;
  }

  int _getPendingPayments() {
    return purchases
        .where((p) => p.paymentStatus.toUpperCase() == 'PENDING')
        .length;
  }
}
