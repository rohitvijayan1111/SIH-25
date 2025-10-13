import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/purchase.dart';

class PurchaseService {
  static const String baseUrl = 'http://localhost:3000/api/middlemen';

  static Future<bool> createPurchase({
    required String middlemanId,
    required String farmerId,
    required String batchId,
    required String productId,
    required int quantityKg,
    required double pricePerKg,
    String currency = 'INR',
    String paymentMode = 'UPI',
  }) async {
    try {
      // Generate purchase code
      String purchaseCode =
          'PUR-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';

      final response = await http.post(
        Uri.parse('$baseUrl/purchases'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'purchase_code': purchaseCode,
          'middleman_id': middlemanId,
          'farmer_id': farmerId,
          'batch_id': batchId,
          'product_id': productId,
          'quantity_kg': quantityKg,
          'price_per_kg': pricePerKg,
          'currency': currency,
          'payment_mode': paymentMode,
        }),
      );

      print('Purchase API Response: ${response.statusCode}');
      print('Purchase API Body: ${response.body}');

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return data['status'] == 'success';
      } else {
        final data = json.decode(response.body);
        throw Exception(data['message'] ?? 'Failed to create purchase');
      }
    } catch (e) {
      print('Error creating purchase: $e');
      throw Exception('Couldn\'t create purchase');
    }
  }

  // Get all purchases with optional filters
  static Future<List<Purchase>> getPurchases({
    String? middlemanId,
    String? farmerId,
    String? paymentStatus,
    String? deliveryStatus,
  }) async {
    try {
      String url = '$baseUrl/purchases?';

      // Add query parameters if provided
      if (middlemanId != null) url += 'middleman_id=$middlemanId&';
      if (farmerId != null) url += 'farmer_id=$farmerId&';
      if (paymentStatus != null) url += 'payment_status=$paymentStatus&';
      if (deliveryStatus != null) url += 'delivery_status=$deliveryStatus&';

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          List<Purchase> purchases = (data['data'] as List)
              .map((item) => Purchase.fromJson(item))
              .toList();
          return purchases;
        } else {
          throw Exception('API Error: ${data['message']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load purchases: $e');
    }
  }

  // Add this to your existing PurchaseService class
  static Future<bool> updatePurchase(
    String purchaseId,
    Map<String, dynamic> updateData,
  ) async {
    try {
      print(updateData);
      final response = await http.patch(
        Uri.parse('$baseUrl/purchases/$purchaseId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updateData),
      );
      print(response);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['status'] == 'success';
      } else {
        final data = json.decode(response.body);
        throw Exception(data['message'] ?? 'Failed to update purchase');
      }
    } catch (e) {
      throw Exception('Couldn\'t fetch');
    }
  }

  static Future<Purchase> getPurchaseById(String purchaseId) async {
    try {
      print('🔍 Fetching purchase: $purchaseId');

      final response = await http.get(
        Uri.parse('$baseUrl/purchases/$purchaseId'),
        headers: {'Content-Type': 'application/json'},
      );

      print('📡 Response status: ${response.statusCode}');
      print('📡 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          // ✅ HANDLE BOTH ARRAY AND OBJECT RESPONSES
          dynamic purchaseData = data['data'];

          // If data is a list, take the first item
          if (purchaseData is List && purchaseData.isNotEmpty) {
            purchaseData = purchaseData[0];
            print('📋 Data was array, using first item');
          }

          // If data is already a Map, use it directly
          if (purchaseData is Map<String, dynamic>) {
            print('✅ Data parsed successfully');
            return Purchase.fromJson(purchaseData);
          } else {
            throw Exception('Invalid data format received');
          }
        } else {
          throw Exception('API Error: ${data['message']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error in getPurchaseById: $e');
      throw Exception('Couldn\'t fetch');
    }
  }

  // Delete a purchase
  static Future<bool> deletePurchase(String purchaseId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/purchases/$purchaseId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['status'] == 'success';
      } else {
        final data = json.decode(response.body);
        throw Exception(data['message'] ?? 'Failed to delete purchase');
      }
    } catch (e) {
      throw Exception('Failed to delete purchase: $e');
    }
  }
}
