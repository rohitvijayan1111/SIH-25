import 'dart:convert';

import 'package:demo/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

<<<<<<< HEAD
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:demo/global.dart';

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
=======
const String SERVER_URL = Globals.SERVER_URL_BAP;
>>>>>>> 7bfa51467d7594b96269f627359f629ce9f2b287

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
<<<<<<< HEAD
  Map<String, Map<String, List<InventoryItem>>> allCategories = {};
  Map<String, Map<String, List<InventoryItem>>> selectedCategory = {};
  List<InventoryItem> searchedItems = [];
  bool isLoading = true;
  bool isLoadingCategory = false;
  bool category_selected = false;
=======
  List<CategoryData> categories = [];
  bool isLoading = true;
>>>>>>> 7bfa51467d7594b96269f627359f629ce9f2b287
  String searchTerm = "";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> categoryList = [
    {'id': 'seed', 'name': 'Seeds'},
    {'id': 'micro', 'name': 'Micro Nutrient'},
    {'id': 'fertilizer', 'name': 'Fertilizer'},
    {'id': 'fungicide', 'name': 'Fungicide'},
    {'id': 'growth_promoter', 'name': 'Growth Promoter'},
    {'id': 'growth_regulator', 'name': 'Growth Regulators'},
    {'id': 'herbicide', 'name': 'Herbicide'},
    {'id': 'land', 'name': 'Land Lease & Sale'},
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialCategories();
  }

  Future<void> _loadInitialCategories() async {
    setState(() => isLoading = true);
    try {
<<<<<<< HEAD
      final results =
          await Future.wait<Map<String, Map<String, List<InventoryItem>>>>([
            _fetchCategoryProducts("seed"),
            _fetchCategoryProducts("fertilizer"),
            _fetchCategoryProducts("fungicide"),
            _fetchCategoryProducts("herbicide"),
          ]);
=======
      final results = await Future.wait<CategoryData>([
        _fetchCategoryProducts("seed"),
        _fetchCategoryProducts("fertilizer"),
        _fetchCategoryProducts("fungicide"),
        _fetchCategoryProducts("herbicide"),
      ]);
>>>>>>> 7bfa51467d7594b96269f627359f629ce9f2b287

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
      // final response = await http.get(
      //   Uri.parse(
      //     '${Globals.SERVER_URL_BPP}/api/batches?product_type=$category',
      //   ),
      //   headers: {'Content-Type': 'application/json'},
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
              child: Image.asset(categoryItem['image']!, fit: BoxFit.contain),
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
          // Category Grid
          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.78,
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
  });

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

              // Image URL from descriptor if available
              String? imageUrl;
              if (firstItem is InventoryItem) {
                // Replace with your logic if InventoryItem has image field
                imageUrl = firstItem.metaHash; // Example placeholder
              }

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
                      // Image
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          color: Colors.green[100],
                        ),
                        child: imageUrl != null
                            ? Image.network(imageUrl, fit: BoxFit.cover)
                            : const Icon(
                                Icons.shopping_bag,
                                size: 60,
                                color: Colors.green,
                              ),
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
