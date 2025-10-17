import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/batch_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BatchService {
  static final String baseUrl = '${dotenv.env['API_BASE_URL'] ?? ''}/api';

  static Future<List<BatchHistoryItem>> getAllBatches() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/batches'),
        headers: {'Content-Type': 'application/json'},
      );

      print(
        'Get All Batches Response: ${response.statusCode} - ${response.body}',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['inventory'] != null) {
          List<BatchHistoryItem> batches = (data['inventory'] as List)
              .map((item) => BatchHistoryItem.fromJson(item))
              .toList();
          return batches;
        } else {
          return [];
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching all batches: $e');
      throw Exception('Could not fetch batches: $e');
    }
  }

  // NEW METHOD: Get certificate count for a batch
  static Future<int> getCertificateCount(String batchId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/certificate/$batchId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final certificates = data['certificates'] ?? [];
        return certificates.length;
      } else {
        return 0;
      }
    } catch (e) {
      print('Error fetching certificate count: $e');
      return 0;
    }
  }

  // NEW METHOD: Update batch status
  static Future<bool> updateBatchStatus(String batchId, String status) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/batches/$batchId/status'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'status': status}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error updating batch status: $e");
      return false;
    }
  }

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
