import '../models/farmer.dart';
import '../models/product.dart';
import '../models/procurement.dart';
import '../models/bid.dart';
import '../models/inventory.dart';

class SampleData {
  // Sample Farmers
  static final List<Farmer> farmers = [
    Farmer(
      id: 'farmer_1',
      name: 'Raj Kumar',
      phone: '9999999999',
      location: 'Nashik',
      rating: 4.7,
      reviewCount: 45,
      profileImage: 'https://via.placeholder.com/100x100.png?text=RK',
      certifications: ['Organic', 'Grade A'],
      isVerified: true,
      joinDate: DateTime(2022, 1, 15),
    ),
    Farmer(
      id: 'farmer_2',
      name: 'Suresh Patil',
      phone: '9888888888',
      location: 'Pune',
      rating: 4.5,
      reviewCount: 32,
      profileImage: 'https://via.placeholder.com/100x100.png?text=SP',
      certifications: ['Grade A'],
      isVerified: true,
      joinDate: DateTime(2021, 8, 20),
    ),
    Farmer(
      id: 'farmer_3',
      name: 'Amit Sharma',
      phone: '9777777777',
      location: 'Satara',
      rating: 4.8,
      reviewCount: 67,
      profileImage: 'https://via.placeholder.com/100x100.png?text=AS',
      certifications: ['Organic', 'Premium'],
      isVerified: true,
      joinDate: DateTime(2020, 3, 10),
    ),
    Farmer(
      id: 'farmer_4',
      name: 'Priya Farms',
      phone: '9666666666',
      location: 'Kolhapur',
      rating: 4.6,
      reviewCount: 28,
      profileImage: 'https://via.placeholder.com/100x100.png?text=PF',
      certifications: ['Grade A'],
      isVerified: true,
      joinDate: DateTime(2022, 6, 5),
    ),
  ];

  // Sample Products
  static final List<Product> products = [
    Product(
      id: 'prod_1',
      name: 'Tomatoes',
      category: ProductCategory.vegetables,
      variety: 'Roma',
      description:
          'Fresh organic Roma tomatoes, perfect for cooking and salads',
      imageUrl: '🍅',
      grade: ProductGrade.gradeA,
      pricePerKg: 25.0,
      unit: 'kg',
      shelfLifeDays: 7,
      storageRequirements: ['Cool', 'Dry', 'Ventilated'],
      isOrganic: true,
      originState: 'Maharashtra',
    ),
    Product(
      id: 'prod_2',
      name: 'Wheat',
      category: ProductCategory.grains,
      variety: 'Durum',
      description: 'High-quality durum wheat for premium flour production',
      imageUrl: '🌾',
      grade: ProductGrade.gradeA,
      pricePerKg: 22.0,
      unit: 'kg',
      shelfLifeDays: 365,
      storageRequirements: ['Dry', 'Pest-free', 'Temperature controlled'],
      isOrganic: false,
      originState: 'Maharashtra',
    ),
    Product(
      id: 'prod_3',
      name: 'Potatoes',
      category: ProductCategory.vegetables,
      variety: 'Russet',
      description: 'Premium quality potatoes ideal for processing and cooking',
      imageUrl: '🥔',
      grade: ProductGrade.gradeA,
      pricePerKg: 18.0,
      unit: 'kg',
      shelfLifeDays: 30,
      storageRequirements: ['Cool', 'Dark', 'Dry'],
      isOrganic: false,
      originState: 'Maharashtra',
    ),
  ];

