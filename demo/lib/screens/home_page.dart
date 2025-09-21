
// import 'dart:convert';

// import 'package:demo/global.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class InventoryItem {
//   final String batchId;
//   final String batchCode;
//   final String productId;
//   final String productName;
//   final String productType;
//   final String farmerId;
//   final String farmerName;
//   final String availableQty;
//   final String unit;
//   final String pricePerUnit;
//   final int batchQuantity;
//   final DateTime manufacturedOn;
//   final DateTime expiryDate;
//   final DateTime harvestDate;
//   final String locationName;
//   final double geoLat;
//   final double geoLon;
//   final String status;
//   final String metaHash;
//   final String? chainTx;

//   InventoryItem({
//     required this.batchId,
//     required this.batchCode,
//     required this.productId,
//     required this.productName,
//     required this.productType,
//     required this.farmerId,
//     required this.farmerName,
//     required this.availableQty,
//     required this.unit,
//     required this.pricePerUnit,
//     required this.batchQuantity,
//     required this.manufacturedOn,
//     required this.expiryDate,
//     required this.harvestDate,
//     required this.locationName,
//     required this.geoLat,
//     required this.geoLon,
//     required this.status,
//     required this.metaHash,
//     this.chainTx,
//   });

//   factory InventoryItem.fromJson(Map<String, dynamic> json) {
//     return InventoryItem(
//       batchId: json['batch_id'],
//       batchCode: json['batch_code'],
//       productId: json['product_id'],
//       productName: json['product_name'],
//       productType: json['product_type'],
//       farmerId: json['farmer_id'],
//       farmerName: json['farmer_name'],
//       availableQty: json['available_qty'],
//       unit: json['unit'],
//       pricePerUnit: json['price_per_unit'],
//       batchQuantity: json['batch_quantity'],
//       manufacturedOn: DateTime.parse(json['manufactured_on']),
//       expiryDate: DateTime.parse(json['expiry_date']),
//       harvestDate: DateTime.parse(json['harvest_date']),
//       locationName: json['location_name'],
//       geoLat: (json['geo_lat'] as num).toDouble(),
//       geoLon: (json['geo_lon'] as num).toDouble(),
//       status: json['status'],
//       metaHash: json['meta_hash'],
//       chainTx: json['chain_tx'],
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<InventoryItem> inventory_items_for_category = [];
//   Map<String, Map<String, List<InventoryItem>>> allCategories = {};
//   Map<String, Map<String, List<InventoryItem>>> selectedCategory={}
//   List<InventoryItem> searchedItems = [];
//   bool isLoading = true;

//   bool isLoadingCategory = false;
//   String searchTerm = "";
//   final TextEditingController _searchController = TextEditingController();

//   final List<Map<String, String>> categoryList = [
//     {
//       'id': 'seed',
//       'name': 'Seeds',
//       'image': 'assets/FarmerUIAssets/images/seeds.png',
//     },
//     {
//       'id': 'micro',
//       'name': 'Micro Nutrient',
//       'image': 'assets/FarmerUIAssets/images/micronutrients.png',
//     },
//     {
//       'id': 'fertilizer',
//       'name': 'Fertilizer',
//       'image': 'assets/FarmerUIAssets/images/fertilizer.png',
//     },
//     {
//       'id': 'fungicide',
//       'name': 'Fungicide',
//       'image': 'assets/FarmerUIAssets/images/fungicide.png',
//     },
//     {
//       'id': 'growth_promoter',
//       'name': 'Growth Promoter',
//       'image': 'assets/FarmerUIAssets/images/growthpromoter.png',
//     },
//     {
//       'id': 'growth_regulator',
//       'name': 'Growth Regulators',
//       'image': 'assets/FarmerUIAssets/images/growthregulator.png',
//     },
//     {
//       'id': 'herbicide',
//       'name': 'Herbicide',
//       'image': 'assets/FarmerUIAssets/images/herbicide.png',
//     },
//     {
//       'id': 'land',
//       'name': 'Land Lease & Sale',
//       'image': 'assets/FarmerUIAssets/images/landlease.png',
//     },
//   ];
//   @override
//   void initState() {
//     super.initState();
//     _loadInitialCategories();
//   }

//   Future<void> _loadInitialCategories() async {
//     setState(() => isLoading = true);

//     try {
//       final results =
//           await Future.wait<Map<String, Map<String, List<InventoryItem>>>>([
//             _fetchCategoryProducts("seed"),
//             _fetchCategoryProducts("fertilizer"),
//             _fetchCategoryProducts("fungicide"),
//             _fetchCategoryProducts("herbicide"),
//           ]);

