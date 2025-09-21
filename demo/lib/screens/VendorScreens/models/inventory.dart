import 'package:flutter/material.dart';

enum InventoryStatus { inStock, lowStock, outOfStock, expiringSoon }

enum StorageLocation { warehouseA, warehouseB, coldStorage, dryStorage }

class InventoryItem {
  final String id;
  final String productId;
  final String productName;
  final String variety;
  final String imageUrl;
  final double currentStock;
  final double minStockLevel;
  final double maxCapacity;
  final DateTime purchaseDate;
  final DateTime? expiryDate;
  final double purchasePrice;
  final double currentMarketPrice;
  final String farmerId;
  final String farmerName;
  final StorageLocation storageLocation;
  final String storageSection;
  final InventoryStatus status;
  final List<String> qualityNotes;
  final double? qualityGrade;
  final bool isOrganic;
  final String? batchNumber;

  InventoryItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.variety,
    required this.imageUrl,
    required this.currentStock,
    required this.minStockLevel,
    required this.maxCapacity,
    required this.purchaseDate,
    required this.purchasePrice,
    required this.currentMarketPrice,
    required this.farmerId,
    required this.farmerName,
    required this.storageLocation,
    required this.storageSection,
    required this.status,
    this.expiryDate,
    this.qualityNotes = const [],
    this.qualityGrade,
    this.isOrganic = false,
    this.batchNumber,
  });

  String get storageLocationName {
    switch (storageLocation) {
      case StorageLocation.warehouseA:
        return 'Warehouse A';
      case StorageLocation.warehouseB:
        return 'Warehouse B';
      case StorageLocation.coldStorage:
        return 'Cold Storage';
      case StorageLocation.dryStorage:
        return 'Dry Storage';
    }
  }

  String get statusDisplay {
    switch (status) {
      case InventoryStatus.inStock:
        return 'In Stock';
      case InventoryStatus.lowStock:
        return 'Low Stock';
      case InventoryStatus.outOfStock:
        return 'Out of Stock';
      case InventoryStatus.expiringSoon:
        return 'Expiring Soon';
    }
  }

  Color get statusColor {
    switch (status) {
      case InventoryStatus.inStock:
        return const Color(0xFF34A853);
      case InventoryStatus.lowStock:
        return const Color(0xFFFB8C00);
      case InventoryStatus.outOfStock:
        return const Color(0xFFEA4335);
      case InventoryStatus.expiringSoon:
        return const Color(0xFFFF5722);
    }
  }

  double get stockPercentage {
    return (currentStock / maxCapacity * 100).clamp(0, 100);
  }

  int? get daysUntilExpiry {
    if (expiryDate == null) return null;
    return expiryDate!.difference(DateTime.now()).inDays;
  }

  bool get isExpiringSoon {
    final days = daysUntilExpiry;
    return days != null && days <= 5 && days > 0;
  }

  bool get isExpired {
    final days = daysUntilExpiry;
    return days != null && days <= 0;
  }

  double get profitMargin {
    return ((currentMarketPrice - purchasePrice) / purchasePrice * 100);
  }

  double get totalValue {
    return currentStock * currentMarketPrice;
  }

  @override
  String toString() {
    return 'InventoryItem(id: $id, product: $productName, stock: $currentStock kg, status: $status)';
  }
}
