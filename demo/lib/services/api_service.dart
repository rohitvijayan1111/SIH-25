import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'package:demo/models/batch_model.dart';

class ApiService {
  // static const String baseUrl = 'http://10.0.2.2:3000/api'; // Android emulator
  // Use 'http://localhost:3000/api' for iOS simulator
  // Use your actual IP address for physical device

  // Get available products for dropdown

  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  static Future<List<Product>> getProducts() async {
    // print(":" + baseUrl);
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/api/batches/product/categories'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List productsData = data['products'] ?? [];

        return productsData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Submit batch to backend
  static Future<BatchSubmissionResult> createBatch(
    BatchFormData formData,
  ) async {
    try {
      print(formData);
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/batches'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(formData.toJson()),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return BatchSubmissionResult(
          success: true,
          batchCode: data['batch']['batch_code'],
          batchId: data['batch']['id'],
          message: data['message'],
        );
      } else {
        final error = json.decode(response.body);
        return BatchSubmissionResult(
          success: false,
          error: error['error'] ?? 'Unknown error occurred',
        );
      }
    } catch (e) {
      return BatchSubmissionResult(success: false, error: 'Network error: $e');
    }
  }

  static Future<List<Batch>> getBatchesForProduct(String productId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/batches'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List batches = data['inventory'] ?? [];
      // Debug print to check product_id values
    for (var batch in batches) {
      print("Batch product_id: ${batch['product_id']}");
    }
      return batches
          .where((b) => b['product_id'] != null && b['product_id'] == productId)
          .map<Batch>((json) => Batch.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load batches');
    }
  }
}

class BatchSubmissionResult {
  final bool success;
  final String? batchCode;
  final String? batchId;
  final String? message;
  final String? error;

  BatchSubmissionResult({
    required this.success,
    this.batchCode,
    this.batchId,
    this.message,
    this.error,
  });
}