  // Sample Procurements
  static final List<Procurement> procurements = [
    Procurement(
      id: 'proc_1',
      productId: 'prod_1',
      productName: 'Tomatoes',
      variety: 'Roma',
      quantityRequired: 500.0,
      maxPricePerKg: 25.0,
      deadline: DateTime.now().add(const Duration(days: 2)),
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      status: ProcurementStatus.active,
      deliveryLocation: 'Pune Market',
      specialRequirements: 'Fresh, Grade A quality required',
      bids: ['bid_1', 'bid_2', 'bid_3'],
    ),
    Procurement(
      id: 'proc_2',
      productId: 'prod_2',
      productName: 'Wheat',
      variety: 'Durum',
      quantityRequired: 1000.0,
      maxPricePerKg: 22.0,
      deadline: DateTime.now().add(const Duration(days: 1)),
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      status: ProcurementStatus.active,
      deliveryLocation: 'Mumbai Warehouse',
      bids: ['bid_4'],
    ),
    Procurement(
      id: 'proc_3',
      productId: 'prod_1',
      productName: 'Tomatoes',
      variety: 'Roma',
      quantityRequired: 300.0,
      maxPricePerKg: 24.0,
      deadline: DateTime.now().subtract(const Duration(days: 1)),
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      status: ProcurementStatus.completed,
      deliveryLocation: 'Nashik Processing Unit',
      farmerId: 'farmer_1',
      farmerName: 'Raj Kumar',
      assignedBidId: 'bid_completed_1',
      finalPrice: 23.0,
      deliveryDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Procurement(
      id: 'proc_4',
      productId: 'prod_2',
      productName: 'Wheat',
      variety: 'Durum',
      quantityRequired: 800.0,
      maxPricePerKg: 21.0,
      deadline: DateTime.now().add(const Duration(hours: 18)),
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      status: ProcurementStatus.inProgress,
      deliveryLocation: 'Pune Mill',
      farmerId: 'farmer_2',
      farmerName: 'Suresh Patil',
      assignedBidId: 'bid_5',
      finalPrice: 20.5,
    ),
  ];

  // Sample Bids
  static final List<Bid> bids = [
    Bid(
      id: 'bid_1',
      procurementId: 'proc_1',
      farmerId: 'farmer_1',
      farmerName: 'Raj Kumar',
      farmerLocation: 'Nashik',
      farmerProfileImage: 'https://via.placeholder.com/100x100.png?text=RK',
      farmerRating: 4.7,
      farmerReviewCount: 45,
      quantityAvailable: 150.0,
      pricePerKg: 22.0,
      totalAmount: 3300.0,
      deliveryDate: DateTime.now().add(const Duration(hours: 4)),
      bidDate: DateTime.now().subtract(const Duration(hours: 2)),
      status: BidStatus.pending,
      transportMethod: 'Own truck',
      distanceKm: 150.0,
      certifications: ['Organic', 'Grade A'],
      notes: '150km away from delivery location. Fresh harvest available.',
      isNegotiable: true,
    ),
    Bid(
      id: 'bid_2',
      procurementId: 'proc_1',
      farmerId: 'farmer_2',
      farmerName: 'Suresh Patil',
      farmerLocation: 'Pune',
      farmerProfileImage: 'https://via.placeholder.com/100x100.png?text=SP',
      farmerRating: 4.5,
      farmerReviewCount: 32,
      quantityAvailable: 300.0,
      pricePerKg: 24.0,
      totalAmount: 7200.0,
      deliveryDate: DateTime.now().add(const Duration(hours: 4)),
      bidDate: DateTime.now().subtract(const Duration(hours: 4)),
      status: BidStatus.pending,
      transportMethod: 'Third-party',
      distanceKm: 80.0,
      certifications: ['Grade A'],
      notes: '300kg available. Can deliver in 4 hours.',
      isNegotiable: true,
    ),
    Bid(
      id: 'bid_3',
      procurementId: 'proc_1',
      farmerId: 'farmer_3',
      farmerName: 'Amit Sharma',
      farmerLocation: 'Satara',
      farmerProfileImage: 'https://via.placeholder.com/100x100.png?text=AS',
      farmerRating: 4.8,
      farmerReviewCount: 67,
      quantityAvailable: 200.0,
      pricePerKg: 23.0,
      totalAmount: 4600.0,
      deliveryDate: DateTime.now().add(const Duration(hours: 6)),
      bidDate: DateTime.now().subtract(const Duration(hours: 6)),
      status: BidStatus.pending,
      transportMethod: 'Own truck',
      distanceKm: 120.0,
      certifications: ['Organic', 'Premium'],
      notes: '200kg premium organic tomatoes. 120km distance.',
      isNegotiable: true,
    ),
  ];

  // Sample Inventory Items
  static final List<InventoryItem> inventoryItems = [
    InventoryItem(
      id: 'inv_1',
      productId: 'prod_1',
      productName: 'Tomatoes',
      variety: 'Roma',
      imageUrl: '🍅',
      currentStock: 450.0,
      minStockLevel: 100.0,
      maxCapacity: 1000.0,
      purchaseDate: DateTime.now().subtract(const Duration(days: 15)),
      expiryDate: DateTime.now().add(const Duration(days: 5)),
      purchasePrice: 20.0,
      currentMarketPrice: 25.0,
      farmerId: 'farmer_1',
      farmerName: 'Raj Kumar',
      storageLocation: StorageLocation.warehouseA,
      storageSection: 'S1',
      status: InventoryStatus.inStock,
      qualityNotes: ['Fresh', 'Grade A quality'],
      qualityGrade: 4.5,
      isOrganic: true,
      batchNumber: 'TOM-001-2024',
    ),
    InventoryItem(
      id: 'inv_2',
      productId: 'prod_3',
      productName: 'Potatoes',
      variety: 'Russet',
      imageUrl: '🥔',
      currentStock: 680.0,
      minStockLevel: 200.0,
      maxCapacity: 1500.0,
      purchaseDate: DateTime.now().subtract(const Duration(days: 12)),
      expiryDate: DateTime.now().add(const Duration(days: 12)),
      purchasePrice: 15.0,
      currentMarketPrice: 18.0,
      farmerId: 'farmer_4',
      farmerName: 'Priya Farms',
      storageLocation: StorageLocation.warehouseB,
      storageSection: 'S1',
      status: InventoryStatus.inStock,
      qualityNotes: ['Good quality', 'No damage'],
      qualityGrade: 4.2,
      isOrganic: false,
      batchNumber: 'POT-002-2024',
    ),
  ];

  // Utility methods to get data
  static Farmer? getFarmerById(String id) {
    try {
      return farmers.firstWhere((farmer) => farmer.id == id);
    } catch (e) {
      return null;
    }
  }

  static Product? getProductById(String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  static Procurement? getProcurementById(String id) {
    try {
      return procurements.firstWhere((proc) => proc.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Bid> getBidsForProcurement(String procurementId) {
    return bids.where((bid) => bid.procurementId == procurementId).toList();
  }

  static Bid? getBidById(String id) {
    try {
      return bids.firstWhere((bid) => bid.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Procurement> getActiveProcurements() {
    return procurements
        .where((p) => p.status == ProcurementStatus.active)
        .toList();
  }

  static List<Procurement> getCompletedProcurements() {
    return procurements
        .where((p) => p.status == ProcurementStatus.completed)
        .toList();
  }

  static List<InventoryItem> getLowStockItems() {
    return inventoryItems
        .where(
          (item) =>
              item.status == InventoryStatus.lowStock ||
              item.currentStock <= item.minStockLevel,
        )
        .toList();
  }

  static List<InventoryItem> getExpiringSoonItems() {
    return inventoryItems.where((item) => item.isExpiringSoon).toList();
  }
}
