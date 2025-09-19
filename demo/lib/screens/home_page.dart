import 'dart:convert';

import 'package:demo/components/category_section.dart'; // Create this component
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global.dart';

const String SERVER_URL = Globals.SERVER_URL_BAP;


// Define the data models to handle the API respons
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
  List<dynamic> categories = [];
  bool isLoading = true;
  String searchTerm = "";

  // The category list from your React Native code
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
    setState(() {
      isLoading = true;
    });

    try {
      final results = await Future.wait([
        _fetchCategoryProducts("seed"),
        _fetchCategoryProducts("fertilizer"),
        _fetchCategoryProducts("Fungicide"),
        _fetchCategoryProducts("Herbicide"),
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
      print("Error loading initial categories: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<CategoryData> _fetchCategoryProducts(String category) async {
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
      // print("📩 Raw Response for category $category:");
      // print(response.body);

      if (response.statusCode != 200) {
        throw Exception('HTTP error! Status: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final catalog = jsonResponse['catalog'];
      print("\nprovidersssss\n");
      print(catalog['providers'][0]);

      if (catalog == null) {
        throw Exception('Invalid ONDC /on_search response format.');
      }

      return CategoryData(
        category: category.toUpperCase(),
        items: catalog['items'] ?? [],
        providers: catalog['providers'] ?? [],
      );
    } catch (error) {
      print("❌ Error fetching $category products: $error");
      return CategoryData(
        category: category.toUpperCase(),
        items: [],
        providers: [],
      );
    }
  }

  Future<void> _searchProductsByName(String name) async {
    if (name.trim().isEmpty) {
      _loadInitialCategories(); // fallback
      return;
    }

    setState(() {
      isLoading = true;
    });

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

      // print("📩 Raw Response for search term: $name");
      // print(response.body);

      final jsonResponse = jsonDecode(response.body);
      final catalog = jsonResponse['catalog'];

      setState(() {
        categories = [
          CategoryData(
            category: 'Results for "$name"',
            items: catalog?['items'] ?? [],
            providers: catalog?['providers'] ?? [],
          ),
        ];
      });
    } catch (error) {
      print("❌ Error searching product name: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleCategoryPress(
    String categoryID,
    String categoryName,
  ) async {
    setState(() {
      isLoading = true;
    });

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

      print("📩 Raw Response for category $categoryID:");
      print(response.body);

      if (response.statusCode != 200) {
        throw Exception('HTTP error! Status: ${response.statusCode}');
      }

      final jsonResponse = jsonDecode(response.body);
      final catalog = jsonResponse['catalog'];

      if (catalog == null) {
        throw Exception('Invalid /on_search response format. Missing catalog.');
      }

      setState(() {
        categories = [
          CategoryData(
            category: categoryName,
            items: catalog['items'] ?? [],
            providers: catalog['providers'] ?? [],
          ),
        ];
      });
    } catch (error) {
      print("❌ Error fetching category \"$categoryName\": $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.green),
              SizedBox(height: 12),
              Text("Loading products...", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.green.shade50, // light background green
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
              colors: [
                Color(0xFF2e7d32),
                Color(0xFF66bb6a),
              ], // dark → light green
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar Section
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
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: searchTerm),
                    onChanged: (value) => setState(() => searchTerm = value),
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      hintStyle: TextStyle(color: Colors.green.shade600),
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
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
                    elevation: 3,
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

          // Category List Section
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
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
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

          // Content Section (Product List)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: categories.asMap().entries.map((entry) {
                  final index = entry.key;
                  final section = entry.value;
                  return Column(
                    children: [
                      CategorySection(
                        category: section.category,
                        items: section.items,
                        providers: section.providers,
                      ),
                      if (index < categories.length - 1)
                        Divider(height: 1, color: Colors.green.shade200),
                    ],
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
