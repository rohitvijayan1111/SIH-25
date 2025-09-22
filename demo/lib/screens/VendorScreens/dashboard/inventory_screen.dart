import 'package:flutter/material.dart';
import '../utils/constantdata.dart';
import '../utils/sample_data.dart';
import '../models/inventory.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<InventoryItem> _inventoryItems = [];
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadInventory();
  }

  void _loadInventory() {
    setState(() {
      _inventoryItems = SampleData.inventoryItems;
    });
  }

  List<InventoryItem> get _filteredItems {
    switch (_selectedFilter) {
      case 'All':
        return _inventoryItems;
      case 'Expiring Soon':
        return SampleData.getExpiringSoonItems();
      case 'Low Stock':
        return SampleData.getLowStockItems();
      default:
        return _inventoryItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.inventory_2, color: AppConstants.primaryGreen, size: 24),
            SizedBox(width: 8),
            Text(
              'My Inventory',
              style: TextStyle(
                color: Colors.black87,
                fontSize: AppConstants.titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search functionality coming soon!'),
                ),
              );
            },
            icon: const Icon(Icons.search, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildInventoryStats(),
          _buildFilterTabs(),
          Expanded(
            child: _filteredItems.isEmpty
                ? _buildEmptyState()
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(
                            AppConstants.defaultPadding,
                          ),
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = _filteredItems[index];
                            return _buildInventoryCard(item);
                          },
                        ),
                      ),
                      _buildStorageLayout(),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add inventory functionality coming soon!'),
              backgroundColor: AppConstants.primaryGreen,
            ),
          );
        },
        backgroundColor: AppConstants.primaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildInventoryStats() {
    final totalValue = _inventoryItems.fold(
      0.0,
      (sum, item) => sum + item.totalValue,
    );
    final totalWeight = _inventoryItems.fold(
      0.0,
      (sum, item) => sum + item.currentStock,
    );
    final lowStockCount = SampleData.getLowStockItems().length;

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
        children: [
          Row(
            children: [
              const Icon(
                Icons.dashboard,
                color: AppConstants.primaryGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Inventory Overview',
                style: TextStyle(
                  fontSize: AppConstants.subtitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Total Value',
                AppUtils.formatCurrency(totalValue),
                Icons.currency_rupee,
                AppConstants.primaryGreen,
              ),
              _buildStatItem(
                'Total Stock',
                AppUtils.formatWeight(totalWeight),
                Icons.scale,
                AppConstants.primaryBlue,
              ),
              _buildStatItem(
                'Low Stock',
                lowStockCount.toString(),
                Icons.warning,
                lowStockCount > 0
                    ? AppConstants.warningOrange
                    : AppConstants.darkGrey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
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

  Widget _buildFilterTabs() {
    final filters = ['All', 'Expiring Soon', 'Low Stock'];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
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
                  color: isSelected ? AppConstants.primaryGreen : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppConstants.primaryGreen
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

  Widget _buildInventoryCard(InventoryItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.imageUrl,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productName,
                        style: const TextStyle(
                          fontSize: AppConstants.subtitleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (item.qualityGrade != null) ...[
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < item.qualityGrade!
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 12,
                                  color: Colors.amber,
                                );
                              }),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Grade A',
                              style: TextStyle(
                                fontSize: AppConstants.captionFontSize,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
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
                        color: item.statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: item.statusColor.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        item.statusDisplay,
                        style: TextStyle(
                          color: item.statusColor,
                          fontSize: AppConstants.captionFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (item.daysUntilExpiry != null) ...[
                      Text(
                        '${item.daysUntilExpiry} days remaining',
                        style: TextStyle(
                          fontSize: AppConstants.captionFontSize - 1,
                          color: item.isExpiringSoon
                              ? AppConstants.errorRed
                              : Colors.grey[600],
                          fontWeight: item.isExpiringSoon
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Stock Level Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Stock Level',
                      style: TextStyle(
                        fontSize: AppConstants.captionFontSize,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${AppUtils.formatWeight(item.currentStock)} / ${AppUtils.formatWeight(item.maxCapacity)}',
                      style: const TextStyle(
                        fontSize: AppConstants.captionFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: item.stockPercentage / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    item.stockPercentage > 50
                        ? AppConstants.primaryGreen
                        : item.stockPercentage > 25
                        ? AppConstants.warningOrange
                        : AppConstants.errorRed,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Details Row
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    'Purchase Price',
                    '${AppUtils.formatCurrency(item.purchasePrice)}/kg',
                    Icons.money,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    'Market Price',
                    '${AppUtils.formatCurrency(item.currentMarketPrice)}/kg',
                    Icons.trending_up,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    'Storage',
                    '${item.storageLocationName}, ${item.storageSection}',
                    Icons.warehouse,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showMoveDialog(item),
                    icon: const Icon(Icons.move_up, size: 16),
                    label: const Text('Move'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppConstants.primaryBlue,
                      side: const BorderSide(color: AppConstants.primaryBlue),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showSellDialog(item),
                    icon: const Icon(Icons.sell, size: 16),
                    label: const Text('Sell'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _showMarkLossDialog(item),
                  icon: const Icon(Icons.warning, color: AppConstants.errorRed),
                  style: IconButton.styleFrom(
                    backgroundColor: AppConstants.errorRed.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppConstants.captionFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: AppConstants.captionFontSize - 1,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildStorageLayout() {
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
          const Row(
            children: [
              Icon(Icons.warehouse, color: AppConstants.primaryBlue, size: 20),
              SizedBox(width: 8),
              Text(
                'Storage Layout',
                style: TextStyle(
                  fontSize: AppConstants.subtitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Row(
            children: [
              Expanded(child: _buildWarehouseSection('Warehouse A', 2, 2)),
              const SizedBox(width: 12),
              Expanded(child: _buildWarehouseSection('Warehouse B', 2, 2)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem(Colors.blue, 'Occupied'),
              _buildLegendItem(Colors.orange, 'Expiring'),
              _buildLegendItem(Colors.grey[300]!, 'Empty'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWarehouseSection(String name, int rows, int cols) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: AppConstants.captionFontSize + 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: List.generate(rows, (row) {
              return Row(
                children: List.generate(cols, (col) {
                  final sectionNumber = row * cols + col + 1;
                  final color = sectionNumber == 1
                      ? Colors.blue
                      : sectionNumber == 2
                      ? Colors.orange
                      : Colors.grey[300]!;

                  return Expanded(
                    child: Container(
                      height: 30,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'S$sectionNumber',
                          style: TextStyle(
                            fontSize: AppConstants.captionFontSize - 2,
                            fontWeight: FontWeight.w600,
                            color: color == Colors.grey[300]
                                ? Colors.grey[600]
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: AppConstants.captionFontSize - 1),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No ${_selectedFilter.toLowerCase()} items',
            style: TextStyle(
              fontSize: AppConstants.subtitleFontSize,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your inventory will appear here',
            style: TextStyle(
              fontSize: AppConstants.bodyFontSize,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showMoveDialog(InventoryItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Move ${item.productName}'),
        content: const Text('Select new storage location'),
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
                  content: Text('${item.productName} moved successfully'),
                  backgroundColor: AppConstants.primaryGreen,
                ),
              );
            },
            child: const Text('Move'),
          ),
        ],
      ),
    );
  }

  void _showSellDialog(InventoryItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sell ${item.productName}'),
        content: Text(
          'Current market price: ${AppUtils.formatCurrency(item.currentMarketPrice)}/kg',
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
                  content: Text('${item.productName} listed for sale'),
                  backgroundColor: AppConstants.primaryGreen,
                ),
              );
            },
            child: const Text('Sell'),
          ),
        ],
      ),
    );
  }

  void _showMarkLossDialog(InventoryItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Mark Loss - ${item.productName}'),
        content: const Text('Mark this item as damaged or expired?'),
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
                  content: Text('${item.productName} marked as loss'),
                  backgroundColor: AppConstants.errorRed,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Mark Loss'),
          ),
        ],
      ),
    );
  }
}
