import 'dart:convert';

import 'package:demo/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryData> categories = [];
  bool isLoading = true;
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
      final results = await Future.wait<CategoryData>([
        _fetchCategoryProducts("seed"),
        _fetchCategoryProducts("fertilizer"),
        _fetchCategoryProducts("fungicide"),
        _fetchCategoryProducts("herbicide"),
      ]);

      List<dynamic> trendingItems = [];
      List<dynamic> trendingProviders = [];

      for (var categoryData in results) {
        trendingItems.addAll(categoryData.items.take(2));
        trendingProviders.addAll(categoryData.providers.take(2));
      }

      final trendingCategory = CategoryData(
        category: "TRENDING",
        items: trendingItems,
        providers: trendingProviders,
      );

      setState(() {
        categories = [trendingCategory, ...results];
      });
    } catch (e) {
      debugPrint("❌ Error loading initial categories: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<CategoryData> _fetchCategoryProducts(String category) async {
    try {
      final response = await http.post(
        Uri.parse('${Globals.SERVER_URL_BPP}/api/batch?category?${category}'),
        headers: {'Content-Type': 'application/json'},
        // body: jsonEncode({
        //   'productName': '',
        //   'category': category,
        //   'lat': '23.2599',
        //   'lon': '79.0882',
        //   'radius': 1000,
        // }),
      );

      if (response.statusCode != 200) {
        throw Exception('HTTP error! Status: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      debugPrint("🔎 Response for $category: $jsonResponse");

      final catalog = jsonResponse['catalog'];

      final items = catalog?['items'] ?? catalog?['products']?['items'] ?? [];
      final providers = catalog?['providers'] ?? [];

      debugPrint("✅ ${items.length} items fetched for $category");

      return CategoryData(
        category: category.toUpperCase(),
        items: items,
        providers: providers,
      );
    } catch (error) {
      debugPrint("Error fetching $category products: $error");
      return CategoryData(
        category: category.toUpperCase(),
        items: [],
        providers: [],
      );
    }
  }

  Future<void> _searchProductsByName(String name) async {
    if (name.trim().isEmpty) {
      _loadInitialCategories();
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$SERVER_URL/bap/search'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'productName': name,
          'category': '',
          'lat': '23.2599',
          'lon': '79.0882',
          'radius': 1000,
        }),
      );

      final jsonResponse = jsonDecode(response.body);
      final catalog = jsonResponse['catalog'];

      final items = catalog?['items'] ?? catalog?['products']?['items'] ?? [];
      final providers = catalog?['providers'] ?? [];

      setState(() {
        categories = [
          CategoryData(
            category: 'Results for "$name"',
            items: items,
            providers: providers,
          ),
        ];
      });
    } catch (error) {
      debugPrint("❌ Error searching product name: $error");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _handleCategoryPress(
    String categoryID,
    String categoryName,
  ) async {
    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$SERVER_URL/bap/search'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'productName': '',
          'category': categoryID.toLowerCase(),
          'lat': '23.2599',
          'lon': '79.0882',
          'radius': 1000,
        }),
      );

      final jsonResponse = jsonDecode(response.body);
      final catalog = jsonResponse['catalog'];

      final items = catalog?['items'] ?? catalog?['products']?['items'] ?? [];
      final providers = catalog?['providers'] ?? [];

      setState(() {
        categories = [
          CategoryData(
            category: categoryName,
            items: items,
            providers: providers,
          ),
        ];
      });
    } catch (error) {
      debugPrint("❌ Error fetching category \"$categoryName\": $error");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: Colors.green)),
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
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _searchProductsByName(searchTerm),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Categories
          Container(
            height: 55,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                final categoryItem = categoryList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                    onPressed: () => _handleCategoryPress(
                      categoryItem['id']!,
                      categoryItem['name']!,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: Text(
                      categoryItem['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Products
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: categories.map<Widget>((section) {
                  return CategorySection(
                    category: section.category,
                    items: section.items,
                    providers: section.providers,
                  );
                }).toList(),
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
  final List<dynamic> items;
  final List<dynamic> providers;

  const CategorySection({
    super.key,
    required this.category,
    required this.items,
    required this.providers,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
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
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              // Provider name
              String providerName = "";
              if (item['provider']?['descriptor']?['name'] != null) {
                providerName = item['provider']['descriptor']['name'];
              } else if (providers.isNotEmpty) {
                providerName = providers.first['descriptor']?['name'] ?? "";
              }

              // Image handling
              String? imageUrl;
              if (item['descriptor']?['images'] != null &&
                  item['descriptor']['images'].isNotEmpty) {
                final firstImage = item['descriptor']['images'][0];
                if (firstImage is String) {
                  imageUrl = firstImage;
                } else if (firstImage is Map && firstImage.containsKey('url')) {
                  imageUrl = firstImage['url'];
                }
              } else if (item['descriptor']?['image'] != null) {
                if (item['descriptor']['image'] is String) {
                  imageUrl = item['descriptor']['image'];
                } else if (item['descriptor']['image'] is Map &&
                    item['descriptor']['image'].containsKey('url')) {
                  imageUrl = item['descriptor']['image']['url'];
                }
              }

              if (imageUrl != null &&
                  !(imageUrl.startsWith("http://") ||
                      imageUrl.startsWith("https://"))) {
                imageUrl = "$SERVER_URL/$imageUrl";
              }

              return Container(
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
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.green[100],
                                    child: const Icon(
                                      Icons.shopping_bag,
                                      size: 60,
                                      color: Colors.green,
                                    ),
                                  ),
                            )
                          : Container(
                              color: Colors.green[100],
                              child: const Icon(
                                Icons.shopping_bag,
                                size: 60,
                                color: Colors.green,
                              ),
                            ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item['descriptor']?['name'] ?? "Unnamed",
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

                    // Add to Cart
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final product = {
                              "provider_name": providerName.isNotEmpty
                                  ? providerName
                                  : "Unknown",
                              "provider_address": "",
                              "items": [
                                {
                                  "id":
                                      item['id'] ??
                                      item['descriptor']?['id'] ??
                                      "",
                                  "name":
                                      item['descriptor']?['name'] ?? "Unnamed",
                                  "qty": 1,
                                  "price": item['price'] ?? 0,
                                },
                              ],
                            };
                            await addToGlobalCart(product);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${item['descriptor']?['name']} added to cart",
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
