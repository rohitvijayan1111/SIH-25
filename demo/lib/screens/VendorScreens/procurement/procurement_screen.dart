import '../batch_list_screen.dart';
// screens/procurement_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Product Model matching your API response
class Product {
  final String id;
  final String farmerId;
  final String name;
  final String type;
  final String unit;
  final int stock;
  final bool organic;
  final String description;
  final String? imageUrl;
  final DateTime createdAt;
  final String weight;
  final double averageBatchPrice;
  final int totalBatches;

  Product({
    required this.id,
    required this.farmerId,
    required this.name,
    required this.type,
    required this.unit,
    required this.stock,
    required this.organic,
    required this.description,
    this.imageUrl,
    required this.createdAt,
    required this.weight,
    required this.averageBatchPrice,
    required this.totalBatches,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      farmerId: json['farmer_id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      unit: json['unit'] ?? '',
      stock: int.tryParse(json['tstock']?.toString() ?? '0') ?? 0,
      organic: json['organic'] ?? false,
      description: json['description'] ?? '',
      imageUrl: json['image_url'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      weight: json['weight'] ?? '0.000',
      averageBatchPrice:
          double.tryParse(json['average_batch_price']?.toString() ?? '0') ??
          0.0,
      totalBatches: int.tryParse(json['total_batches']?.toString() ?? '0') ?? 0,
    );
  }
}

// API Service for products
class ProductService {
  static final String baseUrl = '${dotenv.env['API_BASE_URL'] ?? ''}/api';
  // static const String baseUrl = 'http://localhost:3000/api';

  static Future<List<Product>> getProducts({String? type, String? name}) async {
    try {
      String url = '$baseUrl/products';
      List<String> params = [];

      if (type != null && type.isNotEmpty) {
        params.add('type=$type');
      }
      if (name != null && name.isNotEmpty) {
        params.add('name=$name');
      }

      if (params.isNotEmpty) {
        url += '?' + params.join('&');
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Couldn\'t fetch');
    }
  }
}

class ProcurementScreen extends StatefulWidget {
  final int initialTab;
  const ProcurementScreen({Key? key, this.initialTab = 0}) : super(key: key);

  @override
  _ProcurementScreenState createState() => _ProcurementScreenState();
}

class _ProcurementScreenState extends State<ProcurementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  List<String> categories = [];
  bool isLoading = true;
  String? error;
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final products = await ProductService.getProducts();

      // Filter products with non-zero batches only
      final productsWithBatches = products
          .where((p) => p.totalBatches > 0)
          .toList();

      setState(() {
        allProducts = productsWithBatches;
        filteredProducts = productsWithBatches;

        // Extract unique categories from products
        Set<String> categorySet = {'All'};
        for (var product in productsWithBatches) {
          if (product.type.isNotEmpty) {
            categorySet.add(product.type);
          }
        }
        categories = categorySet.toList();

        // Initialize TabController after we know how many categories we have
        _tabController = TabController(
          length: categories.length,
          vsync: this,
          initialIndex: widget.initialTab < categories.length
              ? widget.initialTab
              : 0,
        );
        _tabController.addListener(_onTabChanged);

        isLoading = false;
      });

      _filterProductsByCategory();
    } catch (e) {
      setState(() {
        error = "Couldn't fetch";
        isLoading = false;
      });
    }
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      setState(() {
        selectedCategory = categories[_tabController.index];
      });
      _filterProductsByCategory();
    }
  }

  void _filterProductsByCategory() {
    setState(() {
      if (selectedCategory == 'All') {
        filteredProducts = allProducts;
      } else {
        filteredProducts = allProducts
            .where((product) => product.type == selectedCategory)
            .toList();
      }
    });
  }

  // Dynamic stats calculation from actual filtered data
  int get totalProducts => filteredProducts.length;
  int get totalBatches =>
      filteredProducts.fold(0, (sum, p) => sum + p.totalBatches);
  double get avgPrice => filteredProducts.isEmpty
      ? 0.0
      : filteredProducts.fold(0.0, (sum, p) => sum + p.averageBatchPrice) /
            filteredProducts.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1E40AF),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Procurement',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: loadProducts,
          ),
        ],
        bottom: isLoading || categories.isEmpty
            ? null
            : TabBar(
                controller: _tabController,
                isScrollable: categories.length > 4,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                // padding: EdgeInsets.zero,
                // labelPadding: EdgeInsets.symmetric(horizontal: 16),
                unselectedLabelColor: Colors.white70,
                tabs: categories
                    .map((category) => Tab(text: category))
                    .toList(),
              ),
      ),
      body: Column(
        children: [
          // Dynamic Stats Row from filtered category data
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(totalProducts.toString(), 'Products'),
                _buildStatItem(
                  totalBatches.toString(),
                  'Total Batches',
                  color: Colors.orange,
                ),
                _buildStatItem('₹${avgPrice.toStringAsFixed(0)}', 'Avg Price'),
              ],
            ),
          ),

          // Content from API filtered by category
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
                          onPressed: loadProducts,
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
                : filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No products with batches found'),
                        Text('in ${selectedCategory.toLowerCase()} category'),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: loadProducts,
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
                    onRefresh: loadProducts,
                    color: Color(0xFF1E40AF),
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return _buildProcurementCard(product);
                      },
                    ),
                  ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('Create Procurement feature coming soon')),
      //     );
      //   },
      //   backgroundColor: Color(0xFF1E40AF),
      //   icon: Icon(Icons.add, color: Colors.white),
      //   label: Text(
      //     'Create Procurement',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
    );
  }

  Widget _buildStatItem(String count, String label, {Color? color}) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color ?? Color(0xFF1E40AF),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildProcurementCard(Product product) {
    // Determine status from actual product data
    String status = _getProductStatus(product);
    Color statusColor = _getStatusColor(status);
    bool hasDeadlinePassed = _checkDeadlinePassed(product);
    int daysLeft = _getDaysLeft(product);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and status from API data
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${product.name} - ${product.type}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Product details from API
            Row(
              children: [
                // Icon(Icons.scale, size: 16, color: Colors.grey.shade600),
                // SizedBox(width: 4),
                // Text(
                //   '${product.weight}${product.unit}',
                //   style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                // ),
                // SizedBox(width: 16),
                Icon(
                  Icons.currency_rupee,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 4),
                Text(
                  product.averageBatchPrice > 0
                      ? 'Average Price: ₹${product.averageBatchPrice.toStringAsFixed(0)}/${product.unit}'
                      : 'Price: TBD',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.inventory, size: 16, color: Colors.grey.shade600),
                SizedBox(width: 4),
                Text(
                  'Stock: ${product.stock} ${product.unit}',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
                Spacer(),
                // if (daysLeft > 0)
                //   Text(
                //     '$daysLeft days left',
                //     style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.green,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   )
                // else if (hasDeadlinePassed && status != 'Completed')
                //   Text(
                //     'Deadline passed',
                //     style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.red,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
              ],
            ),

            if (product.organic) ...[
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Organic',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],

            SizedBox(height: 16),

            // Action button with real batch data
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showFarmerSupplies(product);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E40AF),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(Icons.visibility, color: Colors.white, size: 18),
                label: Text(
                  'View Farmer Supplies (${product.totalBatches})',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dynamic status calculation from product data
  String _getProductStatus(Product product) {
    if (product.stock == 0) return 'Completed';
    if (product.totalBatches > 5) return 'Active';
    return 'Available';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Color(0xFF1E40AF);
      case 'available':
        return Colors.green;
      case 'completed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  // Calculate deadline from creation date (example: 30 days from creation)
  bool _checkDeadlinePassed(Product product) {
    final deadline = product.createdAt.add(Duration(days: 30));
    return DateTime.now().isAfter(deadline);
  }

  int _getDaysLeft(Product product) {
    final deadline = product.createdAt.add(Duration(days: 30));
    final difference = deadline.difference(DateTime.now()).inDays;
    return difference > 0 ? difference : 0;
  }

  // void _showFarmerSupplies(Product product) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) => DraggableScrollableSheet(
  //       initialChildSize: 0.7,
  //       maxChildSize: 0.9,
  //       minChildSize: 0.5,
  //       builder: (context, scrollController) => Container(
  //         padding: EdgeInsets.all(20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Text(
  //                     'Farmer Supplies for ${product.name}',
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 IconButton(
  //                   onPressed: () => Navigator.pop(context),
  //                   icon: Icon(Icons.close),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 16),
  //             Container(
  //               padding: EdgeInsets.all(16),
  //               decoration: BoxDecoration(
  //                 color: Color(0xFF1E40AF).withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Product Details - ${product.type} Category',
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.bold,
  //                       color: Color(0xFF1E40AF),
  //                     ),
  //                   ),
  //                   SizedBox(height: 8),
  //                   Text('Available Batches: ${product.totalBatches}'),
  //                   Text(
  //                     'Average Price: ₹${product.averageBatchPrice.toStringAsFixed(2)}/${product.unit}',
  //                   ),
  //                   Text('Stock Available: ${product.stock} ${product.unit}'),
  //                   Text('Category: ${product.type}'),
  //                   if (product.organic) Text('✓ Organic Certified'),
  //                   SizedBox(height: 8),
  //                   Text(
  //                     'Description:',
  //                     style: TextStyle(fontWeight: FontWeight.w500),
  //                   ),
  //                   Text(product.description),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: 16),
  //             Expanded(
  //               child: Center(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(
  //                       Icons.agriculture,
  //                       size: 64,
  //                       color: Colors.grey.shade400,
  //                     ),
  //                     SizedBox(height: 16),
  //                     Text(
  //                       'Detailed batch information',
  //                       style: TextStyle(
  //                         color: Colors.grey.shade600,
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                     Text(
  //                       'and farmer details will be shown here',
  //                       style: TextStyle(
  //                         color: Colors.grey.shade600,
  //                         fontSize: 14,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showFarmerSupplies(Product product) {
    // Navigate to batch list screen instead of showing modal
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BatchListScreen(productName: product.name),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
