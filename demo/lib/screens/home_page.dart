import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../global.dart';
import 'product_details.dart'; // Create this screen
import 'package:demo/components/category_section.dart'; // Create this component
import 'package:demo/global.dart';

const String SERVER_URL = Globals.SERVER_URL_BAP;

// Define the data models to handle the API response
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
      ]);
      setState(() {
        categories = results;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
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
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
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
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Category List Section
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                final categoryItem = categoryList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton(
                    onPressed: () => _handleCategoryPress(
                      categoryItem['id']!,
                      categoryItem['name']!,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 1,
                    ),
                    child: Text(
                      categoryItem['name']!,
                      style: TextStyle(color: Colors.green[800]),
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
                        const Divider(height: 1, color: Colors.grey),
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
