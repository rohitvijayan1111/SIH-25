import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/CustomerScreens/models/product_model.dart';

class ProductService {
  static const String baseUrl = 'http://localhost:3000/api/products';

  // For Android emulator, use: http://10.0.2.2:3000/api/products
  // For iOS simulator, use: http://localhost:3000/api/products
  // For real device, use your computer's IP: http://192.168.x.x:3000/api/products

  /// Get all products from the API
  static Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?show=true'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to connect to server: $e');
    }
  }

  /// Get products filtered by type
  static Future<List<Product>> getProductsByType(String type) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?type=$type'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load filtered products: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching filtered products: $e');
      throw Exception('Failed to connect to server: $e');
    }
  }

  /// Search products by name
  static Future<List<Product>> searchProducts(String name) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?name=$name'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching products: $e');
      throw Exception('Failed to connect to server: $e');
    }
  }

  /// Get a single product by ID
  static Future<Product> getProductById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Product.fromJson(jsonData);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching product by ID: $e');
      throw Exception('Failed to connect to server: $e');
    }
  }

  /// Get products with multiple filters
  static Future<List<Product>> getFilteredProducts({
    String? type,
    String? name,
    int? limit,
  }) async {
    try {
      String url = baseUrl;
      List<String> queryParams = [];

      if (type != null && type.isNotEmpty) {
        queryParams.add('type=$type');
      }
      if (name != null && name.isNotEmpty) {
        queryParams.add('name=$name');
      }
      if (limit != null) {
        queryParams.add('limit=$limit');
      }

      if (queryParams.isNotEmpty) {
        url += '?${queryParams.join('&')}';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load filtered products: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching filtered products: $e');
      throw Exception('Failed to connect to server: $e');
    }
  }
}
