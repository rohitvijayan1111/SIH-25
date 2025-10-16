import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';

class OrderService {
  static const String baseUrl =
      'http://localhost:5000/api'; // Replace with your API URL

  // Fetch all orders for a user
  Future<List<Order>> fetchOrders({String? userId}) async {
    try {
      final url = userId != null
          ? '$baseUrl/orders?user_id=$userId'
          : '$baseUrl/order'; // ← Fixed URL consistency

      print('Fetching from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Add authentication headers if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> ordersJson = data['data'] ?? [];

        print('Orders JSON: $ordersJson');

        return ordersJson
            .map(
              (orderJson) => Order.fromJson(orderJson as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchOrders: $e');
      throw Exception('Error fetching orders: $e');
    }
  } // ← Added missing closing brace

  // Fetch single order by ID
  Future<Order> fetchOrderById(String orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders/$orderId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Order.fromJson(data['data']);
      } else {
        throw Exception('Failed to load order: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching order: $e');
    }
  } // ← Added missing closing brace

  // Reorder functionality
  Future<bool> reorder(String orderId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders/$orderId/reorder'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  } // ← Added missing closing brace

  // Report issue
  Future<bool> reportIssue(String orderId, String issue) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders/$orderId/report'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'issue': issue}),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  } // ← Added missing closing brace
}