//       // Merge all maps into one
//       final Map<String, Map<String, List<InventoryItem>>> categoryMap = {};
//       for (var result in results) {
//         categoryMap.addAll(result);
//       }

//       // Now build trending
//       final List<InventoryItem> trending = [];
//       for (var categoryEntry in categoryMap.entries) {
//         for (var productEntry in categoryEntry.value.entries) {
//           trending.addAll(productEntry.value.take(2));
//         }
//       }

//       debugPrint("🔥 Trending count: ${trending.length}");

//       setState(() {
//         // keep both trending + full categories
//         inventory_items_for_category = trending;
//         allCategories = categoryMap; // <-- store the full map in state
//       });
//     } catch (e) {
//       debugPrint("❌ Error loading initial categories: $e");
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   Future<Map<String, Map<String, List<InventoryItem>>>> _fetchCategoryProducts(
//     String category,
//   ) async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//           '${Globals.SERVER_URL_BPP}/api/batches?product_type=$category',
//         ),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode != 200) {
//         throw Exception('HTTP error! Status: ${response.statusCode}');
//       }

//       final jsonResponse = jsonDecode(response.body);
//       final List<dynamic> inventoryJson = jsonResponse['inventory'] ?? [];

//       final Map<String, List<InventoryItem>> grouped = {};

//       for (var itemJson in inventoryJson) {
//         final item = InventoryItem.fromJson(itemJson);
//         grouped.putIfAbsent(item.productName, () => []);
//         grouped[item.productName]!.add(item);
//       }

//       // 👇 wrap it with category key
//       return {category: grouped};
//     } catch (error) {
//       debugPrint("❌ Error fetching $category products: $error");
//       return {category: {}};
//     }
//   }

//   Future<void> _searchProducts(String query) async {
//     if (query.trim().isEmpty) {
//       setState(() {
//         searchedItems.clear();
//       });
//       return;
//     }

//     setState(() {
//       isLoading = true;
//       searchedItems.clear();
//     });

//     try {
//       final lowerQuery = query.toLowerCase();
//       final List<InventoryItem> matches = [];

//       allCategories.forEach((category, productMap) {
//         productMap.forEach((productName, items) {
//           for (var item in items) {
//             // Check all fields
//             if (item.batchId.toLowerCase().contains(lowerQuery) ||
//                 item.batchCode.toLowerCase().contains(lowerQuery) ||
//                 item.productId.toLowerCase().contains(lowerQuery) ||
//                 item.productName.toLowerCase().contains(lowerQuery) ||
//                 item.productType.toLowerCase().contains(lowerQuery) ||
//                 item.farmerId.toLowerCase().contains(lowerQuery) ||
//                 item.farmerName.toLowerCase().contains(lowerQuery) ||
//                 item.availableQty.toLowerCase().contains(lowerQuery) ||
//                 item.unit.toLowerCase().contains(lowerQuery) ||
//                 item.pricePerUnit.toLowerCase().contains(lowerQuery) ||
//                 item.batchQuantity.toString().contains(lowerQuery) ||
//                 item.manufacturedOn.toString().toLowerCase().contains(
//                   lowerQuery,
//                 ) ||
//                 item.expiryDate.toString().toLowerCase().contains(lowerQuery) ||
//                 item.harvestDate.toString().toLowerCase().contains(
//                   lowerQuery,
//                 ) ||
//                 item.locationName.toLowerCase().contains(lowerQuery) ||
//                 item.geoLat.toString().contains(lowerQuery) ||
//                 item.geoLon.toString().contains(lowerQuery) ||
//                 item.status.toLowerCase().contains(lowerQuery) ||
//                 item.metaHash.toLowerCase().contains(lowerQuery) ||
//                 (item.chainTx?.toLowerCase().contains(lowerQuery) ?? false)) {
//               matches.add(item);
//             }
//           }
//         });
//       });

//       setState(() {
//         searchedItems = matches;
//       });

//       debugPrint("✅ Found ${searchedItems.length} items for '$query'");
//     } catch (error) {
//       debugPrint("❌ Error searching items: $error");
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   Widget _buildCategoryCard(Map<String, String> categoryItem) {
//     return GestureDetector(
//       onTap: () =>
//           _handleCategoryPress(categoryItem['id']!, categoryItem['name']!),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade200,
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Replace decorated icon with image loading from asset
//             Container(
//               height: 40,
//               width: 40,
//               padding: const EdgeInsets.all(6),
//               child: Image.asset(categoryItem['image']!, fit: BoxFit.contain),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               categoryItem['name']!,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// Future<void> _handleCategoryPress(String category) async {
//   setState(() => isLoadingCategory = true);

//   try {
//     // Get the category data from allCategories
//     final categoryData = allCategories[category];

//     if (categoryData == null) {
//       debugPrint("❌ Category '$category' not found in allCategories.");
//       return;
//     }

//     // Store the selected category in selectedCategory
//     setState(() {
//       selectedCategory[category] = categoryData;
//     });

//     debugPrint("✅ Selected category '$category' has ${categoryData.length} products.");
//   } catch (error) {
//     debugPrint("❌ Error selecting category '$category': $error");
//   } finally {
//     setState(() => isLoadingCategory = false);
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(child: CircularProgressIndicator(color: Colors.green)),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.green.shade50,
//       appBar: AppBar(
//         title: const Text(
//           'Home',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF2e7d32), Color(0xFF66bb6a)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.green.shade100, Colors.green.shade200],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     onChanged: (value) => setState(() => searchTerm = value),
//                     decoration: InputDecoration(
//                       hintText: "Search products...",
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                         borderSide: BorderSide.none,
//                       ),
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Colors.green.shade700,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () => _searchProducts(searchTerm),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green.shade700,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 12,
//                     ),
//                   ),
//                   child: const Text(
//                     "Search",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           //New
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//             child: GridView.builder(
//               itemCount: categoryList.length,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 0.78, // Slightly taller cards!
//               ),
//               itemBuilder: (context, index) =>
//                   _buildCategoryCard(categoryList[index]),
//             ),
//           ),

//           // Products
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Column(
//                 children: categories.map<Widget>((section) {
//                   return CategorySection(
//                     category: section.category,
//                     items: section.items,
//                     providers: section.providers,
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CategorySection extends StatelessWidget {
//   final String category;
//   final Map<String, List<InventoryItem>> products; // productName -> List<InventoryItem>

//   const CategorySection({
//     super.key,
//     required this.category,
//     required this.products,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (products.isEmpty) {
//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text(
//           "No products available in $category",
//           style: const TextStyle(color: Colors.grey),
//         ),
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Text(
//             category,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 220,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: products.entries.map((entry) {
//               final productName = entry.key;
//               final productItems = entry.value;

//               // Get first item for display (for image, provider, etc.)
//               final firstItem = productItems.first;

//               // Provider name
//               final providerName = firstItem.farmerName;

//               // Image URL from descriptor if available
//               String? imageUrl;
//               if (firstItem is InventoryItem) {
//                 // Replace with your logic if InventoryItem has image field
//                 imageUrl = firstItem.metaHash; // Example placeholder
//               }

//               return GestureDetector(
//                 onTap: () {
//                   // Navigate to product details with full list
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => ProductDetailsScreen(
//                         productName: productName,
//                         items: productItems,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 160,
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade300,
//                         blurRadius: 5,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Image
//                       Container(
//                         height: 100,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(12),
//                           ),
//                           color: Colors.green[100],
//                         ),
//                         child: imageUrl != null
//                             ? Image.network(
//                                 imageUrl,
//                                 fit: BoxFit.cover,
//                               )
//                             : const Icon(
//                                 Icons.shopping_bag,
//                                 size: 60,
//                                 color: Colors.green,
//                               ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           productName,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                           providerName,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ProductDetailsScreen extends StatelessWidget {
//   final String productName;
//   final List<InventoryItem> items;

//   const ProductDetailsScreen({
//     super.key,
//     required this.productName,
//     required this.items,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(productName),
//         backgroundColor: Colors.green,
//       ),
//       body: items.isEmpty
//           ? const Center(
//               child: Text(
//                 "No items available",
//                 style: TextStyle(color: Colors.grey, fontSize: 16),
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 final item = items[index];
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade300,
//                         blurRadius: 5,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Product info
//                       Text(
//                         "Batch: ${item.batchCode}",
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 14),
//                       ),
//                       const SizedBox(height: 4),
//                       Text("Farmer: ${item.farmerName}"),
//                       Text("Available Qty: ${item.availableQty} ${item.unit}"),
//                       Text("Price per Unit: ₹${item.pricePerUnit}"),
//                       Text(
//                           "Manufactured On: ${item.manufacturedOn.toLocal().toString().split(' ')[0]}"),
//                       Text(
//                           "Expiry Date: ${item.expiryDate.toLocal().toString().split(' ')[0]}"),
//                       Text(
//                           "Harvest Date: ${item.harvestDate.toLocal().toString().split(' ')[0]}"),
//                       Text("Location: ${item.locationName}"),
//                       const SizedBox(height: 8),
//                       // Add to cart button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Call your addToCart function
//                             // Example:
//                             // addToCart(item);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                     "${item.productName} from ${item.farmerName} added to cart"),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 10),
//                           ),
//                           child: const Text(
//                             "Add to Cart",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }