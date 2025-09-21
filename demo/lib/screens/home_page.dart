import 'dart:convert';

import 'package:demo/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String SERVER_URL = Globals.SERVER_URL_BAP;

// Add the missing InventoryItem class
class InventoryItem {
  final String batchId;
  final String batchCode;
  final String productId;
  final String productName;
  final String productType;
  final String farmerId;
  final String farmerName;
  final String availableQty;
  final String unit;
  final String pricePerUnit;
  final int batchQuantity;
  final DateTime manufacturedOn;
  final DateTime expiryDate;
  final DateTime harvestDate;
  final String locationName;
  final double geoLat;
  final double geoLon;
  final String status;
  final String metaHash;
  final String? chainTx;

  InventoryItem({
    required this.batchId,
    required this.batchCode,
    required this.productId,
    required this.productName,
    required this.productType,
    required this.farmerId,
    required this.farmerName,
    required this.availableQty,
    required this.unit,
    required this.pricePerUnit,
    required this.batchQuantity,
    required this.manufacturedOn,
    required this.expiryDate,
    required this.harvestDate,
    required this.locationName,
    required this.geoLat,
    required this.geoLon,
    required this.status,
    required this.metaHash,
    this.chainTx,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      batchId: json['batch_id']?.toString() ?? '',
      batchCode: json['batch_code']?.toString() ?? '',
      productId: json['product_id']?.toString() ?? '',
      productName: json['product_name']?.toString() ?? '',
      productType: json['product_type']?.toString() ?? '',
      farmerId: json['farmer_id']?.toString() ?? '',
      farmerName: json['farmer_name']?.toString() ?? '',
      availableQty: json['available_qty']?.toString() ?? '',
      unit: json['unit']?.toString() ?? '',
      pricePerUnit: json['price_per_unit']?.toString() ?? '',
      batchQuantity: json['batch_quantity'] ?? 0,
      manufacturedOn: DateTime.tryParse(json['manufactured_on']?.toString() ?? '') ?? DateTime.now(),
      expiryDate: DateTime.tryParse(json['expiry_date']?.toString() ?? '') ?? DateTime.now(),
      harvestDate: DateTime.tryParse(json['harvest_date']?.toString() ?? '') ?? DateTime.now(),
      locationName: json['location_name']?.toString() ?? '',
      geoLat: double.tryParse(json['geo_lat']?.toString() ?? '0') ?? 0.0,
      geoLon: double.tryParse(json['geo_lon']?.toString() ?? '0') ?? 0.0,
      status: json['status']?.toString() ?? '',
      metaHash: json['meta_hash']?.toString() ?? '',
      chainTx: json['chain_tx']?.toString(),
    );
  }
}

class CategoryData {
  final String category;
  final List<dynamic> items;
  final List<dynamic> providers;

