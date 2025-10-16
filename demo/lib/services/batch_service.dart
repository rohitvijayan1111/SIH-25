import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/batch_model.dart';

class BatchService {
  static const String baseUrl = 'http://localhost:3000/api';

  static Future<List<Batch>> getBatchesByProductName(String productName) async {
    try {
      print(
        Uri.parse(
          '$baseUrl/batches/product/${Uri.encodeComponent(productName)}',
        ),
      );
      final response = await http.get(
        Uri.parse(
          '$baseUrl/batches/product/${Uri.encodeComponent(productName)}',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          List<Batch> batches = (data['data'] as List)
              .map((item) => Batch.fromJson(item))
              .toList();
          return batches;
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch batches');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Couldn\'t fetch');
    }
  }

  static Future<bool> splitBatchBeforePurchase({
    required String batchId,
    required int splitQty,
    required String unit,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/batches/$batchId/split'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'split_qty': splitQty, 'unit': unit}),
      );

      print("Split Batch Response: ${response.statusCode} - ${response.body}");

      return response.statusCode == 201;
    } catch (e) {
      print("Error splitting batch: $e");
      return false;
    }
  }
}