  CategoryData({
    required this.category,
    required this.items,
    required this.providers,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryData> categories = [];
  bool isLoading = true;
  bool isLoadingCategory = false;
  bool category_selected = false;
  String searchTerm = "";
  final TextEditingController _searchController = TextEditingController();

  // Add missing state variables
  Map<String, Map<String, List<InventoryItem>>> allCategories = {};
  Map<String, Map<String, List<InventoryItem>>> selectedCategory = {};
  List<InventoryItem> searchedItems = [];

  final List<Map<String, String>> categoryList = [
    {'id': 'seed', 'name': 'Seeds', 'image': 'assets/images/seed.png'},
    {'id': 'micro', 'name': 'Micro Nutrient', 'image': 'assets/images/micro.png'},
    {'id': 'fertilizer', 'name': 'Fertilizer', 'image': 'assets/images/fertilizer.png'},
    {'id': 'fungicide', 'name': 'Fungicide', 'image': 'assets/images/fungicide.png'},
    {'id': 'growth_promoter', 'name': 'Growth Promoter', 'image': 'assets/images/growth_promoter.png'},
    {'id': 'growth_regulator', 'name': 'Growth Regulators', 'image': 'assets/images/growth_regulator.png'},
    {'id': 'herbicide', 'name': 'Herbicide', 'image': 'assets/images/herbicide.png'},
    {'id': 'land', 'name': 'Land Lease & Sale', 'image': 'assets/images/land.png'},
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialCategories();
  }

  Future<void> _loadInitialCategories() async {
    setState(() => isLoading = true);
    try {
      final results = await Future.wait([
        _fetchCategoryProducts("seed"),
        _fetchCategoryProducts("fertilizer"),
        _fetchCategoryProducts("fungicide"),
        _fetchCategoryProducts("herbicide"),
      ]);

      final Map<String, Map<String, List<InventoryItem>>> categoryMap = {};
      for (var result in results) {
        categoryMap.addAll(result);
      }

      setState(() {
        allCategories = categoryMap;
      });
    } catch (e) {
      debugPrint("Error loading initial categories: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<Map<String, Map<String, List<InventoryItem>>>> _fetchCategoryProducts(
    String category,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$SERVER_URL/bap/search'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'productName': '',
          'category': category,
          'lat': '23.2599',
          'lon': '79.0882',
          'radius': 1000,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('HTTP error! Status: ${response.statusCode}');
      }

      final List<dynamic> inventoryJson =
          jsonDecode(response.body)['inventory'] ?? [];
      final Map<String, List<InventoryItem>> grouped = {};

      for (var itemJson in inventoryJson) {
        final item = InventoryItem.fromJson(itemJson);
        grouped.putIfAbsent(item.productName, () => []);
        grouped[item.productName]!.add(item);
      }
      print("\nhelllo\n");
      print(grouped);
      return {category: grouped};
    } catch (error) {
      debugPrint("❌ Error fetching $category products: $error");
      return {category: {}};
    }
  }

  void _searchProducts(String query) {
    if (query.trim().isEmpty) {
      setState(() => searchedItems.clear());
      return;
    }

    final lowerQuery = query.toLowerCase();
    final List<InventoryItem> matches = [];

    allCategories.forEach((category, productMap) {
      productMap.forEach((productName, items) {
        for (var item in items) {
          if (item.batchId.toLowerCase().contains(lowerQuery) ||
              item.batchCode.toLowerCase().contains(lowerQuery) ||
              item.productId.toLowerCase().contains(lowerQuery) ||
              item.productName.toLowerCase().contains(lowerQuery) ||
              item.productType.toLowerCase().contains(lowerQuery) ||
              item.farmerId.toLowerCase().contains(lowerQuery) ||
              item.farmerName.toLowerCase().contains(lowerQuery) ||
              item.availableQty.toLowerCase().contains(lowerQuery) ||
              item.unit.toLowerCase().contains(lowerQuery) ||
              item.pricePerUnit.toLowerCase().contains(lowerQuery) ||
              item.batchQuantity.toString().contains(lowerQuery) ||
              item.manufacturedOn.toString().toLowerCase().contains(
                lowerQuery,
              ) ||
              item.expiryDate.toString().toLowerCase().contains(lowerQuery) ||
              item.harvestDate.toString().toLowerCase().contains(lowerQuery) ||
              item.locationName.toLowerCase().contains(lowerQuery) ||
              item.geoLat.toString().contains(lowerQuery) ||
              item.geoLon.toString().contains(lowerQuery) ||
              item.status.toLowerCase().contains(lowerQuery) ||
              item.metaHash.toLowerCase().contains(lowerQuery) ||
              (item.chainTx?.toLowerCase().contains(lowerQuery) ?? false)) {
            matches.add(item);
          }
        }
      });
    });

    setState(() {
      searchedItems = matches;
    });
    debugPrint("✅ Found ${searchedItems.length} items for '$query'");
  }

  Future<void> _handleCategoryPress(String category) async {
    setState(() => isLoadingCategory = true);
    final categoryData = allCategories[category];
    if (categoryData != null) {
      setState(() {
        selectedCategory.clear();
        selectedCategory[category] = categoryData;
        category_selected = true;
      });
    }
    setState(() => isLoadingCategory = false);
  }

  Widget _buildCategoryCard(Map<String, String> categoryItem) {
    return GestureDetector(
      onTap: () => _handleCategoryPress(categoryItem['id']!),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(6),
              child: categoryItem['image'] != null 
                ? Image.asset(categoryItem['image']!, fit: BoxFit.contain)
                : const Icon(Icons.category, size: 30, color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              categoryItem['name']!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: Colors.green),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2e7d32), Color(0xFF66bb6a)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade100, Colors.green.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => searchTerm = value),
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.green.shade700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _searchProducts(searchTerm),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // Category Grid - Fixed to use GridView instead of ListView with gridDelegate
          Container(
            height: 120,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) =>
                  _buildCategoryCard(categoryList[index]),
            ),
          ),
          // Products List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  if (!category_selected) ...[
                    // Render all categories horizontally
                    ...allCategories.entries.map((entry) {
                      return CategorySection(
                        category: entry.key,
                        products: entry.value,
                      );
                    }).toList(),
                  ] else if (selectedCategory.isNotEmpty) ...[
                    // Render only the selected category vertically (one card per InventoryItem)
                    ...selectedCategory.entries.map((entry) {
                      final productsMap =
                          entry.value; // Map<String, List<InventoryItem>>
                      final List<InventoryItem> allItems = [];
                      productsMap.forEach((_, items) => allItems.addAll(items));

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: allItems.map((item) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text("Farmer: ${item.farmerName}"),
                                Text("Batch: ${item.batchCode}"),
                                Text(
                                  "Available: ${item.availableQty} ${item.unit}",
                                ),
                                Text("Price: ₹${item.pricePerUnit}"),
                                Text("Location: ${item.locationName}"),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add to cart function
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "${item.productName} added to cart",
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      "Add to Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ],

                  // Display search results if available
                  if (searchedItems.isNotEmpty)
                    CategorySection(
                      category: 'Search Results',
                      products: {'Results': searchedItems},
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String category;
  final Map<String, List<InventoryItem>>
      products; // productName -> List<InventoryItem>

  const CategorySection({
    Key? key,
    required this.category,
    required this.products,
  }) : super(key: key);

  Widget _getProductIcon(String productName) {
    // Return appropriate icons based on product name/type
    final lowerName = productName.toLowerCase();
    
    if (lowerName.contains('seed')) {
      return const Icon(Icons.eco, size: 60, color: Colors.green);
    } else if (lowerName.contains('fertilizer')) {
      return const Icon(Icons.grass, size: 60, color: Colors.green);
    } else if (lowerName.contains('fungicide') || lowerName.contains('pesticide')) {
      return const Icon(Icons.bug_report, size: 60, color: Colors.green);
    } else if (lowerName.contains('herbicide')) {
      return const Icon(Icons.local_florist, size: 60, color: Colors.green);
    } else if (lowerName.contains('growth')) {
      return const Icon(Icons.trending_up, size: 60, color: Colors.green);
    } else if (lowerName.contains('micro') || lowerName.contains('nutrient')) {
      return const Icon(Icons.science, size: 60, color: Colors.green);
    } else if (lowerName.contains('land') || lowerName.contains('lease')) {
      return const Icon(Icons.landscape, size: 60, color: Colors.green);
    } else {
      return const Icon(Icons.shopping_bag, size: 60, color: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "No products available in $category",
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: products.entries.map((entry) {
              final productName = entry.key;
              final productItems = entry.value;

              // Get first item for display (for image, provider, etc.)
              final firstItem = productItems.first;

              // Provider name
              final providerName = firstItem.farmerName;

              return GestureDetector(
                onTap: () {
                  // Navigate to product details with full list
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(
                        productName: productName,
                        items: productItems,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image - Using placeholder instead of network images
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          color: Colors.green[100],
                        ),
                        child: _getProductIcon(productName),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          providerName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final String productName;
  final List<InventoryItem> items;

  const ProductDetailsScreen({
    super.key,
    required this.productName,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productName), backgroundColor: Colors.green),
      body: items.isEmpty
          ? const Center(
              child: Text(
                "No items available",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product info
                      Text(
                        "Batch: ${item.batchCode}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text("Farmer: ${item.farmerName}"),
                      Text("Available Qty: ${item.availableQty} ${item.unit}"),
                      Text("Price per Unit: ₹${item.pricePerUnit}"),
                      Text(
                        "Manufactured On: ${item.manufacturedOn.toLocal().toString().split(' ')[0]}",
                      ),
                      Text(
                        "Expiry Date: ${item.expiryDate.toLocal().toString().split(' ')[0]}",
                      ),
                      Text(
                        "Harvest Date: ${item.harvestDate.toLocal().toString().split(' ')[0]}",
                      ),
                      Text("Location: ${item.locationName}"),
                      const SizedBox(height: 8),
                      // Add to cart button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Call your addToCart function
                            // Example:
                            // addToCart(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${item.productName} from ${item.farmerName} added to cart",
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}